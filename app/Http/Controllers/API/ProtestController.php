<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\alerts;
use App\Models\comments;
use App\Models\photos;
use App\Models\protests;
use App\Models\users;
use App\Models\volunteer_book;
use App\Models\volunteers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use Carbon\Carbon;



class ProtestController extends Controller
{
    //
    private $protestRules = [
        'title' => 'required|string|unique:protests,title',
        'event_date' => 'required|date',
        'description' => 'required|string|min:250',
        'venue' => 'required|string'
    ];

    private $customMessages = [
        'required' => 'Cannot be empty',
        'string' => 'Please use alphabet letters',
        'min' => 'Must have a minimum 250 characters',
    ];

    private function generateToken()
    {
        $token = Str::random(16);
        $validToken = Validator::make(['token' => $token], ['token' => 'unique:protests,protest_id']);

        if (!$validToken->passes()) {
            return $this->generateToken();
        }

        return $token;
    }

    private function validate_protest_date($event_date, $current_date)
    {
        $eventDate = Carbon::parse($event_date);
        $currentDate = Carbon::parse($current_date);

        $minDate = $currentDate->copy()->addDays(4);
        $maxDate = $currentDate->copy()->addDays(14);

        if ($eventDate->greaterThanOrEqualTo($minDate) && $eventDate->lessThanOrEqualTo($maxDate)) {
            // Valid protest date
            $expiryDate = $eventDate->copy()->addDays(1);
            return $expiryDate;
        } else {
            // Invalid protest date
            return false;
        }
    }

    private function validateProtestor($id)
    {
        $selected = users::where('id', '=', $id)->first();
        if ($selected->role_name == 'peace usher') {
            return false;
        }

        return true;
    }

    private function alertAuthorities()
    {
        return "Authorities have been alerted";
    }

    //complete
    public function post_protest(Request $protestData)
    {
        if (!($this->validateProtestor($protestData->creator_token))) {
            return response()->json([
                'status' => 400,
                'success' => false,
                'data' => [
                    'message' => 'You cannot perform this action'
                ]
            ], 400);
        }

        $validatedInput = Validator::make($protestData->all(), $this->protestRules, $this->customMessages);

        //this method checks the timestamps between the day of posting and the (4 - 14 day) time gap
        $validatedInput->after(function ($validator) use ($protestData) {
            $eventDate = $protestData->get('event_date');
            $currentDate = Carbon::now()->format('Y-m-d');

            $validDate = $this->validate_protest_date($eventDate, $currentDate);

            if ($validDate === false) {
                $validator->errors()->add('event_date', 'Invalid protest date. The event date must have a minimum of 4 days and a maximum of 14 days time gap from the current date.');
            }
        });

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

        $new_protest = protests::create([
            'protest_id' => $this->generateToken(),
            'title' => $protestData->title,
            'event_date' => $protestData->event_date,
            'description' => $protestData->description,
            'venue' => $protestData->venue,
            'is_validated' => false,
            'creator_token' => $protestData->creator_token
        ]);

        if (!$new_protest) {
            return response()->json([
                'status' => 400,
                'success' => false,
                'data' => [
                    'message' => 'Protest could not be posted',
                    'error' => $new_protest
                ]
            ], 400);
        }

        return response()->json([
            'status' => 200,
            'success' => true,
            'message' => 'Protest has been posted. Awaiting approval...'
        ], 200);
    }

    //complete
    public function delete_protest($protest_id)
    {
        //First the passed id is validated whether it's in the db and the boolean result is stored in a variable
        $selected = protests::find($protest_id);
        if ($selected) {
            //then it's deleted returning a 200 OK response
            $selected->delete();
            return  response()->json([
                'status' => 200,
                'success' => true,
                'message' => 'Protest has been deleted successfully.'
            ], 200);
        } else {

            //else an error response is returned
            return response()->json([
                'status' => 400,
                'success' => false,
                'message' => 'Protest could not be deleted. Try again later...'
            ], 400);
        }
    }

