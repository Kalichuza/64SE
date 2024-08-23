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
        [Convert]::ToBase64String($Bytes)
    }
}

function Decode-Base64ToFile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Base64String,

        [Parameter(Mandatory = $true, Position = 1)]
        [string]$OutputFilePath
    )

    process {
        try {
            $Bytes = [Convert]::FromBase64String($Base64String)
            [System.IO.File]::WriteAllBytes($OutputFilePath, $Bytes)
            Write-Output "File successfully created at $OutputFilePath"
        } catch {
            Write-Error "Failed to decode Base64 string: $_"
        }
    }
}

# Exporting functions
Export-ModuleMember -Function Encode-StringToBase64, Decode-Base64ToString, Encode-FileToBase64, Decode-Base64ToFile
