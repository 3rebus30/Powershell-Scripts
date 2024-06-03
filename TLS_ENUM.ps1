﻿#Provide Lists of Machines
$machines = "sec-varonissql", "ruinventory", "cs-sccm" 


#Query Versions of used TLS
$result = Invoke-Command -ComputerName $machines -ScriptBlock {
    # Get the supported Security Protocols
    $supported = [Net.ServicePointManager]::SecurityProtocol
    # Define the Security Protocol values
    $SecurityProtocolType = [Net.SecurityProtocolType]

    [PsCustomObject]@{
        ComputerName  = $env:COMPUTERNAME
        SystemDefault = [bool]($supported -eq $SecurityProtocolType::SystemDefault)
        Ssl3          = [bool]($supported -band $SecurityProtocolType::Ssl3)
        Tls10           = [bool]($supported -band $SecurityProtocolType::Tls)
        Tls11         = [bool]($supported -band $SecurityProtocolType::Tls11)
        Tls12         = [bool]($supported -band $SecurityProtocolType::Tls12)
        Tls13         = [bool]($supported -band $SecurityProtocolType::Tls13)
    }
}

# Output the result in terminal
$result | Format-Table -AutoSize
