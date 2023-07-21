param([String]$ip,[String]$sub)

. .\dec_bin_ip_conversion.ps1

function network_id{
    param([String]$ipaddress,[String]$subnet)
    $sub_len = subnet_length $subnet
    $binary_ip = (DecimaltoBinaryIP $ipaddress).Substring(0,$sub_len)

    for ($i = $sub_len; $i -lt 32; $i++){
        $binary_ip += "0"
    }
   return BinarytoDecimalIP $binary_ip
}

function host_bits {
    param([String]$net_id,[String]$subnet)
    $sub_len = subnet_length $subnet

    $hosts = (DecimaltoBinaryIP $net_id).Substring(0,$sub_len)

    for ($i = $sub_len; $i -lt 32; $i++){

            $hosts += "1"
    }

    return BinarytoDecimalIP $hosts
}

function subnet_length{
    param([String]$subnet)
    return (DecimaltoBinaryIP $subnet).Replace("0","").Length
}

if ($ip -match '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' -and (DecimaltoBinaryIP $sub) -match '(?=.{32}$)^1+0*$'){
    $id = network_id $ip $sub
    $hosts = host_bits $id $sub   
    Write-Host Network ID: $id
    Write-Host Host range: $id - $hosts    
}
elseif ($ip -notmatch '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' -and (DecimaltoBinaryIP $sub) -notmatch '(?=.{32}$)^1+0*$'){
    Write-Host "Incorrect IP Address and Subnet Mask format, must be like 192.168.1.1 255.255.0.0"
}
elseif($ip -notmatch '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}') {
    Write-Host "Incorrect IP Address format, must be like 192.168.1.1"
}
elseif ((DecimaltoBinaryIP $sub) -notmatch '(?=.{32}$)^1+0*$') {
    Write-Host "Incorrect Subnet Mask format, must be like 255.255.0.0; all 1 bits on the left all 0 bits on the right"
}




<#
SOURCES:

https://stackoverflow.com/questions/11197549/regular-expression-limit-string-size#:~:text=Sprinkle%20in%20some%20positive%20lookahead%20to%20test%20for,then%3A%20%2F%5E%20%28%3F%3D.%20%7B3%2C16%7D%24%29%20%5Ba-z%5D%20%5Ba-z0-9%5D%2A%20%28%3F%3A_%20%5Ba-z0-9%5D%2B%29%2A%24%2F

#>