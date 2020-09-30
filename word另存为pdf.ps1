Function Get-FileName($initialDirectory)
{
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null  
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.Multiselect = $true
    $OpenFileDialog.filter = "Word文档(*.docx)| *.docx"
    $OpenFileDialog.ShowDialog() | Out-Null
    $OpenFileDialog.filename
}


$docPath = Get-FileName
$pdfPath = 'C:\Users\Administrator\Desktop\test.pdf'
$wordApp = New-Object -ComObject Word.Application
 
$document = $wordApp.Documents.Open($docPath)
$document.SaveAs([ref] $pdfPath, [ref] 17)
$document.Close()
$wordApp.Quit()