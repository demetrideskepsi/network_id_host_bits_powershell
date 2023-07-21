. .\decimal_binary_byte_conversion.ps1

function DecimaltoBinaryIP{
    param([String]$ipaddress)
    $bytes = $ipaddress.split(".")
    $binaryaddress = ""

    for ($i = 0; $i -lt 4; $i++){
        $byte = $bytes[$i]
        $binaryaddress += DecimaltoBinary $byte
    }
    
    return $binaryaddress
}

function BinarytoDecimalIP{
    param([String]$ipaddress)
    $decimaladdress = ""

    for ($i = 0; $i -lt 24; $i += 8){
        $decimaladdress += (BinarytoDecimal $ipaddress.Substring($i,8)) + "."
    }
    $decimaladdress += (BinarytoDecimal $ipaddress.Substring(24,8))

    return $decimaladdress
}