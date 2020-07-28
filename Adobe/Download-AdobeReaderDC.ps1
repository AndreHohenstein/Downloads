
<#PSScriptInfo

.VERSION 1.0.0

.GUID 843eb3e4-ebd7-4e92-9441-f9dc0b216980

.AUTHOR Andre Hohenstein

.COMPANYNAME André Hohenstein IT Training & Consulting

.COPYRIGHT © 2020 by André Hohenstein - Alle Rechte vorbehalten

.TAGS Script PowerShell Adobe Reader

.LICENSEURI

.PROJECTURI https://github.com/AndreHohenstein/Downloads/tree/main/Adobe

.ICONURI

.EXTERNALMODULEDEPENDENCIES 

.REQUIREDSCRIPTS

.EXTERNALSCRIPTDEPENDENCIES

.RELEASENOTES
Version 1.0

.PRIVATEDATA

#> 



<# 

.DESCRIPTION 
 Download free Adobe Acrobat Reader DC 

#> 
# Download Newest Version Adobe Reader DC
$web = Invoke-WebRequest -Uri 'https://get.adobe.com/reader/?loc=de' -UseBasicParsing
$version = [regex]::match($web.Content,'Version ([\d\.]+)').Groups[1].Value.Substring(2).replace('.','')
$URI = "http://ardownload.adobe.com/pub/adobe/reader/win/AcrobatDC/$Version/AcroRdrDC$($Version)_de_DE.exe"
$OutFile = "$env:USERPROFILE\Desktop\AcroRdrDC$($Version)_de_DE.exe"
Invoke-WebRequest -Uri $URI -OutFile $OutFile -Verbose


