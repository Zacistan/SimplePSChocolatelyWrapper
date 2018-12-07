function Install-Chocolatey {
    <# 
   .Synopsis 
    Installs Chocolatey if not present.
   .Example 
    Example 1 - Install Chocolatey:
        Install-Chocolatey
   .Notes 
    NAME: Install-Chocolatey
    AUTHOR: Zachary Robinson
    LASTEDIT: 2018.12.06
    #> 
    if (Get-Command choco.exe -ErrorAction SilentlyContinue) {
        Write-Host "Chocolatey is already installed."
        return
    }

    Write-Host "Installing Chocolatey."
    Set-ExecutionPolicy Bypass -Scope Process -Force
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    & choco feature enable -n allowGlobalConfirmation
}

function Install-ChocoPackage {
    <# 
   .Synopsis 
    Install-ChocoPackage will take either a Chocolatey package name, a path to a text file with package names, or a 
    comma-separated list of package names, and install each package.
   .Example 
    THIS MUST BE RAN IN AN ADMINSTRATOR POWERSHELL SESSION
    Example 1 - Passing in a single package name.
        Install-ChocoPackage -Package vscode

    Example 2 - Passing in a comma-separated list:
        Install-ChocoPackage -Package "python3,vscode"

    Example 3 - Passing in a filepath to a file with package names:
        Install-ChocoPackage -Package .\example.txt

   .Notes 
    NAME: Install-ChocoPackage
    AUTHOR: Zachary Robinson
    LASTEDIT: 2018.12.06
    #> 
    [CmdletBinding()]
    param(
        # Chocolatey package name(s) or path to file.
        [Parameter(Mandatory=$true)]
        [String]
        $Package
    )
    # Install Chocolatey if it is not already installed.
    Install-Chocolatey

    # If the Package parameter is a valid file, get our list of Packages from that file.
    if (Test-Path $Package -PathType Leaf) {
        Write-Host "Getting list of packages from $Package"
        # Split and trim are used here to ensure that any comma separated values are treated as separate packages.
        $packages = Get-Content $Package | ForEach-Object { $_.Split(',').Trim() }
    }
    else {
        # Split and trim are used here to ensure that any comma separated values are treated as separate packages.
        $package = $Package.Split(',').Trim()
    }

    foreach ($pack in $Packages) {
        Write-Host "$(Get-Date): Beginning to install packages."
        try {
            Write-Verbose "$(Get-Date): Installing package $pack..."
            & choco install $pack
            Write-Verbose "$(Get-Date): Done installing package $pack."
        }
        catch {
            Write-Error "Error installing Chocolatey package [$pack]. Error message: $_"
        }
    }
}