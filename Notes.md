

# Migration Client:

<?php
use Illuminate\\Database\\Migrations\\Migration;
use Illuminate\\Database\\Schema\\Blueprint;
use Illuminate\\Support\\Facades\\Schema;


return new class extends Migration
{



    public function up(): void
    {

        Schema::create('clients', function (Blueprint $table) {

        $table->id();
        $table->string("nom");
        $table->string("email")->unique();
        $table->string("password");
        $table->rememberToken();
        $table->timestamps();
        });
    }


    public function down(): void
    {

    Schema::dropIfExists('clients');

    }

};


#############
App/Models/Client.php :

<?php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;

class Client extends Authenticatable {

    protected $fillable = ["nom", "email", "password"];
    protected $hidden = ["password", "remember_token"];

}



#################
config/auth.php : 


'guards' => [
    'web' => [
        'driver' => 'session',
        'provider' => 'users',
    ],
    'client' => [
        'driver' => 'session',
        'provider' => 'clients'
    ]

],



'providers' => [
    'users' => [
        'driver' => 'eloquent',
        'model' => env('AUTH_MODEL', App\Models\User::class),

    ],
    'clients' => [
        'driver' => 'eloquent',
        'model' => App\Models\Client::class
    ],

    ???

    'users' => [
        'driver' => 'database',
        'table' => 'users',
    ],

]



###################
 Ajouter les Vues :


value = {{ old('nom') }} pour les inputs gardent anciennes valeurs

 Ajout d'un bouton inscription dans le nav:  <a class="btn btn-outline-accent position-relative" href="{{ route('auth.registerForm')}}">Register</a> / similaire

/views/auth : register.blade.php / Ajouter name='' (nom, email, password, name pour conf = password_confimation) a chaque input, changer action="{{route}}... / 

## Dans vue: @auth("client") pour verifier si connecter et @guest("client") pour l'inverse / ("client") a cause du Guard (faux User / Est vrai Client)



####################
Controller: AuthController 

<?php

namespace App\Http\Controllers;

use App\Models\Client;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller {



    public function registerForm() {
        return view('auth.register');
    }


    public function loginForm() {
        return view("auth.login");
    }

    public function register(Request $request) {

        // Valider form

        $donnees = $request->validate([
            "nom" => "required|string|max:255",
            "email" => "required|email|max:255|unique:clients",
            "password" => "required|min:8|confirmed"
            ],[
                "nom.required" => "Le champ est requis",
                "nom.string" => "Le nom doit être écrit de façon alphanumérique"
            ]);

        // Crée objet client / persist() BDD
        $client = new Client();
        $client->nom = $donnees["nom"];
        $client->email = $donnees["email"];
        $client->password = Hash::make($donnees["password"]);
        $client->save();

        // le logger

        Auth::guard("client")->login($client);
        // Redirige accueil

        return redirect()->route("accueil")->with("succes", "Vous êtes désormais connecté");
    }



    public function login(Request $request) {

        $donnees = $request->validate([
        "email" => "required|email|max:255",
        "password" => "required"
         ]);

        // Essayer de connecter

        if (Auth::guard("client")->attempt($donnees)) {
            $request->session()->regenerate();
            return redirect()->intended(route("accueil"));
        }
        return back()->withErrors(["email" => "Le courriel ou le mot de passe est invalide"]);

                            ?? PAS @error() mais if(session(`email`));
    }


    public function logout(Request $request) {
        Auth::guard("client")->logout();
        $request->session()->invalidate();
        $request->session()->regenerateToken();

        return redirect()->route("accueil")->with("succes", "Vous êtes déconnecter");
    }

}


#####################
Web.php :


Route::get("/register", [AuthController::class, "registerForm"])
    ->middleware("guest:client")
    ->name("auth.registerForm");



Route::post("/register", [AuthController::class, "register"])->name("auth.register");

 
 ?? NOM LOGIN NECESSAIRE 
Route::get("/login", [AuthController::class, "loginForm"])->name("auth.loginForm");


Route::post("/login", [AuthController::class, "login"])
    ->middleware("throttle:5, 1")
->name("auth.login");


Route::post("/logout", [AuthController::class, "logout"])->name("auth.logout)





###

logout doit être dans un mini form avec un bouton.

dans @auth("client") -> {{ Auth::guard("client")->user()->nom }}

// Proteger UNE route (middlewares)
    ex: Route::post("/logout", [AuthController::class, "logout"])
        ->middleware("auth:client")
        ->name("auth.logout);

// PLUSIEURS ROUTES
    Route::middleware("guest:client")->group(function() {

        LES ROUTES SONT ICI.

    });


                                                                            // Nom
// Form Request au lieu de $request->validate() // php artisan make:request LoginRequest
  

    fonction login(LoginRequest $request) {
        $donnees = $request->validateD();
    }

    function register(RegisterRequest $request) {
        $donnees = $request->validateD();
    }


    // Crée authorize, rules, (messages si on veut)

    // rules: array 
    [
        "email" => "required|email|max:255",
        "password" => "required", etc.
    ]

    public function messages() {
        return [
            "email.required" => "Courriel obligatoire"
            "email.email" => "Courriel doit être un courriel"
            "email.max" => "Nombre maximum de caractère :max 
        ]
    }