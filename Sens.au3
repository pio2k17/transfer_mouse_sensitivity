;
; Script to perform a 360 over a series of mouse inputs and transfer sensitivity between games
;
; Requires AutoIT: https://www.autoitscript.com/site/autoit/downloads/
; Open this script in SciTE script editor and follow the instructions below.
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
; 4) Change $Movement_Total below until it does a perfect 360 in your tuned game. For changes to
;    take effect you will have to stop this script, edit the value, save it, and start the script
;    again
; 5) Now that it's doing a perfect 360, save the script, it's now tuned to your sensitivity and
;    for ready to use

; $Movement_Total = 11938 ; 16:9 2560x1440 550 dpi, perfect 360 in Overwatch(4.57), PUBG(38 General, 45 ADS), R6Seige(42 w/ MouseSensitivityMultiplierUnit=0.002500)
  $Movement_Total = 11938 ; 16:9 2560x1440 550 dpi, perfect 360 in Overwatch(4.57), PUBG(38 General, 45 ADS), R6Seige(42 w/ MouseSensitivityMultiplierUnit=0.002500)

;
; ################################################################################################
; How to use this script to transfer your sensitivity to a new game
; ################################################################################################
; 1) Open the game you want to transfer your sensitivity settings to
; 2) Hit NUMPAD0 to do a 360
; 3) Tune the game's in-game sensitivity until it also does a perfect 360
; 4) You now have the same sensitivity in both games

;
; Code
;
HotKeySet("{NUMPAD0}", "DoThreeSixty")

#include <Misc.au3>

While 1
   ; If capslock is on, do the script every 5 seconds, this is for games like Rainbow 6 Seige that don't pass
   ; your key presses to background applications like this script. In apps like these hitting NUMPAD0 won't work
   $runScript = false
   If _IsToggled ("14") Then
	  beep(500, 300)
	  $runScript = true;
   EndIf
   Sleep(1000)
   if ($runScript) Then
	  DoThreeSixty()
	  Sleep(5000)
	  $runScript = false;
   EndIf
WEnd

Func DoThreeSixty()
   beep (100,200)
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

Func _IsToggled($sHexKey, $vDLL = 'user32.dll')
    ; $hexKey must be the value of one of the keys.
    ; _Is_Key_Pressed will return 0 if the key is not pressed, 1 if it is.
    Local $a_R = DllCall($vDLL, "short", "GetKeyState", "int", '0x' & $sHexKey)
    If Not @error And BitAND($a_R[0], 0xFF) = 1 Then Return 1
    Return 0
EndFunc