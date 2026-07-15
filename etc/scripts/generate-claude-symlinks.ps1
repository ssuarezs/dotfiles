#!/usr/bin/env pwsh
#Requires -Version 5.1

$ErrorActionPreference = "Stop"

$scriptDir = $PSScriptRoot
$projectDir = (Resolve-Path (Join-Path $scriptDir "..\..")).Path

function Test-SymlinkPrivilege {
    $testLink = Join-Path $env:TEMP ([System.IO.Path]::GetRandomFileName())
    try {
        New-Item -ItemType SymbolicLink -Path $testLink -Value $env:TEMP -ErrorAction Stop | Out-Null
        Remove-Item $testLink -Force -ErrorAction SilentlyContinue
        return $true
    } catch {
        return $false
    }
}

if (-not (Test-SymlinkPrivilege)) {
    Write-Error "Cannot create symlinks. Enable Developer Mode (Settings > Privacy & Security > For developers) or run this script as Administrator."
    exit 1
}

Get-ChildItem -Path $projectDir -Filter "AGENTS.md" -Recurse -File |
    Where-Object { $_.FullName -notmatch '\\node_modules\\' } |
    ForEach-Object {
        $dir = $_.DirectoryName
        $claudeFile = Join-Path $dir "CLAUDE.md"

        if (Test-Path $claudeFile) {
            Write-Host "Skipping $claudeFile (already exists)"
            return
        }

        Push-Location $dir
        try {
            New-Item -ItemType SymbolicLink -Path $claudeFile -Value "AGENTS.md" | Out-Null
            Write-Host "Created symlink $claudeFile -> AGENTS.md"
        } finally {
            Pop-Location
        }
    }

$claudeDir = Join-Path $projectDir ".claude"
if (-not (Test-Path $claudeDir)) {
    New-Item -ItemType Directory -Path $claudeDir | Out-Null
}

$skillsLink = Join-Path $claudeDir "skills"
if (Test-Path $skillsLink) {
    (Get-Item $skillsLink -Force).Delete()
}

Push-Location $claudeDir
try {
    New-Item -ItemType SymbolicLink -Path $skillsLink -Value "..\.agents\skills" | Out-Null
    Write-Host "Created symlink $skillsLink -> ..\.agents\skills"
} finally {
    Pop-Location
}
