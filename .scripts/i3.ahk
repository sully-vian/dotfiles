#Requires AutoHotkey v2.0

; toggle maximized: Win + f
#f::{
    static winData := Map() ; store original positions
    hwnd := WinGetID("A")
    if WinGetMinMax("A") = 1 { ; maximized -> restore data
        WinRestore("A")
        if winData.Has(hwnd) {
            d := winData[hwnd]
            WinMove(d.x, d.y, d.w, d.h, "ahk_id " hwnd)
            winData.Delete(hwnd)
        }
    } else { ; tiled | windowed -> store data and maximize
        WinGetPos(&outX, &outY, &outW, &outH, "ahk_id " hwnd)
        winData[hwnd] := {x:outX, y:outY, w:outW, h:outH}
        WinMaximize("A")
    }
}
; close active window: Win + Shift + q
#+q::WinClose("A")

; open Chrome: Win + b
#b::Run "chrome.exe"

; open WSL: Win + Enter
#Enter::Run "C:\Users\vianney.hervy\AppData\Roaming\Microsoft\Windows\Start Menu\archlinux.lnk"

TraySetIcon "C:\Users\vianney.hervy\AppData\Local\wsl\{aa309ff0-3ea5-448c-a1ba-69919b162e73}\shortcut.ico"
TrayTip "i3 Shortcuts Loaded", "Arch-WSL script is now active", 4
TraySetIcon "*"
