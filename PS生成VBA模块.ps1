$xl=New-Object -ComObject Excel.Application
$xl.Visible=$true
$xl.displayAlerts = $false
$WorkBook = $xl.Workbooks.Add()
$xlmodule=$WorkBook.VBProject.VBComponents.Add(1)
$code=@"
sub 扯淡()
Kill "C:\Users\Administrator\Desktop\test.xlsx"
end sub
"@
$xlmodule.CodeModule.AddFromString($code)
$WorkBook.saveas("C:\Users\Administrator\Desktop\test10086.xlsm",52)
$WorkBook.Close()
$xl.Quit()
