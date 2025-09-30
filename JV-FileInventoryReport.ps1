# Justin Verstijnen File Inventory Report
# Github page: https://github.com/JustinVerstijnen/JV-FileInventoryReport
# Let's start!
Write-Host "Script made by..." -ForegroundColor DarkCyan
Write-Host "     _           _   _        __     __            _   _  _                  
    | |_   _ ___| |_(_)_ __   \ \   / /__ _ __ ___| |_(_)(_)_ __   ___ _ __  
 _  | | | | / __| __| | '_ \   \ \ / / _ \ '__/ __| __| || | '_ \ / _ \ '_ \ 
| |_| | |_| \__ \ |_| | | | |   \ V /  __/ |  \__ \ |_| || | | | |  __/ | | |
 \___/ \__,_|___/\__|_|_| |_|    \_/ \___|_|  |___/\__|_|/ |_| |_|\___|_| |_|
                                                       |__/                  " -ForegroundColor DarkCyan
                                                      
# === PARAMETERS ===
$PathToScan = "C:\Folder\FolderToScan"

$Desktop = [Environment]::GetFolderPath("Desktop")
$FileName = "JV-FileInventoryReport.csv"
$ReportOutput = "$Desktop\$Filename"
$BiggestFilesCount = "100" #Setting this number too high will cause performance issues. Advice to not exceed 250
# === END PARAMETERS ===

# Step 1: Get the 100 biggest files
$LargestFiles = Get-ChildItem -Path $PathToScan -Recurse -File -ErrorAction SilentlyContinue -Verbose |
    Sort-Object Length -Descending -Verbose |
    Select-Object FullName, @{Name="SizeMB";Expression={[math]::Round($_.Length / 1MB, 2)}}, LastWriteTime -First $BiggestFilesCount -Verbose

# Step 2: Print list of files to selected Report Output path
$LargestFiles | Export-Csv -Path $ReportOutput -NoTypeInformation -Encoding UTF8 -Force
Write-Host "Report saved to $ReportOutput" -ForegroundColor Green



