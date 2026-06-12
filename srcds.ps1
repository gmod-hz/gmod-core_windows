param(
    [switch]$Install,
    [switch]$Development
)

function Write-Log
{
    param([string]$Text)

    Write-Host "$((Get-Date).Tostring()) $Text"
}

# https://github.com/stopthatastronaut/poshdotenv/blob/master/module/dotenv/functions/Push-DotEnv.ps1
function Read-EnvFile
{
    param([string]$Path)

    $result = @{}

    if (-not (Test-Path $Path))
    {
        return $result
    }

    foreach ($line in Get-Content $Path)
    {
        $line = $line.Trim()

        if ($line -eq "" -or $line -like "#*")
        {
            continue
        }

        $key, $value = ($line -split "=", 2).Trim()

        if ($value -like '"*"')
        {
            # expand \n to `n for double quoted values
            $value = $value -replace '^"|"$', '' -replace '(?<!\\)(\\n)', "`n"
        } elseif ($value -like "'*'")
        {
            $value = $value -replace "^'|'$", ''
        }

        $result[$key] = $value
    }

    return $result
}

function Install-Server
{
    param(
        [System.Collections.Hashtable]$Config
    )

    Start-Process -FilePath $Config["STEAMCMD_EXE"] `
        -ArgumentList "+force_install_dir `"$PSScriptRoot`" +login anonymous +app_update 4020 validate +quit" `
        -NoNewWindow `
        -Wait
}

function Start-Server
{
    param(
        [System.Collections.Hashtable]$Config
    )


    while ($true)
    {
        $ArgumentList = @(
            "-console",
            "-game", "garrysmod",
            "-port", "27015",
            "+sv_setsteamaccount",          $Config["SRCDS_GLST"],
            "+host_workshop_collection",    $Config["SRCDS_COLLECTIONID"]
            "+gamemode",                    $Config["SRCDS_GAMEMODE"],
            "+map",                         $Config["SRCDS_MAP"]
        )

        if ($Development)
        {
            $ArgumentList += @("+hide_server", "1")
        }

        Write-Log "Staring server..."

        $Process = Start-Process -FilePath "srcds.exe" -ArgumentList $ArgumentList -PassThru
        $Process.WaitForExit()
    }
}

$config = Read-EnvFile -Path ".env"

if ($Install)
{
    Install-Server -Config $config
}

Start-Server -Config $config
