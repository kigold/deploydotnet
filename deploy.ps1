param ($app)

Import-Module WebAdministration

echo "~~~~~~~~~~~~~~~~~~~~~~~~LOADING CONFIG FOR $app!~~~~~~~~~~~~~~~~~~~~~~~~~~"

[xml]$config = Get-Content ".\$app.xml"

$codePath = $config.configuration.appSettings.codepath.value
$deployPath = $config.configuration.appSettings.deploypath.value
$appConfigPath = $config.configuration.appSettings.appconfigpath.value
$iisAppName = $config.configuration.appSettings.iisappname.value
$dotnetversion = $config.configuration.appSettings.dotnetversion.value

$buildPath = $codePath + "\bin\Debug\" + $dotnetversion + "\publish\*"  

echo "~~~~~~~~~~~~~~~~~~~~~~~~BUILDING!!!~~~~~~~~~~~~~~~~~~~~~~~~~~"

CD $codePath
dotnet publish --framework $dotnetversion --self-contained false

echo "~~~~~~~~~~~~~~~~~~~~~~~~STOPPING WEB APP $app~~~~~~~~~~~~~~~~~~~~~~~~~~"
$webApp = (Get-Website -Name $iisAppName)
$webApp.stop()


echo "~~~~~~~~~~~~~~~~~~~~~~~~RECYCLING WEB APP POOL ~~~~~~~~~~~~~~~~~~~~~~~~~~"
Restart-WebAppPool $webApp.applicationPool


Copy-item -Force -Recurse -Verbose $buildPath -Destination $deployPath
copy-item -Force -Recurse $appConfigPath -Destination $deployPath


echo "~~~~~~~~~~~~~~~~~~~~~~~~RESTARTING APP $app ~~~~~~~~~~~~~~~~~~~~~~~~~~"
$webApp.start()

echo "          _____                   _______                   _____                    _____                    _____            _____                _____                    _____                    _____          
         /\    \                 /::\    \                 /\    \                  /\    \                  /\    \          /\    \              /\    \                  /\    \                  /\    \         
        /::\    \               /::::\    \               /::\____\                /::\    \                /::\____\        /::\    \            /::\    \                /::\    \                /::\    \        
       /::::\    \             /::::::\    \             /::::|   |               /::::\    \              /:::/    /       /::::\    \           \:::\    \              /::::\    \              /::::\    \       
      /::::::\    \           /::::::::\    \           /:::::|   |              /::::::\    \            /:::/    /       /::::::\    \           \:::\    \            /::::::\    \            /::::::\    \      
     /:::/\:::\    \         /:::/~~\:::\    \         /::::::|   |             /:::/\:::\    \          /:::/    /       /:::/\:::\    \           \:::\    \          /:::/\:::\    \          /:::/\:::\    \     
    /:::/  \:::\    \       /:::/    \:::\    \       /:::/|::|   |            /:::/__\:::\    \        /:::/    /       /:::/__\:::\    \           \:::\    \        /:::/__\:::\    \        /:::/  \:::\    \    
   /:::/    \:::\    \     /:::/    / \:::\    \     /:::/ |::|   |           /::::\   \:::\    \      /:::/    /       /::::\   \:::\    \          /::::\    \      /::::\   \:::\    \      /:::/    \:::\    \   
  /:::/    / \:::\    \   /:::/____/   \:::\____\   /:::/  |::|___|______    /::::::\   \:::\    \    /:::/    /       /::::::\   \:::\    \        /::::::\    \    /::::::\   \:::\    \    /:::/    / \:::\    \  
 /:::/    /   \:::\    \ |:::|    |     |:::|    | /:::/   |::::::::\    \  /:::/\:::\   \:::\____\  /:::/    /       /:::/\:::\   \:::\    \      /:::/\:::\    \  /:::/\:::\   \:::\    \  /:::/    /   \:::\ ___\ 
/:::/____/     \:::\____\|:::|____|     |:::|    |/:::/    |:::::::::\____\/:::/  \:::\   \:::|    |/:::/____/       /:::/__\:::\   \:::\____\    /:::/  \:::\____\/:::/__\:::\   \:::\____\/:::/____/     \:::|    |
\:::\    \      \::/    / \:::\    \   /:::/    / \::/    / ~~~~~/:::/    /\::/    \:::\  /:::|____|\:::\    \       \:::\   \:::\   \::/    /   /:::/    \::/    /\:::\   \:::\   \::/    /\:::\    \     /:::|____|
 \:::\    \      \/____/   \:::\    \ /:::/    /   \/____/      /:::/    /  \/_____/\:::\/:::/    /  \:::\    \       \:::\   \:::\   \/____/   /:::/    / \/____/  \:::\   \:::\   \/____/  \:::\    \   /:::/    / 
  \:::\    \                \:::\    /:::/    /                /:::/    /            \::::::/    /    \:::\    \       \:::\   \:::\    \      /:::/    /            \:::\   \:::\    \       \:::\    \ /:::/    /  
   \:::\    \                \:::\__/:::/    /                /:::/    /              \::::/    /      \:::\    \       \:::\   \:::\____\    /:::/    /              \:::\   \:::\____\       \:::\    /:::/    /   
    \:::\    \                \::::::::/    /                /:::/    /                \::/____/        \:::\    \       \:::\   \::/    /    \::/    /                \:::\   \::/    /        \:::\  /:::/    /    
     \:::\    \                \::::::/    /                /:::/    /                  ~~               \:::\    \       \:::\   \/____/      \/____/                  \:::\   \/____/          \:::\/:::/    /     
      \:::\    \                \::::/    /                /:::/    /                                     \:::\    \       \:::\    \                                    \:::\    \               \::::::/    /      
       \:::\____\                \::/____/                /:::/    /                                       \:::\____\       \:::\____\                                    \:::\____\               \::::/    /       
        \::/    /                 ~~                      \::/    /                                         \::/    /        \::/    /                                     \::/    /                \::/____/        
         \/____/                                           \/____/                                           \/____/          \/____/                                       \/____/                  ~~              
                                                                                                                                                                                                                     "
