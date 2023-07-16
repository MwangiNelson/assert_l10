<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class alerts extends Model
{
    use HasFactory;

    protected $table = "alerts";
    protected $fillable = ['protest_id', 'volunteer_id'];
}
