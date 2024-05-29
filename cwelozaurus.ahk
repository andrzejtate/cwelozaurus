#Persistent
#SingleInstance force

; Funkcja zamieniająca polskie znaki na ich odpowiedniki bez znaków diakrytycznych
PolskieZnakiNaAngielskie(tekst) {
    tekst := StrReplace(tekst, "ą", "a")
    tekst := StrReplace(tekst, "ć", "c")
    tekst := StrReplace(tekst, "ę", "e")
    tekst := StrReplace(tekst, "ł", "l")
    tekst := StrReplace(tekst, "ń", "n")
    tekst := StrReplace(tekst, "ó", "o")
    tekst := StrReplace(tekst, "ś", "s")
    tekst := StrReplace(tekst, "ź", "z")
    tekst := StrReplace(tekst, "ż", "z")
    tekst := StrReplace(tekst, "Ą", "A")
    tekst := StrReplace(tekst, "Ć", "C")
    tekst := StrReplace(tekst, "Ę", "E")
    tekst := StrReplace(tekst, "Ł", "L")
    tekst := StrReplace(tekst, "Ń", "N")
    tekst := StrReplace(tekst, "Ó", "O")
    tekst := StrReplace(tekst, "Ś", "S")
    tekst := StrReplace(tekst, "Ź", "Z")
    tekst := StrReplace(tekst, "Ż", "Z")
    return tekst
}

; Funkcja sprawdzająca aktualizacje
SprawdzAktualizacje() {
    ; Adres URL do sprawdzenia aktualizacji na GitHubie
    updateUrl := "https://github.com/andrzejtate/cwelozaurus/raw/main/version.txt"
    newVersionUrl := "https://github.com/andrzejtate/cwelozaurus/raw/main/cwelozaurus.exe" ; Adres URL nowej wersji pliku wykonywalnego

    ; Pobierz informacje o wersji z serwera
    UrlDownloadToFile, %updateUrl%, %A_Temp%\update_version.txt
    if ErrorLevel {
        MsgBox, % PolskieZnakiNaAngielskie("Blad podczas pobierania informacji o wersji z serwera. Kod bledu: " . ErrorLevel)
        return
    }
    
    FileRead, serverVersion, %A_Temp%\update_version.txt
    serverVersion := Trim(serverVersion)
    serverVersion := RegExReplace(serverVersion, "\s") ; Usuń wszystkie białe znaki

    ; Aktualna wersja aplikacji
    currentVersion := "0.0.3" ; Zaktualizuj tę wartość do najnowszej wersji
    currentVersion := Trim(currentVersion)
    currentVersion := RegExReplace(currentVersion, "\s") ; Usuń wszystkie białe znaki

    ; Komunikat do debugowania
    MsgBox, % "Debugging info:`nObecna wersja: [" . currentVersion . "]`nWersja serwera: [" . serverVersion . "]"

    ; Sprawdź, czy zmienne są prawidłowo pobrane
    if (serverVersion == "") {
        MsgBox, % PolskieZnakiNaAngielskie("Wersja serwera jest pusta!")
        return
    }
    
    if (currentVersion == "") {
        MsgBox, % PolskieZnakiNaAngielskie("Obecna wersja jest pusta!")
        return
    }

    ; Porównaj wersje
    if (serverVersion != currentVersion) {
        MsgBox, % PolskieZnakiNaAngielskie("Nowa wersja jest dostepna: " . serverVersion . ". Aktualizacja zostanie pobrana.")

        ; Pobierz nową wersję bezpośrednio do lokalizacji obecnego skryptu
        currentScriptPath := A_ScriptFullPath
        MsgBox, % PolskieZnakiNaAngielskie("Rozpoczecie pobierania nowej wersji do: " . currentScriptPath)
        UrlDownloadToFile, %newVersionUrl%, %currentScriptPath%

        ; Sprawdź, czy pobieranie było udane
        if ErrorLevel {
            MsgBox, % PolskieZnakiNaAngielskie("Nie udalo sie pobrac nowej wersji. Kod bledu: " . ErrorLevel)
            return
        } else {
            MsgBox, % PolskieZnakiNaAngielskie("Nowa wersja zostala pobrana pomyslnie. Rozpoczynam uruchamianie...")
        }

        ; Uruchom nową wersję
        Run, %currentScriptPath%,, UseErrorLevel
        if ErrorLevel {
            MsgBox, % PolskieZnakiNaAngielskie("Blad podczas uruchamiania nowej wersji. Sprobuj ponownie pozniej.")
        } else {
            MsgBox, % PolskieZnakiNaAngielskie("Nowa wersja zostala pomyslnie uruchomiona. Zamykam aktualna wersje...")
            ExitApp
        }
    } else {
        MsgBox, % PolskieZnakiNaAngielskie("Aktualna wersja jest najnowsza dostepna wersja. Brak koniecznosci aktualizacji.")
    }
}

; Wywołaj funkcję sprawdzającą aktualizacje przed uruchomieniem GUI
SprawdzAktualizacje()

; Ścieżka AppData
appDataPath := A_AppData

; URL do pobrania obrazka
url := "https://i.imgur.com/sTKeLgM.png"

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
UrlDownloadToFile, %url%, %targetFile%
if ErrorLevel {
    MsgBox, % PolskieZnakiNaAngielskie("Nie udalo sie pobrac obrazka. Kod bledu: " . ErrorLevel)
} else {

    ; Tworzenie GUI
    Gui, Margin, 0, 0 ; usuwanie marginesow
    Gui, Add, Picture, x0 y0 w%A_ScreenWidth% h%A_ScreenHeight% vcwelozaurus, %targetFile%
    Gui, Add, Button, x10 y10 w100 h30 vDWOR gDWOR, % PolskieZnakiNaAngielskie("Wyjdz na dwor")
    Gui, Add, Button, x170 y10 w150 h30 vdziewczyna gdziewczyna, % PolskieZnakiNaAngielskie("Znajdz dziewczyne")
    Gui, Add, Button, x370 y10 w150 h30 vkolega gkolega, % PolskieZnakiNaAngielskie("Zwyzywaj kolege")
    Gui, Add, Button, x570 y10 w150 h30 vpisanie gpisanie, % PolskieZnakiNaAngielskie("Pisz z kims")
    Gui, Add, Button, w150 h100 x1770 y980 vEXIT gEXIT, % PolskieZnakiNaAngielskie("WYLACZ")
    Gui, Show, x0 y0 w%A_ScreenWidth% h%A_ScreenHeight%, % PolskieZnakiNaAngielskie("JAKUB KAJER TO CWEL I FRAJER")
    WinTitle := PolskieZnakiNaAngielskie("JAKUB KAJER TO CWEL I FRAJER")
    SetTitleMatchMode, 2 ; Umożliwia dopasowanie częściowe tytułu okna
    WinSet, Style, -0xC00000, %WinTitle%
    WinSet, Redraw, , %WinTitle%
    return
}

; Obsługa zamknięcia GUI
GuiClose:
ExitApp
return

; Obsługa przycisków
DWOR:
MsgBox, % PolskieZnakiNaAngielskie("Przeciez jestes grubym frajerem")
return

dziewczyna:
Run, https://6obcy.org
return

kolega:
MsgBox, % PolskieZnakiNaAngielskie("Nie masz kolegow.")
Return

pisanie:
MsgBox, % PolskieZnakiNaAngielskie("Przeciez kazdego zablokowales.")
Return

EXIT:
ExitApp
return