    public function edit_protest(Request $protestData)
    {
        $selectedProtest = protests::find($protestData->id);
        if (!$selectedProtest) {
            return response()->json([
                'status' => 400,
                'success' => false,
                'message' => "Protest could not be found!"
            ], 400);
        }

        $selectedProtest->fill([
            // 'username' => $protestData->username ?? $selectedProtest->username,
            // 'email' => $protestData->email ?? $selectedProtest->email,
            // 'role' => $protestData->role_name ?? $selectedProtest->role_name,
            'is_validated' => $protestData->is_validated
        ]);

        $newProtest = $selectedProtest->save();

        if (!$newProtest) {
            return response()->json([
                'status' => 400,
                'success' => false,
                'message' => "Protest data could not be updated!"
            ], 400);
        }

        return response()->json([
            'status' => 200,
            'success' => true,
            'message' => "Protest updated successfully!"
        ], 200);
    }

    //complete
    public function get_all_protests()
    {
        //gets all protests
        $protests = protests::all();
        //if none return an error code message of 400
        if ($protests->count() > 0) {
            return response()->json([
                'status' => 200,
                'success' => true,
                'protests' => $protests
            ], 200);
        }
        return  response()->json([
            'status' => 400,
            'success' => false,
            'message' => 'No records found'
        ], 400);
    }

    public function get_volunteer_requests()
    {
        //gets all protests
        $protests = volunteer_book::all();
        //if none return an error code message of 400
        if ($protests->count() > 0) {
            return response()->json([
                'status' => 200,
                'success' => true,
                'volunteer_requests' => $protests
            ], 200);
        }
        return  response()->json([
            'status' => 400,
            'success' => false,
            'message' => 'No records found'
        ], 400);
    }

    public function getValidProtests()
    {
        $protests = protests::where('is_validated', '=', 1)->get();
        if ($protests->count() > 0) {
            return response()->json([
                'status' => 200,
                'success' => true,
                'protests' => $protests
            ], 200);
        }
        return  response()->json([
            'status' => 400,
            'success' => false,
            'message' => 'No records found'
        ], 400);
    }
    public function get_user_protests($user_id)
    {
        //First the passed id is validated whether it's in the db and the boolean result is stored in a variable
        $selected = protests::where('creator_token', '=', $user_id)->get();
        if ($selected) {
            //then it's deleted returning a 200 OK response
            return  response()->json([
                'status' => 200,
                'success' => true,
                'data' => ($selected->toArray() != [] ? $selected->toArray() : 'No protests attached to this user profile')
            ], 200);
        } else {

            //else an error response is returned
            return response()->json([
                'status' => 400,
                'success' => false,
                'message' => 'Protest could not be found. Try again later...'
            ], 400);
        }
    }

    public function volunteerUsher(Request $userData)
    {
        $selected = volunteers::find($userData->volunteer_id);
        if (!$selected) {
            return response()->json([
                'status' => 400,
                'success' => false,
                'message' => 'Request could not be completed.Check your credentials...'
            ], 400);
        }
        $existing  = volunteer_book::where('volunteer_id', '=', $userData->volunteer_id)
            ->where('protest_id', '=', $userData->protest_id)->get();
        if ($existing->count() > 0) {
            return response()->json([
                'status' => 200,
                'success' => true,
                'message' => 'You have already volunteered...'
            ], 200);
        }

        $new_volunteer = volunteer_book::create(
            [
                'volunteer_id' => $userData->volunteer_id,
                'protest_id' => $userData->protest_id,
                'is_validated' => false,
            ]
        );

        if (!$new_volunteer) {
            return response()->json([
                'status' => 400,
                'success' => false,
                'message' => 'Your volunteer request failed. Please try again another time...'
            ], 400);
        }

        return response()->json([
            'status' => 200,
            'success' => true,
            'message' => 'Your volunteer request is being processed...'
        ], 200);
    }

    public function get_specific_protest($protest_id)
    {
        $protest = protests::find($protest_id);
        if (!$protest) {
            //else an error response is returned
            return response()->json([
                'status' => 400,
                'success' => false,
                'message' => 'Protest could not be found. Try again later...'
            ], 400);
        }

        $protest_author = users::find($protest->creator_token);
        $comments = comments::where('protest_id', $protest_id)->get();
        $photos = photos::where('protest_id', $protest_id)->get();
        // $photoUrls = $photos->pluck('image_url')->all();

        $return_data = [
            'title' => $protest->title,
            'description' => $protest->description,
            'event_date' => $protest->event_date,
            'author' => $protest_author->username,
            'author_token' => $protest_author->id,
            'venue' => $protest->venue,
            'comments' => $comments,
            'photos' => $photos
        ];

        return  response()->json([
            'status' => 200,
            'success' => true,
            'protest' => $return_data
        ], 200);
    }
    public function emergency(Request $protestData)
    {
        $protest = protests::where('protest_id', '=', $protestData->protest_id)->first();
        $new_protest = $protest->update(
            [
                'is_validated' => false
            ]
        );

        if ($new_protest) {
            $alertmsg = $this->alertAuthorities();
            return response()->json(
                [
                    'status' => 200,
                    'message' => $alertmsg
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 400,
                    'message' => 'Couldnt cancel protest'
                ],
                400
            );
        }
    }

