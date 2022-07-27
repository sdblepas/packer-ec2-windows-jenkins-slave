dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
Install-Module -Name DockerMsftProvider -Repository PSGallery -Force
Install-Package -Name docker -ProviderName DockerMsftProvider
Get-Package -Name Docker -ProviderName DockerMsftProvider
setx /M path "%path%;C:\Program Files\Docker"
Start-Service Docker
