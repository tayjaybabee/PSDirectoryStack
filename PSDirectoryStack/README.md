
# PSDirectoryStack

`PSDirectoryStack` is a PowerShell module that enhances the functionality of directory navigation commands. It introduces a directory stack that allows for pushing and popping directories, as well as enhanced `cd` behavior.

## Features

- **Push-Location**: Save the current location and navigate to a new directory.
- **Pop-Location**: Return to the last saved location.
- **Switch-Location**: Switch between the current location and the last saved location.
- **Set-LocationEnhanced**: Enhanced `cd` command that can handle file paths and navigate to the parent directory, or switch to the user's home directory if no path is provided.

## Installation

### From PSGallery

1. Ensure you have the latest version of PowerShellGet:
    ```powershell
    Install-Module -Name PowerShellGet -Force -Scope CurrentUser
    ```

2. Set up PowerShell to install from repositories and trust PSGallery:
    ```powershell
    Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
    ```

3. Install the PSDirectoryStack module:
    ```powershell
    Install-Module -Name PSDirectoryStack -Scope CurrentUser
    ```

### From Source

1. Clone the repository to your local machine:
    ```sh
    git clone https://github.com/yourusername/PSDirectoryStack.git
    ```

2. Import the module in your PowerShell profile:
    ```powershell
    Import-Module -Name "path\to\PSDirectoryStack\PSDirectoryStack.psm1"
    ```

3. Optionally, you can run the `Update-UserProfileForEnhancedLocationModule` function to automatically add the necessary imports and aliases to your PowerShell profile:
    ```powershell
    Update-UserProfileForEnhancedLocationModule
    ```

## Usage

### Functions

#### Push-Location
Save the current location and navigate to a new directory.
```powershell
Push-Location -Path "C:\Path\To\Directory"
```

#### Pop-Location
Return to the last saved location.
```powershell
Pop-Location
```

#### Switch-Location
Switch between the current location and the last saved location.
```powershell
Switch-Location
```

#### Set-LocationEnhanced
Enhanced `cd` command that can handle file paths and navigate to the parent directory, or switch to the user's home directory if no path is provided.
```powershell
Set-LocationEnhanced "C:\Path\To\DirectoryOrFile"
```

### Aliases
For convenience, the following aliases are created for the enhanced commands:

- `cd` -> `Set-LocationEnhanced`
- `pushd` -> `Push-Location`
- `popd` -> `Pop-Location`
- `switchd` -> `Switch-Location`

## Examples

### Navigate to a Directory
```powershell
cd "C:\Users\yourusername\Documents"
```

### Navigate to the Parent Directory of a File
```powershell
cd "C:\Users\yourusername\Documents\file.txt"
```

### Navigate to the Home Directory
```powershell
cd
```

### Push and Pop Directories
```powershell
pushd "C:\Users\yourusername\Documents"
popd
```

### Switch Directories
```powershell
cd "C:\Users\yourusername\Documents"
cd "C:\Users\yourusername\Downloads"
switchd
```

### Use `cd -` to Switch Between Last Two Directories
```powershell
# Start in the home directory
cd $HOME

# Navigate to Documents
cd "C:\Users\yourusername\Documents"
# Output: Current directory is now C:\Users\yourusername\Documents

# Navigate to Downloads
cd "C:\Users\yourusername\Downloads"
# Output: Current directory is now C:\Users\yourusername\Downloads

# Switch back to Documents using 'cd -'
cd -
# Output: Current directory is now C:\Users\yourusername\Documents

# Switch back to Downloads using 'cd -' again
cd -
# Output: Current directory is now C:\Users\yourusername\Downloads
```

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request.

## License

This project is licensed under the MIT License.

## Author

T. Blackstone, Inspyre-Softworks
