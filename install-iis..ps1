# Installs the web-server feature and creates a static page displaying the VM hostname

Install-WindowsFeature -Name 'web-server'
Add-Content -Path "c:\inetpub\wwwroot\default.htm" -Value $($env:computername)