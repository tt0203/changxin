#选择需要操作的pbix文件
Function Get-FileName($initialDirectory)
{
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null  
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.Multiselect = $true
    $OpenFileDialog.filter = "PowerBI文档(*.pbix)| *.pbix"
    $OpenFileDialog.ShowDialog() | Out-Null
    $OpenFileDialog.filename
}
#获取选择文件绝对路径变量
$pathn = Get-FileName

#改后缀pbix为zip
[Reflection.Assembly]::LoadWithPartialName('System.IO.Compression')
$zipfile = $pathn.Replace('pbix','zip')
Rename-Item -Path $pathn -NewName  $zipfile

#处理zip内部文件
$files   = 'DataMashup', 'SecurityBindings'
$stream = New-Object IO.FileStream($zipfile, [IO.FileMode]::Open)
$mode   = [IO.Compression.ZipArchiveMode]::Update
$zip    = New-Object IO.Compression.ZipArchive($stream, $mode)
#下面这句就是在压缩包内操作文件的具体步骤：删除DataMashup与SecurityBindings压缩文件
($zip.Entries | ? { $files -contains $_.Name }) | % { $_.Delete()}


#更新关闭压缩文件
$zip.Dispose()
$stream.Close()
$stream.Dispose()

#改回后缀pbix文件
Rename-Item -Path $zipfile -NewName $pathn