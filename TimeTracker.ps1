[string]$text1 = "Implementation of PD-39652"
[string]$text2 = "Implementation of PD-39963"
[string]$text3 = "Implementation of PD-39539"
[int]$times = 3
[string]$configAddr = "D:\TimeTracker\config.toml"
[string]$date = "28/02/2020"

#For($j = 12; $j -le 14; $j++){

#    $date = [string]$j + "/01/2020"
    Write-Host $date 
        
    For ($i=1; $i -le $times; $i++) {
        tt load -t $text1 -d $date -c $configAddr
    }

    For ($i=1; $i -le $times; $i++) {
        tt load -t $text2 -d $date -c $configAddr
    }

    For ($i=1; $i -le $times; $i++) {
        tt load -t $text3 -d $date -c $configAddr
    }
#}

#For($i = 20; $i -le 24; $i++){
#
#    $date = [string]$i + "/01/2020"
#    
#    For ($i=1; $i -le $times; $i++) {
#        tt load -t $text1 -d $date -c $configAddr
#    }
#
#    For ($i=1; $i -le $times; $i++) {
#        tt load -t $text2 -d $date -c $configAddr
#    }
#
#    For ($i=1; $i -le $times; $i++) {
#        tt load -t $text3 -d $date -c $configAddr
#    }
#
#}