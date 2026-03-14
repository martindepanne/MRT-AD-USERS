do {
    $Name = Read-Host "Entrez le Prénom et Nom ex : Maude Zarella"
    $DisplayName = Read-Host "Entrez le Nom d'affichage à l'écran de connexion"
    
    $parts = $Name.Split(" ")
    $GivenName = $parts[0]
    $Surname = $parts[1]
    
    $SamAccountName = "$($GivenName.ToLower()).$($Surname.ToLower())"
    $UserPrincipalName = "$SamAccountName@martin.local"
    $Path = "OU=Utilisateurs,DC=martin,DC=local"
    $AccountPassword = ConvertTo-SecureString "Mot2PasseDure" -AsPlainText -Force

    New-ADUser -Name $Name `
               -DisplayName $DisplayName `
               -GivenName $GivenName `
               -Surname $Surname `
               -SamAccountName $SamAccountName `
               -UserPrincipalName $UserPrincipalName `
               -Path $Path `
               -AccountPassword $AccountPassword `
               -ChangePasswordAtLogon $true `
               -Enabled $true

    do {
        $prompt = Read-Host -Prompt "Voulez-vous créer d'autres utilisateurs ? (Oui/Non)"
        $valide = $prompt -eq "oui" -or $prompt -eq "non"
        
        if (-not $valide) {
            Write-Host "Réponse invalide, veuillez réessayer" -ForegroundColor Red
        }
    } until ($valide)

} while ($prompt -eq "oui")

Write-Host "Fin du script" 