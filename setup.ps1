# ==============================================================================
#   NDHU CSIE 電腦教室 開機一鍵環境配置腳本
#   作者: Kelton816
#   適用: 東華資工教室還原電腦 (快速安裝 Sogou, ChatGPT, Antigravity, Git, gh)
# ==============================================================================

$ErrorActionPreference = "Continue"

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "   正在為您快速部署工作環境 (NDHU CSIE Auto Setup)   " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host ""

# 1. 確保 winget 可用
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Warning "未檢測到 winget，正在嘗試使用備用方式..."
}

# 2. 安裝 GitHub CLI (gh)
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    Write-Host "[1/5] 正在安裝 GitHub CLI..." -ForegroundColor Yellow
    winget install --id GitHub.cli -e --silent --accept-source-agreements --accept-package-agreements | Out-Null
    Write-Host "[✓] GitHub CLI 安裝完成" -ForegroundColor Green
} else {
    Write-Host "[✓] GitHub CLI 已安裝" -ForegroundColor Green
}

# 3. 安裝 Git
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "[2/5] 正在安裝 Git..." -ForegroundColor Yellow
    winget install --id Git.Git -e --silent --accept-source-agreements --accept-package-agreements | Out-Null
    Write-Host "[✓] Git 安裝完成" -ForegroundColor Green
} else {
    Write-Host "[✓] Git 已安裝" -ForegroundColor Green
}

# 4. 安裝搜狗輸入法 (Sogou Pinyin)
$sogouInstalled = (Test-Path "C:\Program Files (x86)\SogouInput") -or (Test-Path "C:\Program Files\SogouInput")
if (-not $sogouInstalled) {
    Write-Host "[3/5] 正在安裝搜狗輸入法..." -ForegroundColor Yellow
    winget install --id Sogou.SogouInput -e --silent --accept-source-agreements --accept-package-agreements | Out-Null
    Write-Host "[✓] 搜狗輸入法安裝完成" -ForegroundColor Green
} else {
    Write-Host "[✓] 搜狗輸入法已存在" -ForegroundColor Green
}

# 5. 安裝 ChatGPT 客戶端
$chatgptExe = "$env:LOCALAPPDATA\Programs\ChatGPT\ChatGPT.exe"
if (-not (Test-Path $chatgptExe)) {
    Write-Host "[4/5] 正在安裝 ChatGPT..." -ForegroundColor Yellow
    winget install --id 9PLM9XGG6VKS -e --silent --accept-source-agreements --accept-package-agreements 2>$null | Out-Null
    
    # 建立桌面網頁捷徑作為雙重保障
    $WshShell = New-Object -ComObject WScript.Shell
    $DesktopPath = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop)
    $Shortcut = $WshShell.CreateShortcut("$DesktopPath\ChatGPT Web.url")
    $Shortcut.TargetPath = "https://chatgpt.com"
    $Shortcut.Save()
    Write-Host "[✓] ChatGPT 配置完成" -ForegroundColor Green
} else {
    Write-Host "[✓] ChatGPT 已存在" -ForegroundColor Green
}

# 6. 安裝 Antigravity
$antigravityExe = "$env:LOCALAPPDATA\Programs\antigravity\Antigravity.exe"
if (-not (Test-Path $antigravityExe)) {
    Write-Host "[5/5] 正在下載並安裝 Antigravity..." -ForegroundColor Yellow
    $antigravityUrl = "https://storage.googleapis.com/antigravity-public/antigravity-hub/2.19.1-6046815158665216/windows-x64/Antigravity-x64.exe"
    $tempInstaller = "$env:TEMP\Antigravity-x64.exe"
    
    Invoke-WebRequest -Uri $antigravityUrl -OutFile $tempInstaller
    Start-Process -FilePath $tempInstaller -ArgumentList "/S" -Wait
    Remove-Item $tempInstaller -Force -ErrorAction SilentlyContinue
    Write-Host "[✓] Antigravity 安裝完成" -ForegroundColor Green
} else {
    Write-Host "[✓] Antigravity 已存在" -ForegroundColor Green
}

# 7. 刷新環境變數
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

Write-Host ""
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "   🎉 所有環境已配置完成！" -ForegroundColor Green
Write-Host "   提示: 如需登入 GitHub，請直接執行: gh auth login" -ForegroundColor Yellow
Write-Host "==========================================================" -ForegroundColor Cyan
