selectedWindows := []  ; Crée une liste pour stocker les fenêtres sélectionnées

; Raccourci pour sélectionner une fenêtre (Alt+S)
!s::
{
    ; Récupérer l'ID de la fenêtre active
    activeWindowID := WinGetID("A")

    ; Vérifier si la fenêtre n'est pas déjà sélectionnée
    alreadySelected := false
    for index, windowID in selectedWindows {
        if (windowID = activeWindowID) {
            alreadySelected := true
            break
        }
    }

    if !alreadySelected {
        ; Ajouter la fenêtre à la liste
        selectedWindows.Push(activeWindowID)
    }
}

; Raccourci pour basculer l'état des fenêtres sélectionnées (Ctrl+M)
^m::
{
    ; Vérifier si des fenêtres ont été sélectionnées
    if (selectedWindows.Length > 0) {
        for index, windowID in selectedWindows {
            ; Vérifier l'état de la fenêtre (si elle est minimisée ou non)
            windowState := WinGetMinMax(windowID)
            if (windowState = -1) {
                ; Si la fenêtre est minimisée, la restaurer
                WinRestore(windowID)
            } else {
                ; Si la fenêtre est en premier plan, la minimiser
                WinMinimize(windowID)
            }
        }
    }
}
