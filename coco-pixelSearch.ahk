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
cocos := ["0x64AC37", "0xFF2A26", "0xFE2824", "0xDBA044", "0xC64335", "0xFE4E37", "0xFF4F38"]
locations := [[80, 999, 165, 1025], [1850, 800, 1900, 850], [1780, 275, 1830, 330], [80, 999, 165, 1025], [80, 999, 165, 1025], [1850, 800, 1900, 850], [1780, 275, 1830, 330]]
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
    x1 := locations[A_Index, 1]
    y1 := locations[A_Index, 2]
    x2 := locations[A_Index, 3]
    y2 := locations[A_Index, 4]
    checkAndClick(coco, x1, y1, x2, y2)
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

checkAndClick(coco, x1, y1, x2, y2) {
  PixelSearch, FoundX, FoundY, x1, y1, x2, y2, coco, 0, Fast RGB
  if !ErrorLevel {
    MouseMove, %FoundX%, %FoundY%, 5
    Click
    Sleep, 500
    swapNext()
    If (accounts > 1) {
      counter++
      counterFlag := 0
    } Else {
      MsgBox, 0, Info, All Coco's Catched Successfuly!, 18000
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

F2::
ExitApp