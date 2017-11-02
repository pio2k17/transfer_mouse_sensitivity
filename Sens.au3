;
; Script to perform a 360 over a series of mouse inputs and transfer sensitivity between games
;
; Requires AutoIT: https://www.autoitscript.com/site/autoit/downloads/
; Open SciTE script editor and follow the instruction below.
;
; How to start/stop this script....
;       To start script: Tools menu -> Go
;       To stop script: Tools menu -> Stop Executing

; ################################################################################################
; How to setup this script
; ################################################################################################
; 1) Start script
; 2) Open a game you have already tuned your sensitivity in
; 3) Hit NUMPAD0 to make your mouse attempt a 360
; 3) Change $Movement_Total below until it does a perfect 360 in your tuned game. For changes to
;    take effect you will have to stop this script, edit the value, save it, and start the script
;    again
; 4) Now that it's doing a perfect 360, save the script, it's now tuned to your sensitivity and
;    for ready to use

$Movement_Total = 5702 ; perfect 360 in Overwatch @ 9.57 sensitivity

; ################################################################################################
; How to use this script to transfer your sensitivity to a new game
; ################################################################################################
; 1) Open the game you want to transfer your sensitivity settings to
; 1) Hit NUMPAD0 to do a 360
; 2) Tune the game's in-game sensitivity until it also does a perfect 360
; 2) You now have the same sensitivity in both games

;
; Code
;
HotKeySet("{NUMPAD0}", "DoThreeSixty")

While 1
    Sleep(1000)
WEnd

Func DoThreeSixty()
   $movementTotal = $Movement_Total;
   $movementStep = 30 ; how many pixels to move in a single iteration.  Don't let this exceed half of your resolution.
   $delay = 10 ; delay in milliseconds between movements.  Making this too low is prone to causing dropped inputs.

   While $movementTotal > $movementStep
	  _MouseMovePlus($movementStep, 0)
	  $movementTotal = $movementTotal - $movementStep
	  Sleep($delay)
   WEnd
  _MouseMovePlus($movementTotal, 0) ; and do the leftover
EndFunc

Func _MouseMovePlus($X = "", $Y = "")
        Local $MOUSEEVENTF_MOVE = 0x1
    DllCall("user32.dll", "none", "mouse_event", _
            "long",  $MOUSEEVENTF_MOVE, _
            "long",  $X, _
            "long",  $Y, _
            "long",  0, _
        "long",  0)
	 EndFunc
