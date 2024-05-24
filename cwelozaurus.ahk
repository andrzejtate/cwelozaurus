#Persistent

; sciezka appdata
appDataPath := A_AppData

; url
url := "https://cdn.discordapp.com/attachments/1062775485974708237/1242922562942406726/image.png?ex=66519397&is=66504217&hm=b0da870c2bb25e420c2ab1cae691654b17ff39a035196ce34478bd191112135f&"

; foldery
folderName := "cwelozaurusassets"
targetFolder := A_AppData "\cwelozaurusassets"

; zapis
targetFile := targetFolder "\image.png"

; urldl
UrlDownloadToFile, %url%, %targetFile%

; polaczenie appdata z cwelozaurusassets
fullFolderPath := appDataPath "\" folderName


; sprawdzanie czy folder istnieje
if !FileExist("FullFolderPath")
{
    ; jesli nie istnieje
    FileCreateDir, %fullFolderPath%
}

; Funkcja wątkowa do pobierania pliku
DownloadImageThread(url, targetFile) {
    UrlDownloadToFile, %url%, %targetFile%, 1
    GuiControl,, vcwelozaurus, %targetFile%
}

; Utworzenie wątku
Thread := DllCall("CreateThread", "Ptr", 0, "Ptr", 0, "Ptr", RegisterCallback("DownloadImageThread", "Fast"), "Ptr", &url, "UInt", 0, "Ptr", 0)


FileCreateDir, C:\AppData\Roaming\cwelozaurusassets

gui, Margin, 0, 0 ; usuwanie marginesow
gui, add, picture, x0 y0 w%A_ScreenWidth% h%A_ScreenHeight% vcwelozaurus, %targetFile%
Gui, Add, Button, x10 y10 w100 h30 vDWOR gDWOR, Wyjdź na dwór
Gui, Add, Button, x170 y10 w150 h30 vdziewczyna gdziewczyna, Znajdź dziewczynę
gui, add, button, w150 h100 x1770 y980 vEXIT gEXIT, WYŁĄCZ
gui, show, Maximize, CWELOZAURUS
return

guiclose:
exitapp

DWOR:
MsgBox, Przeciez jestes grubym frajerem
return

dziewczyna:
Run, https://6obcy.org


EXIT:
exitapp
return