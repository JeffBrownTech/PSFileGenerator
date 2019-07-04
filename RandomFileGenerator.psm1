function New-RandomFile {
    <#
    .SYNOPSIS
    Generates a blank file with a randmon file name and extension, e.g. 1f3ulze1.1qg.
    
    .DESCRIPTION
    This cmdlet creates a 0 byte file with a randmon file name and extension. This cmdlet uses the GetRandomFileName() method found in the System.IO .NET namespace. The random file can also be created in a specified path or with a specific file extension.

    .EXAMPLE
    New-RandomFile
    Example 1 will create a random file in the current directory.

    .EXAMPLE
    New-RandomFile -Path C:\temp
    Example 2 will create a random file in C:\temp directory.

    .EXAMPLE
    New-RandomFile -FileExtension txt
    Example 3 will create a random file with a "txt" extension

    .NOTES

    #>

    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$Path,

        [Parameter()]
        [string]$FileExtension
    )

    $randomFileName = [System.IO.Path]::GetRandomFileName()
    
    if ($PSBoundParameters.ContainsKey("FileExtension")) {
        $tempFileName = $randomFileName.Split('.')
        $randomFileName = $tempFileName[0] + "." + $FileExtension
    }

    if ($PSBoundParameters.ContainsKey("Path")) {
        $NewItemHashArguments = @{
            Path = $Path
            Name = $randomFileName
            ItemType = "File"
        }
    }
    else {
        $NewItemHashArguments = @{
            Name = $randomFileName
            ItemType = "File"
        }
    }
    
    try {
        $newFile = New-Item @NewItemHashArguments
    }
    catch {
        #Do nothing for now
    }
    

    $output = [PSCustomObject][ordered]@{
        FilePath = $newFile.DirectoryName
        FileName = $newFile.Name
    }

    Write-Output -InputObject $output

} # End of New-RandomFile function

Export-ModuleMember -Function New-RandomFile