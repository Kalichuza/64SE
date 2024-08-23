# 64SE.psm1

function Encode-StringToBase64 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [string]$InputString
    )

    process {
        $Bytes = [System.Text.Encoding]::UTF8.GetBytes($InputString)
        [Convert]::ToBase64String($Bytes)
    }
}

function Decode-Base64ToString {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [string]$Base64String
    )

    process {
        $Bytes = [Convert]::FromBase64String($Base64String)
        [System.Text.Encoding]::UTF8.GetString($Bytes)
    }
}
function Encode-FileToBase64 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$FilePath
    )

    process {
        if (-not (Test-Path $FilePath)) {
            Write-Error "File not found: $FilePath"
            return
        }

        $Bytes = [System.IO.File]::ReadAllBytes($FilePath)
        $Base64String = [Convert]::ToBase64String($Bytes)
        
        # Create new file path with 64SE before the file extension
        $NewFilePath = [System.IO.Path]::ChangeExtension($FilePath, "64SE" + [System.IO.Path]::GetExtension($FilePath))
        
        # Write the Base64 string to the new file
        [System.IO.File]::WriteAllText($NewFilePath, $Base64String)

        Write-Output "Encoded file created at $NewFilePath"
    }
}

function Decode-Base64ToFile {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0)]
        [string]$Base64String,

        [Parameter(Mandatory = $true, Position = 1)]
        [string]$FilePath
    )

    process {
        if (-not $Base64String) {
            # Read the content from the file if Base64String is not provided
            $Base64String = Get-Content -Path $FilePath -Raw
        }

        try {
            $Bytes = [Convert]::FromBase64String($Base64String)
            
            # Determine the new file path
            if ($FilePath -like "*.64SE.*") {
                $NewFilePath = $FilePath -replace '\.64SE\.', '.decoded.'
            } else {
                $NewFilePath = [System.IO.Path]::ChangeExtension($FilePath, ".decoded" + [System.IO.Path]::GetExtension($FilePath))
            }
            
            [System.IO.File]::WriteAllBytes($NewFilePath, $Bytes)
            Write-Output "Decoded file created at $NewFilePath"
        } catch {
            Write-Error "Failed to decode Base64 string: $_"
        }
    }
}




# Exporting functions
Export-ModuleMember -Function Encode-StringToBase64, Decode-Base64ToString, Encode-FileToBase64, Decode-Base64ToFile
