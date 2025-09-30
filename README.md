# JV-FileInventoryReport

A simple PowerShell script to generate a report of the largest files within a specified directory.  
The script recursively scans a given path, sorts files by size, and exports the top results to a CSV file on the user’s Desktop.  

---

## Features
- Recursively scans a directory  
- Finds the **N largest files**  
- Exports results to **CSV** (easy to open in Excel)  
- User-friendly ASCII banner for output  

---

## Parameters
You can edit the following parameters at the top of the script:

```powershell
$PathToScan = "E:\Shares\Administratie"   # The folder you want to scan
$Desktop = [Environment]::GetFolderPath("Desktop")
$FileName = "JV-FileInventoryReport.csv"  # The name of the output report
$ReportOutput = "$Desktop\$Filename"      # Path where report will be saved
$BiggestFilesCount = "100"                # How many largest files to include (max recommended: 250)
```

---

## Example Output
The CSV report includes:  
- **FullName** → Full path of the file  
- **SizeMB** → File size in MB  
- **LastWriteTime** → Last modification date  

---

## Usage
1. Download or clone the repository:  
   ```bash
   git clone https://github.com/JustinVerstijnen/JV-FileInventoryReport.git
   ```
2. Open PowerShell and run the script:  
   ```powershell
   .\JV-FileInventoryReport.ps1
   ```
3. After execution, the report will be saved to your **Desktop**.  

---

## License
This project is licensed under the MIT License.  
See the [LICENSE](LICENSE) file for details.  
