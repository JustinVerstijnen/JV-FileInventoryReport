# Justin Verstijnen File Inventory Report
# Github page: https://github.com/JustinVerstijnen/JV-FileInventoryReport
Write-Host "Script made by..." -ForegroundColor DarkCyan
Write-Host "     _           _   _        __     __            _   _  _                  
    | |_   _ ___| |_(_)_ __   \ \   / /__ _ __ ___| |_(_)(_)_ __   ___ _ __  
 _  | | | | / __| __| | '_ \   \ \ / / _ \ '__/ __| __| || | '_ \ / _ \ '_ \ 
| |_| | |_| \__ \ |_| | | | |   \ V /  __/ |  \__ \ |_| || | | | |  __/ | | |
 \___/ \__,_|___/\__|_|_| |_|    \_/ \___|_|  |___/\__|_|/ |_| |_|\___|_| |_|
                                                       |__/                  " -ForegroundColor DarkCyan
                                                      
# === PARAMETERS ===
$PathToScan = "C:\Folder\ToScan"

$Desktop = [Environment]::GetFolderPath("Desktop")
$HtmlName = "JV-FileInventoryReport.html"
$HtmlOutput = "$Desktop\$HtmlName"
$BiggestFilesCount = "100"
# === END PARAMETERS ===

# Step 1: Get the 100 biggest files
$LargestFiles = Get-ChildItem -Path $PathToScan -Recurse -File -ErrorAction SilentlyContinue -Verbose |
    Sort-Object Length -Descending -Verbose |
    Select-Object FullName, @{Name="SizeMB";Expression={[math]::Round($_.Length / 1MB, 2)}}, LastWriteTime -First $BiggestFilesCount -Verbose

# Step 2: Export to HTML
$HtmlHeader = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>JV-FileInventoryReport</title>
    <style>
        body {
            font-family: "Segoe UI", Arial, sans-serif;
            background-color: #f9fafa;
            color: #333;
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #eaf6ff;
            padding: 20px;
            text-align: center;
        }
        header img {
            height: 60px;
        }
        h1 {
            margin: 10px 0 0 0;
            color: #8EAFDA;
        }
        table {
            width: 95%;
            margin: 20px auto;
            border-collapse: collapse;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 10px 15px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #8EAFDA;
            color: white;
            text-transform: uppercase;
            font-size: 14px;
        }
        tr:nth-child(even) {
            background-color: #f4f9ff;
        }
        tr:hover {
            background-color: #e8f0fb;
        }
        footer {
            text-align: center;
            font-size: 12px;
            padding: 15px;
            color: #555;
        }
        a {
            color: #8EAFDA;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <header>
        <a href="https://justinverstijnen.nl" target="_blank">
            <img src="https://justinverstijnen.nl/wp-content/uploads/2025/04/cropped-Logo-2.0-Transparant.png" alt="Logo">
        </a>
        <h1>File Inventory Report</h1>
    </header>
    <main>
        <table>
            <thead>
                <tr>
                    <th>Full Path</th>
                    <th>Size (MB)</th>
                    <th>Last Write Time</th>
                </tr>
            </thead>
            <tbody>
"@

$HtmlRows = $LargestFiles | ForEach-Object {
    "<tr><td>$($_.FullName)</td><td>$($_.SizeMB)</td><td>$($_.LastWriteTime)</td></tr>"
}

$HtmlFooter = @"
            </tbody>
        </table>
    </main>
    <footer>
        Report generated on $(Get-Date -Format "yyyy-MM-dd HH:mm")<br>
        <a href="https://github.com/JustinVerstijnen/JV-FileInventoryReport">View on GitHub</a>
    </footer>
</body>
</html>
"@

$HtmlContent = $HtmlHeader + ($HtmlRows -join "`n") + $HtmlFooter
$HtmlContent | Out-File -FilePath $HtmlOutput -Encoding UTF8 -Force

Write-Host "HTML Report saved to $HtmlOutput" -ForegroundColor Green
