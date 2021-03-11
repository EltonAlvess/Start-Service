#
# Author: Elton Alves
# Date: 2020-03-11
# Version: 1.0
# Start Service
#

param ([switch] $help, $serviceName)

if($help)
{
    write-host "Run StartService <ServiceName>"
    exit
}

if($serviceName -eq $null){exit Write-Host "Wrong param name, you should use [StartService -serviceName] or [StartService -help]"}

$serviceObj = Get-Service -Name $serviceName

if($serviceObj.Status -eq "Stopped"){
    Start-Service -Name $serviceName
    do
    {
        $count = (Get-Service -Name $serviceName | ? {$_.status -eq "Running"}).count 
        sleep -Milliseconds 600
        $serviceObj = Get-Service -Name $serviceName
    }until($serviceObj.Status -eq "Running")

    Write-Host "Service " "'"$serviceName "'" "started Successfull"    
}
else{ 
    write-host "Service" "'"$serviceName "'" "already running!"
}