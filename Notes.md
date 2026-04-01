# \###################

# Migration Client:

###### 

###### 

### <?php

### 

### use Illuminate\\Database\\Migrations\\Migration;

### use Illuminate\\Database\\Schema\\Blueprint;

### use Illuminate\\Support\\Facades\\Schema;

### 

### return new class extends Migration

### {

### &#x20;   /\*\*

### &#x20;    \* Run the migrations.

### &#x20;    \*/

### &#x20;   public function up(): void

### &#x20;   {

### &#x20;       Schema::create('clients', function (Blueprint $table) {

### &#x20;           $table->id();

### &#x20;           $table->string("nom");

### &#x20;           $table->string("email")->unique();

### &#x20;           $table->string("password");

### &#x20;           $table->rememberToken();

### &#x20;           $table->timestamps();

### &#x20;       });

### &#x20;   }

### 

### &#x20;   /\*\*

### &#x20;    \* Reverse the migrations.

### &#x20;    \*/

### &#x20;   public function down(): void

### &#x20;   {

### &#x20;       Schema::dropIfExists('clients');

### &#x20;   }

};


#############
App/Models/Client.php :

<?php
===

### 

### namespace App\\Models;

### 

### use Illuminate\\Foundation\\Auth\\User as Authenticatable;

### 

### class Client extends Authenticatable

### {

### &#x20;   protected $fillable = \["nom", "email", "password"];

### 

### &#x20;   protected $hidden = \["password", "remember\_token"];

### }

# 

\#################
config/auth.php : 


'guards' => \[
===

# &#x20;       'web' => \[

# &#x20;           'driver' => 'session',

# &#x20;           'provider' => 'users',

# &#x20;       ],

# &#x20;       'client' => \[

# &#x20;           'driver' => 'session',

# &#x20;           'provider' => 'clients'

# &#x20;       ]

&#x20;   ],

===

# 

# 

# 'providers' => \[

# &#x20;       'users' => \[

# &#x20;           'driver' => 'eloquent',

# &#x20;           'model' => env('AUTH\_MODEL', App\\Models\\User::class),

# &#x20;       ],

# &#x20;       'clients' => \[

# &#x20;           'driver' => 'eloquent',

# &#x20;           'model' => App\\Models\\Client::class

# &#x20;       ]

# 

# &#x20;       // 'users' => \[

# &#x20;       //     'driver' => 'database',

# &#x20;       //     'table' => 'users',

# &#x20;       // ],

&#x20;   ]



###################
 Ajouter les Vues :
===

# 

value = {{ old('nom') }} pour les inputs gardent anciennes valeurs

 Ajout d'un bouton inscription dans le nav:  <a class="btn btn-outline-accent position-relative" href="{{ route('auth.registerForm')}}">Register</a> / similaire

/views/auth : register.blade.php / Ajouter name='' (nom, email, password, name pour conf = password\\\\\\\_confimation) a chaque input, changer action="{{route}}... / 

===



## Dans vue: @auth("client") pour verifier si connecter et @guest("client") pour l'inverse / ("client") a cause du Guard (faux User / Est vrai Client)

# 

# 

# 

# 

\####################
Controller: AuthController 
===


<?php
===

# 

# namespace App\\Http\\Controllers;

# 

# use App\\Models\\Client;

# use Illuminate\\Http\\Request;

# use Illuminate\\Support\\Facades\\Auth;

# use Illuminate\\Support\\Facades\\Hash;

# 

# class AuthController extends Controller

# {

# 

# &#x20;   /\*\*

# &#x20;    \* Affiche le formulaire d'inscription

# &#x20;    \*

# &#x20;    \* @return View

# &#x20;    \*/

# &#x20;   public function registerForm() {

# &#x20;       return view('auth.register');

# &#x20;   }

# 

# 

# &#x20;   /\*\*

# &#x20;    \* Affiche le formulaire de connexion

# &#x20;    \*

# &#x20;    \* @return View

# &#x20;    \*/

# &#x20;   public function loginForm() {

# &#x20;       return view("auth.login");

# &#x20;   }

# 

# &#x20;   /\*\*

# &#x20;    \* Traite le formulaire d'inscription

# &#x20;    \*

# &#x20;    \* @param Request $request

# &#x20;    \* @return Redirect

# &#x20;    \*/

# &#x20;   public function register(Request $request) {

# &#x20;       // Valider form

# &#x20;       $donnees = $request->validate(\[

# &#x20;           "nom" => "required|string|max:255",

# &#x20;           "email" => "required|email|max:255|unique:clients",

# &#x20;           "password" => "required|min:8|confirmed"

# 

# &#x20;       ],\[

# &#x20;           "nom.required" => "Le champ est requis",

# &#x20;           "nom.string" => "Le nom doit être écrit de façon alphanumérique"

# &#x20;       ]);

# &#x20;       // Crée objet client / persist() BDD

# 

# &#x20;       $client = new Client();

# 

# &#x20;       $client->nom = $donnees\["nom"];

# &#x20;       $client->email = $donnees\["email"];

# &#x20;       $client->password = Hash::make($donnees\["password"]);

# 

# &#x20;       $client->save();

# &#x20;       // le logger

# &#x20;       Auth::guard("client")->login($client);

# 

# &#x20;       // Redirige accueil

# &#x20;       return redirect()->route("accueil")->with("succes", "Vous êtes désormais connecté");

# &#x20;   }

# 

# &#x20;   /\*\*

# &#x20;    \* Traite le formulaire de connexion

# &#x20;    \*

# &#x20;    \* @param Request $request

# &#x20;    \* @return Redirect

# &#x20;    \*/

# &#x20;   public function login(Request $request) {

# &#x20;       $donnees = $request->validate(\[

# &#x20;           "email" => "required|email|max:255",

# &#x20;           "password" => "required"

# &#x20;       ]);

# 

# &#x20;       // Essayer de connecter

# &#x20;       if (Auth::guard("client")->attempt($donnees)) {

# &#x20;          $request->session()->regenerate();

# &#x20;          return redirect()->intended(route("accueil"));

# &#x20;       }

# 

# &#x20;       return back()->withErrors(\["email" => "Le courriel ou le mot de passe est invalide"]);

# 

# &#x20;   }

# }





### ////////////////////////////////////////////////











###### 

\#####################
Web.php :


===

# Route::get("/register", \[AuthController::class, "registerForm"])->name("auth.registerForm");

# 

Route::post("/register", \[AuthController::class, "register"])->name("auth.register");

===

# 

# Route::get("/login", \[AuthController::class, "loginForm"])->name("auth.loginForm");

# 

# Rouge::post("/login", \[AuthController::class, "login"])->name("auth.login");

# 







===

