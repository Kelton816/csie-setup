# 🎓 NDHU CSIE 電腦教室開機一鍵環境配置

東華大學資工系（NDHU CSIE）電腦教室的電腦在重新開機後會自動由 **NeoSUITE 還原防護系統** 還原至原始狀態。

本專案提供**一鍵自動安裝與環境部署腳本**，每次開機後只需執行一行指令，即可在數十秒內自動完成常用軟體的下載與安裝。

---

## 🚀 每次開機後的一鍵使用方式

1. 打開 **PowerShell**（按鍵盤 `Win + X`，選擇 **終端機** 或 **PowerShell**）。
2. 複製並貼上以下任一指令後按 `Enter` 執行：

### 方式 A：一行遠端執行（最推薦，不用手動下載）
```powershell
irm https://raw.githubusercontent.com/Kelton816/csie-setup/main/setup.ps1 | iex
```

### 方式 B：手動下載執行
```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Kelton816/csie-setup/main/setup.ps1" -OutFile "$env:TEMP\setup.ps1"; & "$env:TEMP\setup.ps1"
```

---

## 📦 本腳本自動安裝的項目

| 項目 | 說明 |
| :--- | :--- |
| **GitHub CLI (`gh`)** | GitHub 官方命令列工具（便於管理代碼與 Gist） |
| **Git** | 版本控制系統（配合 GitHub 同步進度） |
| **搜狗輸入法 (Sogou)** | 中文拼音輸入法 |
| **ChatGPT** | 官方桌面客戶端 / 桌面網頁捷徑 |
| **Antigravity** | AI 程式開發工具桌面端 |

---

## 💡 課堂與開發資料保存建議

由於電腦重開機 C 槽必定會被還原：
1. **程式碼與專案**：每次下課前使用 `git push` 推送至 GitHub（帳號已支援 `gh` 快速登入）。
2. **隨身碟**：插上 USB 隨身碟，隨身碟檔案不會被還原。
3. **ChatGPT 記錄**：登入帳號後所有紀錄同步在雲端。
