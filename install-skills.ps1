[CmdletBinding()]
param(
    [ValidateSet('user', 'project', 'both')]
    [string]$Mode,

    [string]$ProjectDir
)

$ErrorActionPreference = 'Stop'

$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$Src = Join-Path $Root 'skills'
$SharedDir = 'shared'
$Skills = @('stem-paper-zh-write', 'stem-paper-zh-polish')

if ([string]::IsNullOrWhiteSpace($ProjectDir)) {
    $ProjectDir = $Root
}

function Show-Usage {
    @"
Usage: .\install-skills.ps1 [-Mode user|project|both] [-ProjectDir DIR]

-Mode user      Install to ~/.grok/skills, ~/.agents/skills, ~/.codex/skills
-Mode project   Install to <repo>\.grok\skills, <repo>\.agents\skills, <repo>\.codex\skills
-Mode both      Install to both user and project scopes
-ProjectDir     Target repo when Mode is project or both (default: script directory)

Examples:
  .\install-skills.ps1 -Mode user
  .\install-skills.ps1 -Mode project -ProjectDir C:\path\to\thesis-repo
  .\install-skills.ps1 -Mode both -ProjectDir C:\path\to\thesis-repo
"@
}

function Install-One {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name,

        [Parameter(Mandatory = $true)]
        [string]$Destination
    )

    $sourcePath = Join-Path $Src $Name
    if (-not (Test-Path -LiteralPath $sourcePath -PathType Container)) {
        throw "Missing $sourcePath"
    }

    New-Item -ItemType Directory -Force -Path $Destination | Out-Null

    $targetPath = Join-Path $Destination $Name
    if (Test-Path -LiteralPath $targetPath) {
        Remove-Item -LiteralPath $targetPath -Recurse -Force
    }

    Copy-Item -LiteralPath $sourcePath -Destination $Destination -Recurse
    Write-Host " -> $targetPath"
}

function Install-Shared {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Destination
    )

    $sourcePath = Join-Path $Src $SharedDir
    if (-not (Test-Path -LiteralPath $sourcePath -PathType Container)) {
        throw "Missing $sourcePath"
    }

    New-Item -ItemType Directory -Force -Path $Destination | Out-Null

    $targetPath = Join-Path $Destination $SharedDir
    if (Test-Path -LiteralPath $targetPath) {
        Remove-Item -LiteralPath $targetPath -Recurse -Force
    }

    Copy-Item -LiteralPath $sourcePath -Destination $Destination -Recurse
    Write-Host " -> $targetPath"
}

function Install-Bundle {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Destination
    )

    Install-Shared -Destination $Destination
    foreach ($skill in $Skills) {
        Install-One -Name $skill -Destination $Destination
    }
}

function Install-UserScope {
    $userHome = [Environment]::GetFolderPath('UserProfile')

    Write-Host 'User scope:'
    Install-Bundle -Destination (Join-Path $userHome '.grok\skills')
    Install-Bundle -Destination (Join-Path $userHome '.agents\skills')
    Install-Bundle -Destination (Join-Path $userHome '.codex\skills')
}

function Install-ProjectScope {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RepoRoot
    )

    Write-Host "Project scope ($RepoRoot):"
    Install-Bundle -Destination (Join-Path $RepoRoot '.grok\skills')
    Install-Bundle -Destination (Join-Path $RepoRoot '.agents\skills')
    Install-Bundle -Destination (Join-Path $RepoRoot '.codex\skills')
}

if (-not $Mode) {
    Write-Host 'Choose install mode:'
    Write-Host '  1) user'
    Write-Host '  2) project'
    Write-Host '  3) both'

    $choice = Read-Host 'Enter 1/2/3 [1]'
    switch ($choice) {
        '' { $Mode = 'user' }
        '1' { $Mode = 'user' }
        '2' { $Mode = 'project' }
        '3' { $Mode = 'both' }
        default {
            Show-Usage
            throw "Invalid choice: $choice"
        }
    }
}

switch ($Mode) {
    'user' {
        Install-UserScope
    }
    'project' {
        Install-ProjectScope -RepoRoot $ProjectDir
    }
    'both' {
        Install-UserScope
        Install-ProjectScope -RepoRoot $ProjectDir
    }
    default {
        Show-Usage
        throw "Invalid mode: $Mode"
    }
}

Write-Host 'Done. Slash commands: /stem-paper-zh-write, /stem-paper-zh-polish'
Write-Host "Modes: say 'natural' (default) or 'source-grounded' when invoking either skill."
