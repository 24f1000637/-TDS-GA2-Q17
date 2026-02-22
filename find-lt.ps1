$email = "24f1000637@ds.study.iitm.ac.in"

while ($true) {
    Write-Host ""
    Write-Host "Starting new tunnel..."

    # Start localtunnel
    $proc = Start-Process -PassThru -WindowStyle Hidden `
        -FilePath "npx" `
        -ArgumentList "localtunnel --port 8003 --region eu"

    Start-Sleep -Seconds 6

    Write-Host "Paste the loca.lt URL (or press Enter to retry):"
    $url = Read-Host

    if (-not $url) {
        Stop-Process -Id $proc.Id -Force -ErrorAction SilentlyContinue
        continue
    }

    Write-Host "Testing tunnel..."

    try {
        $resp = Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 10
        $body = $resp.Content.Trim()

        if ($body -eq $email) {
            Write-Host ""
            Write-Host "CLEAN TUNNEL FOUND!"
            Write-Host "SUBMIT THIS URL:"
            Write-Host $url
            break
        }
        else {
            Write-Host "Dirty tunnel. Retrying..."
        }
    }
    catch {
        Write-Host "Request failed. Retrying..."
    }

    Stop-Process -Id $proc.Id -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 2
}
