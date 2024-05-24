#Persistent

; Funkcja sprawdzająca aktualizacje
SprawdzAktualizacje() {
    ; Adres URL do sprawdzenia aktualizacji na GitHubie
    updateUrl := "https://github.com/andrzejtate/cwelozaurus/raw/main/version.txt"
    newVersionUrl := "https://github.com/andrzejtate/cwelozaurus/raw/main/cwelozaurus.ahk" ; Adres URL nowej wersji pliku wykonywalnego

    ; Pobierz informacje o wersji z serwera
    UrlDownloadToFile, %updateUrl%, %A_Temp%\update_version.txt
    FileRead, serverVersion, %A_Temp%\update_version.txt
    serverVersion := Trim(serverVersion)

    ; Aktualna wersja aplikacji
    currentVersion := "1.0.1"
    currentVersion := Trim(currentVersion)

    ; Komunikat do debugowania
    MsgBox, Obecna wersja: %currentVersion%`nWersja serwera: %serverVersion%

    if (serverVersion != currentVersion) {
        MsgBox, Nowa wersja jest dostępna: %serverVersion%. Aktualizacja zostanie pobrana.

        ; Pobierz nową wersję
        newExecutable := A_Temp "\cwelozaurus_new.ahk"
        UrlDownloadToFile, %newVersionUrl%, %newExecutable%

        ; Sprawdź, czy pobieranie było udane
        if ErrorLevel {
            MsgBox, Nie udało się pobrać nowej wersji. Kod błędu: %ErrorLevel%
        } else {
            MsgBox, Nowa wersja została pobrana pomyślnie.
        }

        ; Zamknij obecny skrypt
        Process, Close, % "ahk_exe " A_ScriptFullPath
        Sleep, 2000 ; Odczekaj 2 sekundy przed uruchomieniem nowej wersji

        ; Uruchom nową wersję
        Run, %newExecutable%,, UseErrorLevel
        if ErrorLevel {
            MsgBox, Błąd podczas uruchamiania nowej wersji. Spróbuj ponownie później.
        } else {
            ExitApp
        }
    }
}

; Wywołaj funkcję sprawdzającą aktualizacje przed uruchomieniem GUI
SprawdzAktualizacje()

; Ścieżka AppData
appDataPath := A_AppData

; URL do pobrania obrazka
url := "https://cdn.discordapp.com/attachments/1062775485974708237/1242922562942406726/image.png?ex=66519397&is=66504217&hm=b0da870c2bb25e420c2ab1cae691654b17ff39a035196ce34478bd191112135f&"

; Folder docelowy
folderName := "cwelozaurusassets"
targetFolder := appDataPath "\" folderName

; Plik docelowy
targetFile := targetFolder "\image.png"

; Tworzenie folderu, jeśli nie istnieje
if !FileExist(targetFolder) {
    FileCreateDir, %targetFolder%
}

; Funkcja wątkowa do pobierania pliku
DownloadImageThread(url, targetFile) {
    UrlDownloadToFile, %url%, %targetFile%
    GuiControl,, vcwelozaurus, %targetFile%
}

; Utworzenie wątku
Thread := DllCall("CreateThread", "Ptr", 0, "UInt", 0, "Ptr", RegisterCallback("DownloadImageThread", "Fast"), "Ptr", &url, "UInt", 0, "Ptr", 0)

; Tworzenie GUI
Gui, Margin, 0, 0 ; usuwanie marginesow
Gui, Add, Picture, x0 y0 w%A_ScreenWidth% h%A_ScreenHeight% vcwelozaurus, %targetFile%
Gui, Add, Button, x10 y10 w100 h30 vDWOR gDWOR, Wyjdź na dwór
Gui, Add, Button, x170 y10 w150 h30 vdziewczyna gdziewczyna, Znajdź dziewczynę
Gui, Add, Button, w150 h100 x1770 y980 vEXIT gEXIT, WYŁĄCZ
Gui, Show, Maximize, CWELOZAURUS
return

; Obsługa zamknięcia GUI
GuiClose:
ExitApp
return

; Obsługa przycisków
DWOR:
MsgBox, Przecież jesteś grubym frajerem
return

dziewczyna:
Run, https://6obcy.org
return

EXIT:
ExitApp
return
