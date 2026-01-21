# -------- CONFIG --------
$frontendUrl = "http://localhost:5173"       # Your app URL
$composePath = "D:\docker\second\seconddoc" # Path to docker-compose.yml
# ------------------------

# Change to folder with docker-compose.yml
Set-Location $composePath

function Start-Compose {
    Write-Host "Starting all Docker Compose services..."
    docker compose up -d

    Write-Host "Waiting for frontend to be ready..."
    while ($true) {
        try {
            $response = Invoke-WebRequest -Uri $frontendUrl -UseBasicParsing -TimeoutSec 2
            if ($response.StatusCode -eq 200) { break }
        } catch {}
        Start-Sleep -Seconds 1
    }

    Write-Host "Frontend ready. Opening browser..."
    Start-Process $frontendUrl
}

# Initial start
Start-Compose

Write-Host "`nPress SHIFT + ESC to stop/restart Docker Compose..."

while ($true) {
    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

    # Check if Shift is pressed and key is Esc (VirtualKeyCode 27)
    if ($key.ShiftKeyDown -and $key.VirtualKeyCode -eq 27) {
        Write-Host "`nStopping all containers and removing volumes..."
        docker compose down -v
        Write-Host "Press SHIFT + ESC again to start Docker Compose..."
        do {
            $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        } until ($key.ShiftKeyDown -and $key.VirtualKeyCode -eq 27)
        Write-Host "Restarting Docker Compose..."
        Start-Compose
        Write-Host "`nPress SHIFT + ESC to stop/restart again..."
    }
}
