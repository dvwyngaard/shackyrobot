[array]$global:position = ""
[int]$global:y_value=0
[int]$global:x_value=0
[string]$global:direction = ""
[int]$global:x_max=5
[int]$global:y_max=5
[string]$global:place_direction = ""
[bool]$global:status_valid = $true
[string]$global:input_prompt_message = ""
[string]$global:input_request = "" 
[int]$global:start=0

function calculateposition{
    switch ($global:direction) {
        "NORTH" { #set y
           if(($global:y_value -le $global:y_max -and $global:y_max -gt $global:y_value) -or $global:y_value -eq $global:y_max){
                $global:y_value = $global:y_value + 1;
                if($global:y_value -ge 0){}
                else{
                        write-host "Off the board";
                        $global:y_value = $global:y_value - 1
                    }

                if($global:y_value -gt $global:y_max){
                    write-host "Off the board";
                    $global:y_value = $global:y_value - 1}
            else{
                if($global:y_value -eq $global:y_max){
                    $global:y_value = $global:y_value - 1;
                    }
                else{
                    if($global:y_value -gt $global:y_max){write-host "Off the board"}
                    }
                }
           }
        }
        "EAST" { #set x
            if(($global:x_value -le $global:x_max -and $global:x_max -gt $global:x_value) -or $global:x_value -eq $global:x_max){
                $global:x_value = $global:x_value + 1;
                if($global:x_value -ge 0){}
                else
                    {write-host "Off the board";
                    $global:x_value = $global:x_value + 1}

                if($global:x_value -gt $global:x_max){
                    write-host "Off the board";
                    $global:x_value = $global:x_value - 1}
                }
            else{
                if($global:x_value -eq $global:x_max){
                    $global:x_value = $global:x_value - 1;
                    }
                else{
                    if($global:x_value -gt $global:x_max){write-host "Off the board"}
                    }
                }
            }
        "SOUTH" { #set y
            if(($global:y_value -le $global:y_max -and $global:y_max -gt $global:y_value)-or $global:y_value -eq $global:y_max){
                $global:y_value = $global:y_value - 1
                if($global:y_value -ge 0){}
                else{
                        write-host "Off the board";
                        $global:y_value = $global:y_value + 1
                    }

                if($global:y_value -gt $global:y_max){
                    write-host "Off the board";
                    $global:y_value = $global:y_value + 1}
            else{
                if($global:y_value -eq $global:y_max){
                    $global:y_value = $global:y_value + 1;
                    }
                else{
                    if($global:y_value -gt $global:y_max){write-host "Off the board"}
                    }
                }
             }
            }
        "WEST" {#set x
            if(($global:x_value -le $global:x_max -and $global:x_max -gt $global:x_value) -or $global:x_value -eq $global:x_max) {
                $global:x_value = $global:x_value + 1;
                if($global:x_value -ge 0){}
                else
                    {write-host "Off the board";
                    $global:x_value = $global:x_value - 1}

                if($global:x_value -gt $global:x_max){
                    write-host "Off the board";
                    $global:x_value = $global:x_value - 1}
                }
            else{
                if($global:x_value -eq $global:x_max){
                    $global:x_value = $global:x_value - 1;
                    }
                else{
                    if($global:x_value -gt $global:x_max){write-host "Off the board"}
                    }
                }
        }
        Default {write-host "Default - no valid entry"}
    }
} 
function isInput_valid($request){}
function set_direction($global:input_request){
    $global:direction
    switch -wildcard ($global:input_request) {
        {$global:input_request.contains("PLACE")} {$global:direction = (($global:input_request.Replace("PLACE","")).Split(",")[2].replace(" ",""))}
        "LEFT" {
                switch($global:direction){
                    "NORTH" {$global:direction = "WEST"}
                    "EAST" {$global:direction = "NORTH"}
                    "WEST" {$global:direction = "SOUTH"}
                    "SOUTH" {$global:direction = "EAST"}
                 }}
        "RIGHT" {
                switch($global:direction){
                    "NORTH" {$global:direction = "EAST"}
                    "EAST" {$global:direction = "SOUTH"}
                    "WEST" {$global:direction = "NORTH"}
                    "SOUTH" {$global:direction = "WEST"}
                }}
        default {write-host "Unknown direction"}
        }
     }
function return_message($get_message_request){
    switch ($get_message_request) {
        1 { $global:input_prompt_message = "Welcome to my Shacky Robot :-) .. Placement started at 0,0,N(Command options: PLACE (X,Y,F), MOVE, LEFT, RIGHT,REPORT,EXIT" }
         Default {$global:input_prompt_message  = "Not a valid input, try again"}
    }
    return $global:input_prompt_message
}
function main{
    try {
       if($global:start -eq 0){$global:x_value=0;$global:y_value=0;$global:direction="NORTH"; write-host "You have been automatically place at 0,0,NORTH";$global:start= $global:start + 1}
        ## Get input
        $global:input_request = read-host -prompt (return_message -get_message_request "1")
        switch -wildcard ($global:input_request) {
            {$global:input_request.contains("PLACE")} { $global:place_x = (($global:input_request.Replace("PLACE","")).Split(",")[0].replace(" ",""));
                                                        $global:place_y = (($global:input_request.Replace("PLACE","")).Split(",")[1].replace(" ",""));
                                                        $global:place_direction = (($global:input_request.Replace("PLACE","")).Split(",")[2].replace(" ",""));
                                                        if(($global:place_x -le $global:x_max -and $global:x_max -gt $global:place_x) -or ($global:place_y -le $global:y_max -and $global:y_max -gt $global:place_y))
                                                           {$global:x_value = $global:place_x;
                                                            $global:y_value = $global:place_y;
                                                            $global:direction = $global:place_direction }
                                                        else{write-host "Off the board"; $global:status_valid = $false }}
            "LEFT" {set_direction($global:input_request)} 
            "RIGHT" {set_direction($global:input_request)}
            "REPORT" {write-host ($global:x_value.ToString() +"," + $global:y_value.tostring() + "," + $global:direction) }
            "MOVE" {calculateposition;}
            Default { Write-Host (return_message -get_message_request "")}
            }
        }
        catch [System.SystemException]{
            write-host "Error try again"
            Write-Host (return_message -get_message_request "")
            main
        }
    }
   
try {
    do {
        $global:input_request = ""
        #first command is to place
        main
    } while ($global:input_request -ne "EXIT")
}
catch [System.SystemException]{
   write-host "Error try again"
   Write-Host (return_message -get_message_request "")
   main
}






