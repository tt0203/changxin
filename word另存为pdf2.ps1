Function Get-FileName($initialDirectory)
{
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null  
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.Multiselect = $true
    $OpenFileDialog.filter = "All files (*.*)| *.*"
    $OpenFileDialog.ShowDialog() | Out-Null
    $OpenFileDialog.filename
}


$docPath = Get-FileName -initialDirectory "C:\Users\Administrator\Desktop"
$pdfPath = 'C:\Users\Administrator\Desktop\test.pdf'
$wordApp = New-Object -ComObject Word.Application
 
$document = $wordApp.Documents.Open($docPath)
$document.SaveAs([ref] $pdfPath, [ref] 17)
$document.Close()
$wordApp.Quit()



