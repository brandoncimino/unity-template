$butler_dir = "$PSScriptRoot/butler"

enum OS {
    Windows
    Mac
    Linux
}

function Get-OS(){
    if($IsWindows){
        return [OS]::Windows
    }
    elseif($IsMacOS){
        return [OS]::Mac
    }
    elseif($IsLinux){
        return [OS]::Linux
    }
    else{
        throw "You seem to not _have_ an operating system. `$env:OS = $env:OS"
    }
}

#tag::get-butler[]
function Get-Butler() {
    #region Clean the butler dir
    Write-Host -ForegroundColor DarkGray "Cleaning $butler_dir"
    Remove-Item $butler_dir -Force -ErrorAction Ignore -Recurse
    New-Item $path -ItemType Directory -Force
    #endregion

    #region Download the .zip file
    $butler_base_url = "https://broth.itch.ovh/butler"
    $butler_files = @{
        [OS]::Windows = "windows-amd64"
        [OS]::Mac     = "darwin-amd64"
        [OS]::Linux   = "linux-amd64"
    }

    $butler_file = $butler_files[(Get-Os)]
    $butler_name = "butler_$butler_file"
    $butler_url = "$butler_base_url/$butler_file/LATEST/archive/default"
    $out_file_name = "$butler_name.zip"
    $out_file_path = "$butler_dir/$out_file_name"

    Write-Host -ForegroundColor DarkGray "Downloading butler from: $butler_url"

    Invoke-WebRequest -Uri $butler_url -OutFile $out_file_path

    $butler_zip = Get-Item $out_file_path

    Write-Host -ForegroundColor Green "Downloaded butler: $butler_zip"
    #endregion

    #region Extract the .zip file
    Write-Host -ForegroundColor DarkGray "Extracting butler..."

    Expand-Archive $butler_zip -DestinationPath "$butler_dir/$butler_name"

    $butler_exe = Get-Item "$butler_dir/$butler_name/butler.exe"

    Write-Host -ForegroundColor Green "Extracted butler: $butler_exe"
    #endregion

    return $butler_exe
}
#end::get-butler[]
