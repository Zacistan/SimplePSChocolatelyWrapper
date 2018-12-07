# Simple PowerShell Chocolatey Wrapper
A simple module to make installing Chocolatey packages even easier.

# Installing the Module
## Install into a PSModulePath
Run the following command in the folder containing SimpleChocolateyWrapper.psm1 to install the module:
```powershell
PS> Copy-Item .\SimpleChocolateyWrapper.psm1 -Destination "$($env:PSModulePath.split(';')[0])\SimpleChocolateyWrapper\SimpleChocolateyWrapper.psm1" -Force
```
Then you can import the module into any PowerShell session:
```powershell
PS> Import-Module SimpleChocolateyWrapper
```
## Import Directly into a Local Session
If you do not want to install the module into the PSModulePath, you can import the module file directly into your current session. Run this command in the folder containing SimpleChocolateyWrapper.psm1:
```powershell
PS> Import-Module .\SimpleChocolateyWrapper.psm1
```

# Using the Module
This module comes with one CMDLET and one helper function. Install-ChocoPackage will run Install-Chocolately, so it is not necessary to run them separately.

## CMDLET: Install-ChocoPackage
### Synopsis 
Install-ChocoPackage will take either a Chocolatey package name, a path to a text file with package names, or a 
comma-separated list of package names, and install each package.
### Example 
THIS MUST BE RAN IN AN ADMINSTRATOR POWERSHELL SESSION.

Example 1 - Passing in a single package name:
```powershell
PS> Install-ChocoPackage -Package vscode
```

Example 2 - Passing in a comma-separated list:
```powershell
PS> Install-ChocoPackage -Package "python3,vscode"
```

Example 3 - Passing in a filepath to a file with package names:
```powershell
PS> Install-ChocoPackage -Package .\example.txt
```

### Notes 
NAME: Install-ChocoPackage

AUTHOR: Zachary Robinson

LASTEDIT: 2018.12.06

## FUNCTION: Install-Chocolately
### Synopsis 
Installs Chocolatey if not present.
### Example 
THIS MUST BE RAN IN AN ADMINSTRATOR POWERSHELL SESSION

Example 1 - Install Chocolatey:
```powershell
PS> Install-Chocolatey
```
### Notes 
NAME: Install-Chocolatey

AUTHOR: Zachary Robinson

LASTEDIT: 2018.12.06