
### Changelog for PSDirectoryStack Module

#### Version 1.2 - 2024-06-11

**Changes:**

1. **Global DebugPreference:**
   - Updated the `Set-DebugMode` function to set the `$global:DebugPreference` variable instead of `$DebugPreference`.

   ```powershell
   function Set-DebugMode {
       param (
           [switch]$EnableDebug
       )
       if ($EnableDebug) {
           $global:DebugPreference = 'Continue'
       }
   }
   ```

2. **Set-DebugMode Usage:**
   - Modified `Set-DebugMode` calls to use the updated `$global:DebugPreference` within the `Update-UserProfileForPSDirectoryStack` and `Get-PSDirectoryStackVersion` functions.

   ```powershell
   function Update-UserProfileForPSDirectoryStack {
       param (
           [Alias('h')]
           [switch]$Help,
           [Alias('D')]
           [switch]$Debug
       )

       Set-DebugMode -EnableDebug:$Debug

       Write-Debug "Starting Update-UserProfileForPSDirectoryStack"
       ...
   }

   function Get-PSDirectoryStackVersion {
       param (
           [Alias('h')]
           [switch]$Help,
           [Alias('D')]
           [switch]$Debug
       )

       if ($Debug) {
           Set-DebugMode -EnableDebug:$Debug
       }

       Write-Debug "Starting Get-PSDirectoryStackVersion"
       ...
   }
   ```

3. **Function Formatting and Debugging:**
   - Ensured consistent formatting and usage of `Write-Debug` for debugging messages across functions.

4. **Additional Enhancements and Error Handling:**
   - Enhanced error handling and path resolution in `Set-LocationEnhanced`.
   - Improved the robustness of `Update-UserProfileForPSDirectoryStack` to check and update the user profile script accurately.
   - Ensured that the module reload logic in `Update-UserProfileForPSDirectoryStack` functions as intended.

5. **Documentation Updates:**
   - Updated inline help documentation for functions to reflect new parameters and usage examples.

**Example of new inline help documentation:**

```powershell
function Update-UserProfileForPSDirectoryStack {
    param (
        [Alias('h')]
        [switch]$Help,
        [Alias('D')]
        [switch]$Debug
    )

    Set-DebugMode -EnableDebug:$Debug

    Write-Debug "Starting Update-UserProfileForPSDirectoryStack"

    # Manually check for --help argument in the invocation line
    $invocation = $PSCmdlet.MyInvocation
    if ($Help -or $invocation.Line -like "*--help*") {
        @"
NAME
    Update-UserProfileForPSDirectoryStack

SYNOPSIS
    Updates the user's PowerShell profile to import the PSDirectoryStack and set aliases.

SYNTAX
    Update-UserProfileForPSDirectoryStack [-Help] [-Debug]

DESCRIPTION
    This function dynamically determines the path to the PSDirectoryStack's .psm1 file, 
    updates the user's PowerShell profile to import the module, and sets aliases for enhanced 
    location handling. It then reloads the profile to apply the changes immediately.

PARAMETERS
    -Help
        Displays this help message.

    -Debug
        Enables debug messages.

EXAMPLES
    PS> Update-UserProfileForPSDirectoryStack
    Updates the user's profile with the module import and alias commands, then reloads the profile.

NOTES
    Author: T. Blackstone
    Company: Inspyre-Softworks
    This function is part of the PSDirectoryStack module.
"@
        return
    }
    ...
}
```

**Bug Fixes:**
- Fixed an issue where debug messages were not displayed correctly when the `-Debug` switch was used.

---

