$script:nm=Read-Host("please write pbiDesktopWindowName")
Get-PBIDesktopTCPPort -pbiDesktopWindowName "$nm"