<#
#̷𝓍   𝓐𝓡𝓢 𝓢𝓒𝓡𝓘𝓟𝓣𝓤𝓜 
#̷𝓍   
#̷𝓍   Write-LogEntry
#̷𝓍   
#>

[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory=$false, ValueFromPipeline=$true, HelpMessage="url", Position=0)]
    [string]$Url,
    [Parameter(Mandatory=$false, ValueFromPipeline=$true, HelpMessage="Destination Directory where the files are saved", Position=1)]
    [string]$DestinationFile,
    [Parameter(Mandatory=$false, ValueFromPipeline=$true, HelpMessage="Download Mode", Position=2)]
    [ValidateSet('wgetjob','wget',"http","bits","bitsadmin")]
    [string]$DownloadMode="bitsadmin",    
    [Parameter(Mandatory=$false)]
    [switch]$Asynchronous    
)




try {

    $GuiUtilsScriptPath = "F:\Scripts\Sandbox\PowerShell.Native.ArgumentParser\tmp\GuiUtils.ps1"
    . "$GuiUtilsScriptPath"

    <#
    [void][System.Reflection.Assembly]::LoadWithPartialName('PresentationFramework')
    [void][System.Reflection.Assembly]::LoadWithPartialName('PresentationCore')
    [void][System.Reflection.Assembly]::LoadWithPartialName('WindowsBase')
    [void][System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
    [void][System.Reflection.Assembly]::LoadWithPartialName('System.Drawing')
    [void][System.Reflection.Assembly]::LoadWithPartialName('System')
    [void][System.Reflection.Assembly]::LoadWithPartialName('System.Xml')
    [void][System.Reflection.Assembly]::LoadWithPartialName('System.Windows')
    #>
    $MembersPresentationFramework   = Add-Type -AssemblyName 'PresentationFramework' -Passthru
    $MembersPresentationCore        = Add-Type -AssemblyName 'PresentationCore'
    $MembersWindowsBase             = Add-Type -AssemblyName 'WindowsBase'
    $MembersWindowsForm             = Add-Type -AssemblyName 'System.Windows.Forms'
    $MembersSystemDrawing           = Add-Type -AssemblyName 'System.Drawing'
    $MembersSystemBase              = Add-Type -AssemblyName 'System'
    $MembersSystemXml               = Add-Type -AssemblyName 'System.Xml'

    $ArgumentsList = @"

       Listing scripts arguments

       Url              : $Url
       DestinationFile  : $DestinationFile
       Url              : $Url
       DownloadMode     : $DownloadMode
       Asynchronous     : $Asynchronous

"@


    Show-DebugDisplayDialog –Message "DEUG TOOL" –WindowTitle "DEBUG TOOL" –DefaultText $ArgumentsList
 


}catch{
    Show-ExceptionDetails $_ -ShowStack
}











<#

$CurrentPath = (Get-Location).Path
$CmdLine = (Get-CimInstance Win32_Process -Filter "ProcessId = '$pid'" | select CommandLine ).CommandLine   
[string[]]$UserCommandArray = $CmdLine.Split(' ')
$ProgramFullPath = $UserCommandArray[0].Replace('"','')
$ProgramDirectory = (gi $ProgramFullPath).DirectoryName
$ProgramName = (gi $ProgramFullPath).Name
$ProgramBasename = (gi $ProgramFullPath).BaseName

$Global:LogFilePath = Join-Path ((Get-Location).Path) 'downloadtool.log'
Remove-Item $Global:LogFilePath -Force -ErrorAction Ignore | Out-Null
New-Item $Global:LogFilePath -Force -ItemType file -ErrorAction Ignore | Out-Null

if(($ProgramName -eq 'pwsh.exe') -Or ($ProgramName -eq 'powershell.exe')){
    $MODE_NATIVE = $False
    $MODE_SCRIPT = $True
}else{
    $MODE_NATIVE = $True
    $MODE_SCRIPT = $False
}







    <#
    Write-Output "===================================="
    Write-Output "COMMAND LINE ARGUMENTS HANDLING TEST"
    Write-Output "===================================="


    Write-Output "Listing scripts arguments`n"
    Write-Output "Url              : $Url"
    Write-Output "DestinationFile  : $DestinationFile"
    Write-Output "Url              : $Url"
    Write-Output "DownloadMode     : $DownloadMode"
    Write-Output "Asynchronous     : $Asynchronous"


    $ArgumentsList = @"
       Listing scripts arguments
       Url              : $Url
       DestinationFile  : $DestinationFile
       Url              : $Url
       DownloadMode     : $DownloadMode
       Asynchronous     : $Asynchronous
#>