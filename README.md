# RandomFileGenerator-Module
Module containing functions for generating random files, specifying file size, and adding content

## Cmdlets

### New-RandomFile

Creates a random file using [System.IO.Path]::GetRandomFileName()

Current parameters:
- Path
    - Specifies path to create random file, otherwise creates it in the current directory
- FileExtension
    - Specifies a file extension to use, otherwise uses random 3 character extension