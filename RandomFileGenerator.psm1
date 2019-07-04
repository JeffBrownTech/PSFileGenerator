function New-RandomFile {
    <#
    .SYNOPSIS
    .DESCRIPTION
    .EXAMPLE
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