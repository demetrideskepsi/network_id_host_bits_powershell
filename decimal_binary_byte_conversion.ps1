[int]$mostbit = 128
$bits = 0,0,0,0,0,0,0,0
function DecimaltoBinary{
    param([String]$number)
    $byte = ""
    # convert decimal to binary
    for ($i = 0; $i -lt 8; $i++){
        if ($number - $mostbit -ge 0){
            $number = $number - $mostbit
            $bits[$i] = 1
        }
        elseif ($number - $mostbit){
            $bits[$i] = 0
        }
        $mostbit = $mostbit/2 
    }
    foreach ($bit in $bits){
        $byte += $bit
    }
    return [String]$byte
}
function BinarytoDecimal{
    param([String]$number)

    # convert binary to decimal
    $number = $number.ToCharArray()
    $byte = 0
    foreach ($i in -split $number){
        $byte += ([int]$i * $mostbit)
        $mostbit = $mostbit/2
    }
    return [String]$byte
}