<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\student;

class StudentController extends Controller
{
    // view data
    public function index(){
        return student::all();
    }


    // this for data save
    function saveData(Request $req){
        $tab_le = new student;

        //Data Assigning to table
       
        $tab_le->name = $req->name;
        $tab_le->email = $req->email;

        // save data to database
        $result = $tab_le->save();
        if($result){
            return ['result'=> 'Data saved'];
        }
        else{
            return ['result'=> 'Data not saved'];
        }

    }

    // data update
    function updateData(Request $req){
        $requestData = $req->all();
      

        $result = student::where('id', $req->id)->update($requestData);

        if($result){
            return ['result'=>'update data'];
        }
        else{
            return ['result'=> ' could not updated data'];
        }

        //updata data
        // $tab_le->put();

    }

    // delete data
    function deleteData(Request $req){
        $reqData = $req->all();
      
        $result = student::where("id",$req->id)->delete($reqData);
        if($result){
            return ['result'=>'deleted'];
        }
        else{
            return ['result'=>'data was not deleted'];
        }
    }
}
