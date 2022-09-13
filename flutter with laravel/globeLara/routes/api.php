<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\StudentController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

// get the database data
Route::get('users', [StudentController::class, 'index']);

// save database
Route::post('saved', [StudentController::class, 'saveData']);

//updata database
Route::put('update', [StudentController::class, 'updateData']);

//delete user
Route::delete('delete', [StudentController::class,'deleteData']);
