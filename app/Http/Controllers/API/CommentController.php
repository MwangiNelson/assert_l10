<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\comments;
use App\Models\protests;
use Illuminate\Http\Request;

class CommentController extends Controller
{
    //
    public function postComments(Request $commentData)
    {
        $isProtest = protests::find($commentData->protest_id);
        if (!$isProtest) {
            return response()->json([
                'status' => 400,
                'success' => false,
                'data' => [
                    'message' => 'This protest cannot be commented'
                ]
            ], 400);
        }

        $commentPosted = comments::create([
            'protest_id' => $commentData->protest_id,
            'comment' => $commentData->comment
        ]);

        if (!$commentPosted) {
            return response()->json([
                'status' => 400,
                'success' => false,
                'data' => [
                    'message' => 'This protest cannot be commented'
                ]
            ], 400);
        }

        return response()->json([
            'status' => 200,
            'success' => true,
            'data' => [
                'message' => 'Comment posted successfully'
            ]
        ], 200);
    }

    public function getComments($protestId)
    {
        $comments = comments::where('protest_id', $protestId)->get();
        if (!$comments) {
            return response()->json([
                'status' => 400,
                'success' => false,
                'data' => [
                    'message' => 'No comments related to this protest found.'
                ]
            ], 400);
        }

        return response()->json([
            'status' => 200,
            'success' => true,
            'data' => $comments
        ], 200);
    }

    public function deleteComment($commentId)
    {
        $deleted = comments::find($commentId)->delete();
        if (!$deleted) {
            return response()->json([
                'status' => 400,
                'success' => false,
                'data' => [
                    'message' => 'Could not delete comment.'
                ]
            ], 400);
        }
        return response()->json([
            'status' => 200,
            'success' => true,
            'data' => [
                'message' => 'Comment deleted successfully'
            ]
        ], 200);
    }

    public function editComment(Request $commentData)
    {
        $comment = comments::find($commentData->id)->first();
        if (!$comment) {
            return response()->json([
                'status' => 400,
                'success' => false,
                'data' => [
                    'message' => 'Comment not found.'
                ]
            ], 400);
        }

        $comment->fill([
            'protest_id' => $commentData->protest_id,
            'comment' => $commentData->comment
        ]);

        $newComment = $comment->save();

        if (!$newComment) {
            return response()->json([
                'status' => 400,
                'success' => false,
                'data' => [
                    'message' => 'Comment not found.'
                ]
            ], 400);
        }

        return response()->json([
            'status' => 200,
            'success' => true,
            'data' => [
                'message' => 'Comment updated successfully'
            ]
        ], 200);
    }
}