    public function updateRequest(Request $request)
    {
        $exists = volunteer_book::find($request->id);
        if (!$exists) {
            return response()->json(
                [
                    'status' => 400,
                    'message' => 'Request could not be found'
                ],
                400
            );
        }

        $exists->fill([
            'is_validated' => $request->is_validated
        ]);

        $newRequest = $exists->save();

        if (!$newRequest) {
            return response()->json([
                'status' => 400,
                'success' => false,
                'message' => "Request data could not be updated!"
            ], 400);
        }

        return response()->json([
            'status' => 200,
            'success' => true,
            'message' => "Request updated successfully!",
            'data' => $request->is_validated

        ], 200);
    }

    public function uploadPhoto(Request $photoData)
    {
        $newPhoto = photos::create([
            'protest_id' => $photoData->protest_id,
            'image_url' => $photoData->img_url
        ]);

        if (!$newPhoto) {
            return response()->json([
                'status' => 400,
                'success' => false,
                'message' => "Request data could not be updated!"
            ], 400);
        }

        return response()->json([
            'status' => 200,
            'success' => true,
            'message' => "Photo uploaded successfully"
        ], 200);
    }


    public function getPhotos()
    {
        $photos = photos::all();
        return response()->json($photos);
    }

    public function deletePhoto($photoId)
    {
        $deleted = photos::find($photoId)->delete();
        if ($deleted) {
            return response()->json(
                [
                    'status' => 200,
                    'message' => 'Photo deleted successfully'
                ],
                200
            );
        }
        return response()->json([
            'status' => 400,
            'success' => false,
            'message' => "Failed to delete photo!"
        ], 400);
    }

    public function checkAssignment(Request $data)
    {
        $volunteer_request = volunteer_book::where('volunteer_id', $data->volunteer_id)->where('protest_id', $data->protest_id)->first();
        if ($volunteer_request) {
            return response()->json(
                [
                    'status' => 200,
                    'data' => $volunteer_request->is_validated
                ],
                200
            );
        }

        return response()->json(
            [
                'status' => 200,
                'data' => false
            ],
            200
        );
    }

    public function cancelVolunteer(Request $data)
    {
        $volunteer_request = volunteer_book::where('volunteer_id', $data->volunteer_id)->where('protest_id', $data->protest_id)->delete();
        if ($volunteer_request) {
            return response()->json(
                [
                    'status' => 200,
                    'data' => true
                ],
                200
            );
        }
        return response()->json(
            [
                'status' => 400,
                'message' => 'PLease request a volunteer first'
            ],
            400
        );
    }

    public function alertAdmin(Request $request)
    {
        $alert = alerts::firstOrCreate([
            'volunteer_id' => $request->volunteer_id,
            'protest_id' => $request->protest_id
        ]);

        if ($alert->wasRecentlyCreated) {
            return response()->json(
                [
                    'status' => 200,
                    'message' => 'Alert has been posted successfully'
                ],
                200
            );
        }

        return response()->json(
            [
                'status' => 200,
                'message' => 'Alert has already been posted'
            ],
            200
        );
    }

    public function getAlerts()
    {
        $alerts = alerts::all();

        $formattedAlerts = $alerts->map(function ($alert) {
            $volunteer = volunteers::find($alert->volunteer_id);
            $protest = protests::find($alert->protest_id);

            return [
                'volunteer_id' => $alert->volunteer_id,
                'volunteer_username' => $volunteer ? $volunteer->username : null,
                'protest_id' => $alert->protest_id,
                'protest_title' => $protest ? $protest->title : null,
                'venue' => $protest ? $protest->venue : null,
                'timestamp' => $alert->created_at
            ];
        });

        return response()->json([
            'status' => 200,
            'alerts' => $formattedAlerts,
        ], 200);
    }
}
