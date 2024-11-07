#NoEnv
#Persistent
#KeyHistory 0
SendMode Input
#SingleInstance, force
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
SetWorkingDir, %A_ScriptDir%

global accounts := getData()

MsgBox, 0, Information, This code is the property of Larry2018. Redistribution, sale, or acquisition of this bot is not permitted.`nOnly the owner (Larry2018) is authorized to distribute or modify the code.`nFor source code details, please contact via Discord: larry2018.`nAll rights reserved.`n`nHotKey:`nF2 - Close Bot

winTitle := "BC.GAME: Crypto Casino Games & Casino Slot Games - Crypto Gambling"
WinForeground(winTitle)
cocos := ["0x3BAF67", "0x2226FE", "0x38D5FE", "0x44A0DB"]
locations := [[125, 940], [1880, 825], [1800, 280], [120, 920]]
global counter := 0
global counterFlag := 0

Loop {
  if (counter) {
    counterFlag++
    if (counterFlag >= 999) {
      counterFlag := 0
      counter := 0
    }
  }

  if (counter >= accounts) {
    counter := 0
    counterFlag := 0
    Sleep, 6000
    Loop, %accounts% {
      swapNext()
      Sleep, 6000
    }
    MsgBox, 0, Info, All Coco's Catched Successfuly!, 18000 
  }

  Loop, % cocos.MaxIndex() {
    coco := cocos[A_Index]
    x := locations[A_Index, 1]
    y := locations[A_Index, 2]
    checkAndClick(coco, x, y)
  }

  Sleep, 250
}

WinForeground(winTitle) {
  If WinExist(winTitle) {
    WinActivate
  } Else {
    MsgBox, 0, Warning, Firefox Window Doesnt Found, Activate Firefox Window and click Ok
  }
}

checkAndClick(coco, x, y) {
  PixelGetColor, cocoPixel, x, y
  if (cocoPixel = coco) {
    MouseMove, %x%, %y%, 5
    Click
    Sleep, 500
    swapNext()
    If (accounts > 1) {
      counter++
      counterFlag := 0
    }
  }
}

getData() {
  InputBox, accounts, Enter Number of Accounts, Please enter the number of accounts,,,,,,,, 1
  If ErrorLevel
    ExitApp
  If accounts is not number
    ExitApp

  If (accounts < 1 || accounts > 15) {
    MsgBox, 0,, Value must be between 1-15, 5
    ExitApp
  }
  Return accounts 
}

swapNext() {
  Send, ^{tab}
  Sleep, 100 
}

getId() {
  tempFile := A_Temp "\serial.txt"
  RunWait, %ComSpec% /c wmic diskdrive get serialnumber /format:list > "%tempFile%", , Hide
  FileRead, OutputVar, %tempFile%
  FileDelete, %tempFile%

  StringReplace, OutputVar, OutputVar, `r, , All ; Remove carriage returns
  StringReplace, OutputVar, OutputVar, `n, , All ; Remove newlines

  OutputVar := Trim(OutputVar)
  allowedId := "SerialNumber=ENTER_YOUR_SERIAL_KEY_HERE"

  If (OutputVar != allowedId) {
    MsgBox, 0,, Invalid Id
    ExitApp
  }
}

F2::
ExitApp