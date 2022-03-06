$dest = "C:\Referrals"
$template = "C:\Referrals\_Referral Tempalte"
$Desc = Read-Host "Enter Insured Name, e.g. QBE Australia Pty Ltd"
$Dest2 = "Analysis & QBE Terms" 
$Dir = Read-Host "Enter Policy Year, e.g 2021-2022 or 2021-22 (up to you)"
$Attach = Read-Host "Enter Attachment e.g 5xs5" 
$NewDir = $Desc.ToUpper()
$NewDest = $dest, $NewDir -join "\"

New-Item -Path $dest -ItemType "Directory" -Name $newDir
GCI -Path $template -Recurse |
   Copy-Item -Destination {
      if ($_.PSIsContainer) {
         Join-Path $newdest $_.Parent.FullName.Substring($template.length)
         } else {
               Join-Path $newdest $_.FullName.Substring($template.length)
        }
    }


$TermDir =Join-Path $dest -ChildPath $Desc | Join-Path -ChildPath $Dest2
$items=Get-ChildItem $TermDir
$items | Rename-Item -NewName { $_.Basename + "_" + $Dir +"_" + $NewDir +"_" + $Attach + $_.extension}
