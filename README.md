# 64SE PowerShell Module

## Overview

64SE is a PowerShell module designed to facilitate the encoding and decoding of strings and files using Base64. This module provides a straightforward approach for handling Base64 operations, often used for data transmission and storage in various applications.

## Features

- **Encode-StringToBase64**: Converts a plain text string to its Base64 encoded equivalent.
- **Decode-Base64ToString**: Converts a Base64 encoded string back to plain text.
- **Encode-FileToBase64**: Encodes the contents of a file into a Base64 string and saves it to a new file with `.64SE` appended to the original filename.
- **Decode-Base64ToFile**: Decodes a Base64 string and writes the decoded data to a file. If the filename contains `.64SE.`, it will be replaced with `.decoded.`; otherwise, `.decoded` will be added before the file extension.

## Installation

### PowerShell Gallery

You can install 64SE directly from the PowerShell Gallery:

```powershell
Install-Module -Name 64SE
