(get-WmiObject win32_process -Filter "name='PBIDesktop.exe'").commandline.split('"')[3]

