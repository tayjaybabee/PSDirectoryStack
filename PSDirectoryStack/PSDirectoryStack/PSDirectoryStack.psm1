# Define a global stack variable
if (-not (Get-Variable -Name DirectoryStack -Scope Global -ErrorAction SilentlyContinue)) {
    Set-Variable -Name DirectoryStack -Value @() -Scope Global
}

function Push-Location {
    param(
        [string]$Path
    )

    # Save the current location
    $global:DirectoryStack += (Get-Location)

    if ($Path) {
        Set-Location -Path $Path
    }
}

function Pop-Location {
    if ($global:DirectoryStack.Count -eq 0) {
        Write-Host "Directory stack is empty."
        return
    }

    # Retrieve the last location
    $lastLocation = $global:DirectoryStack[-1]

    # Remove the last location from the stack
    $global:DirectoryStack = $global:DirectoryStack[0..($global:DirectoryStack.Count - 2)]

    # Change to the last location
    Set-Location -Path $lastLocation
}

function Switch-Location {
    if ($global:DirectoryStack.Count -eq 0) {
        Write-Host "Directory stack is empty."
        return
    }

    # Retrieve the last location
    $lastLocation = $global:DirectoryStack[-1]

    # Remove the last location from the stack
    $global:DirectoryStack = $global:DirectoryStack[0..($global:DirectoryStack.Count - 2)]

    # Save the current location
    $global:DirectoryStack += (Get-Location)

    # Change to the last location
    Set-Location -Path $lastLocation
}

function Set-LocationEnhanced {
    param(
        [string]$Path
    )

    if ($Path -eq '-') {
        Switch-Location
        return
    }

    # Ensure the path is resolved correctly
    $resolvedPath = Resolve-Path -Path $Path -ErrorAction SilentlyContinue

    try {
        if ($resolvedPath) {
            if (Test-Path -Path $resolvedPath -PathType Leaf) {
                # If it's a file, get the parent directory
                $item = Get-Item -Path $resolvedPath -ErrorAction Stop
                Push-Location -Path $item.DirectoryName
            } else {
                # If it's a directory
                Push-Location -Path $resolvedPath
            }
        } else {
            throw
        }
    } catch {
        $parentPath = [System.IO.Path]::GetDirectoryName($Path)
        if ($parentPath -and (Test-Path -Path $parentPath)) {
            Push-Location -Path $parentPath
        } else {
            Write-Error "Path '$Path' does not exist."
        }
    }
}


function Update-UserProfileForEnhancedLocationModule {
    param (
        [Alias('h')]
        [switch]$Help,
        [Alias('D')]
        [switch]$Debug
    )

    if ($Debug) {
        $DebugPreference = 'Continue'
    }

    Write-Debug "Starting Update-UserProfileForEnhancedLocationModule"

    # Manually check for --help argument in the invocation line
    $invocation = $PSCmdlet.MyInvocation
    if ($Help -or $invocation.Line -like "*--help*") {
        @"
NAME
    Update-UserProfileForEnhancedLocationModule

SYNOPSIS
    Updates the user's PowerShell profile to import the EnhancedLocationModule and set aliases.

SYNTAX
    Update-UserProfileForEnhancedLocationModule [-Help]

DESCRIPTION
    This function dynamically determines the path to the EnhancedLocationModule's .psm1 file, 
    updates the user's PowerShell profile to import the module, and sets aliases for enhanced 
    location handling. It then reloads the profile to apply the changes immediately.

PARAMETERS
    -Help
        Displays this help message.

EXAMPLES
    PS> Update-UserProfileForEnhancedLocationModule
    Updates the user's profile with the module import and alias commands, then reloads the profile.

NOTES
    Author: T. Blackstone
    Company: Inspyre-Softworks
    This function is part of the PSDirectoryStack module.
"@
        return
    }

    # Get the path to the user's profile script
    $profilePath = $PROFILE

    Write-Debug "User profile file: $PROFILE"

    # Content to add to the profile script
    $profileContentToAdd = @"

# Import the EnhancedLocationModule module
Import-Module -Name PSDirectoryStack

# Create an alias for 'cd' to use Set-LocationEnhanced
Set-Alias -Name cd -Value Set-LocationEnhanced -Option AllScope

# Optional: Create aliases for Push-Location and Pop-Location
Set-Alias -Name pushd -Value Push-Location -Option AllScope
Set-Alias -Name popd -Value Pop-Location -Option AllScope
Set-Alias -Name switchd -Value Switch-Location -Option AllScope
"@

    Write-Debug "Checking if the profile already contains the necessary content"

    # Check if the profile already contains the necessary content
    $profileContent = Get-Content -Path $profilePath -Raw
    if ($profileContent.Contains($profileContentToAdd.Trim())) {
        Write-Host "Profile already contains the necessary imports and aliases."
        Write-Debug "Profile already contains the necessary imports and aliases."
    } else {
        Write-Debug "Appending content to the profile script"

        # Append the content to the profile script
        Add-Content -Path $profilePath -Value $profileContentToAdd

        Write-Host "Profile updated successfully."
        Write-Debug "Profile updated successfully."
    }

    Write-Host "Reloading profile..."
    Write-Debug "Reloading profile..."

    # Reload the profile script
    . $profilePath

    Write-Host "Reloading module PSDirectoryStack..."
    Write-Debug "Reloading module PSDirectoryStack..."

    # Reload the module to ensure the latest version is used
    if (Get-Module -Name PSDirectoryStack) {
        Remove-Module -Name PSDirectoryStack
    }
    Import-Module -Name PSDirectoryStack

    Write-Host "Profile and module reloaded successfully."
    Write-Debug "Profile and module reloaded successfully."
}

# Example usage:
# Update-UserProfileForEnhancedLocationModule
