 
$iloSession             = Connect-HPERedfish -address <IP-address> -username <ilo-username> -password <password> -DisableCertificateAuthentication


$UpdateService          = $iloSession.rootData.UpdateService.'@odata.id'
$_data                  = Get-HPERedfishDataRaw -odataid $updateService -Session $iloSession -DisableCertificateAuthentication

$_fw_odataid            = $_data.FirmwareInventory.'@odata.id'
$_fw_data               = Get-HPERedfishDataRaw -odataid $_fw_odataid -Session $iloSession -DisableCertificateAuthentication        



foreach ($_m in $_fw_data.members)
{
    $_fw                = Get-HPERedfishDataRaw -odataid $_m.'@odata.id' -Session $iloSession -DisableCertificateAuthentication        

    write-host "$($_fw.Name),$($_fw.Description),$($_fw.Version)"

}

Disconnect-HPERedfish -session $iloSession -DisableCertificateAuthentication        
