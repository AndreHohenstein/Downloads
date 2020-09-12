<#
.Synopsis
    Downloads from Github
.DESCRIPTION
    PowerShell module, download Single File or something content from Github Repository
.EXAMPLE
    Invoke-APIfromGithub -Owner "AndreHohenstein" -Repository "GroupPolicy" -Path "Edge/New-GPOEdgeSettings.ps1" -DestinationPath "$env:USERPROFILE\Desktop"

 .NOTES
    Author: Andre Hohenstein -  https://github.com/AndreHohenstein
   
.COMPONENT
    APIfromGithub - https://github.com/AndreHohenstein/Downloads/tree/main/Github
#>
function Invoke-APIfromGithub {
Param(
    [string]$Owner,
    [string]$Repository,
    [string]$Path,
    [string]$DestinationPath
    )

    $baseUri     = "https://api.github.com/"
    
    $args        = "repos/$Owner/$Repository/contents/$Path"
    
    $wr          = Invoke-WebRequest -Uri $($baseuri+$args)
    
    $objects     = $wr.Content | ConvertFrom-Json
    
    $files       = $objects    | where {$_.type -eq "file"} `
                               | Select-Object -ExpandProperty download_url
   
    $directories = $objects    | where {$_.type -eq "dir" }
    
    $directories | ForEach-Object { 
                   Invoke-APIfromGithub -Owner $Owner `
                                        -Repository $Repository `
                                        -Path $_.path `
                                        -DestinationPath $($DestinationPath+$_.name)
    }

    
    if (-not (Test-Path $DestinationPath)) {
        
        try {
            New-Item -Path $DestinationPath -ItemType Directory -ErrorAction Stop
        } catch {
            throw "Could not create path '$DestinationPath'!"
        }
    }

    foreach ($file in $files) {
        $fileDestination = Join-Path $DestinationPath (Split-Path $file -Leaf)
        
        try {
            Invoke-WebRequest -Uri $file -OutFile $fileDestination -ErrorAction Stop -Verbose
            "Grabbed '$($file)' to '$fileDestination'"
        } catch {
            throw "Unable to download '$($file.path)'"
        }
    }

}