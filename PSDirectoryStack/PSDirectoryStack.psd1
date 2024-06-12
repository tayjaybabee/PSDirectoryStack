@{
    # Script module or binary module file associated with this manifest
    RootModule        = 'PSDirectoryStack.psm1'

    # Version number of this module.
    ModuleVersion     = '1.1.3'

    # ID used to uniquely identify this module
    GUID              = '0f8029c1-4dd2-4e1f-aa49-81a7b90c982c'

    # Author of this module
    Author            = 'T. Blackstone'

    # Company or vendor of this module
    CompanyName       = 'Inspyre-Softworks'

    # Description of the functionality provided by this module
    Description       = 'A PowerShell module to manage a directory stack like Linux'

    # Functions to export from this module
    FunctionsToExport = @('Push-Location', 'Pop-Location', 'Switch-Location', 'Set-LocationEnhanced', 'Update-UserProfileForEnhancedLocationModule')

    # Cmdlets to export from this module
    CmdletsToExport   = @()

    # Variables to export from this module
    VariablesToExport = @()

    # Aliases to export from this module
    AliasesToExport   = @('cd')
}