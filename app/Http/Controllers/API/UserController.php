<?php

namespace App\Http\Controllers\API;


use App\Http\Controllers\Controller;
use App\Models\users;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;


class UserController extends Controller
{
    private $validationRules = [
        'username' => 'required|string',
        'email' => 'required|unique:users,email',
        'password' => 'required|min:8'
    ];
    private $customMessages = [
        'required' => 'Cannot be empty',
        'string' => 'Please use alphabet letters',
        'min' => 'Must have a minimum 8 characters',
    ];

    private function generateToken()
    {
        $token = Str::random(32);
        $validToken = Validator::make(['token' => $token], ['token' => 'unique:users,id']);

        if (!$validToken->passes()) {
            return $this->generateToken();
        }

        return $token;
    }

    //completed
    public function get_all_users()
    {
        //gets all users
        $users = users::all();

        //if none return an error code message of 400
        if ($users->count() > 0) {
            return response()->json([
                'status' => 200,
                'success' => true,
                'data' => $users
            ], 200);
        }
        return  response()->json([
            'status' => 400,
            'success' => false,
            'message' => 'No records found'
        ], 400);
    }
    public function register(Request $userData)
    {

        $validatedInput = Validator::make($userData->all(), $this->validationRules, $this->customMessages);

        if ($validatedInput->fails()) {
            $errors = $validatedInput->errors()->toArray();
            return response()->json([
                'status' => 400,
                'success' => false,
                'data' => [
                    'message' => $errors
                ]
            ], 400);
        }



        $newUser = users::create([
            'id' => $this->generateToken(),
            'username' => $userData->username,
            'email' => $userData->email,
            'password' => Hash::make($userData->password),
            'role' => $userData->role
        ]);

        if ($newUser) {
            return response()->json([
                'status' => 200,
                'success' => true,
                'data' => [
                    'user' => [
                        'username' => $userData->username,
                        'email' => $userData->email,
                        'user_privileges' => $userData->role
                    ]
                ]
            ], 200);
        } else {
            return response()->json([
                'status' => 400,
                'success' => false,
                'data' => [
                    'message' => 'User could not be created'
                ]
            ], 400);
        }
    }
    public function login(Request $userData)
    {

        $user = users::where('email', '=', $userData->email)->first();
        if ($user) {



            $passValidated = Hash::check($userData->password, $user->password);
            if ($passValidated) {
                return response()->json([
                    'status' => 200,
                    'success' => true,
                    'data' => [
                        'user' => [
                            'user_token' => $user->id,
                            'username' => $user->username,
                            'email' => $userData->email,
                            'user_privileges' => $user->role
                        ]
                    ]
                ], 200);
            } else {
                return response()->json([
                    'status' => 400,
                    'success' => false,
                    'data' => [
                        'message' => "Wrong password!"
                    ]
                ], 400);
            }
        } else {
            return response()->json([
                'status' => 400,
                'success' => false,
                'data' => [
                    'message' => "User not found! Please confirm your email."
                ]
            ], 400);
        }
    }

    public function update_user(Request $userData)
    {
        $selectedUser = users::find($userData->id);
        if (!$selectedUser) {
            return response()->json([
                'status' => 400,
                'success' => false,
                'message' => "User could not be found!"
            ], 400);
        }

        $selectedUser->fill([
            'username' => $userData->username,
            'email' => $userData->email ?? $selectedUser->email,
            'role' => $userData->role_name,
        ]);

        $newUser = $selectedUser->save();

        if (!$newUser) {
            return response()->json([
                'status' => 400,
                'success' => false,
                'message' => "User data could not be updated!"
            ], 400);
        }

        return response()->json([
            'status' => 200,
            'success' => true,
            'message' => "User role updated successfully!"
        ], 200);
    }


    public function deleteUser($id)
    {
        $selectedUser = users::where('id', '=', $id)->delete();
        if (!$selectedUser) {
            return response()->json([
                'status' => 400,
                'success' => false,
                'message' => "User not found!"
            ], 400);
        }
        return response()->json([
            'status' => 200,
            'success' => true,
            'message' => "User deleted successfully!"
        ], 200);
    }
}
