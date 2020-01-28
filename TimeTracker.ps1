[string]$text1 = "Implementation of config filters"
[string]$text2 = "Testing of new feature"
[string]$text3 = "Documentation updates"
[int]$times = 3
[string]$configAddr = "D:\TimeTracker\config.toml"
[string]$date = "20/01/2020"

For($j = 21; $j -le 24; $j++){

    $date = [string]$j + "/01/2020";
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
}

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