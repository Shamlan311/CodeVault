@echo off
:: Request admin privileges (required to modify the hosts file)
fltmc >nul 2>&1 || (
    echo Requesting administrator privileges...
    powershell -Command "Start-Process cmd -ArgumentList '/c %0' -Verb RunAs"
    exit /b
)

cd /d "C:\Windows\System32\Drivers\etc"

:: Create a backup of the original hosts file
if not exist hosts.backup copy hosts hosts.backup

(
:: Search Engines
echo 127.0.0.1 www.google.com
echo 127.0.0.1 google.com
echo 127.0.0.1 www.bing.com
echo 127.0.0.1 bing.com
echo 127.0.0.1 www.yahoo.com
echo 127.0.0.1 yahoo.com
echo 127.0.0.1 www.duckduckgo.com
echo 127.0.0.1 duckduckgo.com

:: Email Services
echo 127.0.0.1 mail.google.com
echo 127.0.0.1 gmail.com
echo 127.0.0.1 outlook.com
echo 127.0.0.1 mail.yahoo.com
echo 127.0.0.1 protonmail.com
echo 127.0.0.1 mail.protonmail.com

:: Social Media
echo 127.0.0.1 www.facebook.com
echo 127.0.0.1 facebook.com
echo 127.0.0.1 www.twitter.com
echo 127.0.0.1 twitter.com
echo 127.0.0.1 www.x.com
echo 127.0.0.1 x.com
echo 127.0.0.1 www.instagram.com
echo 127.0.0.1 instagram.com
echo 127.0.0.1 www.tiktok.com
echo 127.0.0.1 tiktok.com
echo 127.0.0.1 www.reddit.com
echo 127.0.0.1 reddit.com
echo 127.0.0.1 www.linkedin.com
echo 127.0.0.1 linkedin.com

:: Video Streaming
echo 127.0.0.1 www.youtube.com
echo 127.0.0.1 youtube.com
echo 127.0.0.1 www.netflix.com
echo 127.0.0.1 netflix.com
echo 127.0.0.1 www.hbomax.com
echo 127.0.0.1 hbomax.com
echo 127.0.0.1 www.peacocktv.com
echo 127.0.0.1 peacocktv.com
echo 127.0.0.1 www.disneyplus.com
echo 127.0.0.1 disneyplus.com
echo 127.0.0.1 www.twitch.tv
echo 127.0.0.1 twitch.tv
echo 127.0.0.1 www.kick.com
echo 127.0.0.1 kick.com

:: Gaming Platforms
echo 127.0.0.1 www.playstation.com
echo 127.0.0.1 playstation.com
echo 127.0.0.1 www.xbox.com
echo 127.0.0.1 xbox.com
echo 127.0.0.1 www.nintendo.com
echo 127.0.0.1 nintendo.com
echo 127.0.0.1 www.riotgames.com
echo 127.0.0.1 riotgames.com
echo 127.0.0.1 www.epicgames.com
echo 127.0.0.1 epicgames.com
echo 127.0.0.1 www.steampowered.com
echo 127.0.0.1 steampowered.com
echo 127.0.0.1 store.steampowered.com

:: News Outlets
echo 127.0.0.1 www.nytimes.com
echo 127.0.0.1 nytimes.com
echo 127.0.0.1 www.cnn.com
echo 127.0.0.1 cnn.com
echo 127.0.0.1 www.bbc.com
echo 127.0.0.1 bbc.com
echo 127.0.0.1 www.foxnews.com
echo 127.0.0.1 foxnews.com
echo 127.0.0.1 www.reuters.com
echo 127.0.0.1 reuters.com
echo 127.0.0.1 www.theguardian.com
echo 127.0.0.1 theguardian.com

:: Shopping
echo 127.0.0.1 www.amazon.com
echo 127.0.0.1 amazon.com
echo 127.0.0.1 www.ebay.com
echo 127.0.0.1 ebay.com
echo 127.0.0.1 www.bestbuy.com
echo 127.0.0.1 bestbuy.com
echo 127.0.0.1 www.shopify.com
echo 127.0.0.1 shopify.com
echo 127.0.0.1 www.etsy.com
echo 127.0.0.1 etsy.com
echo 127.0.0.1 www.walmart.com
echo 127.0.0.1 walmart.com

:: Productivity & Cloud
echo 127.0.0.1 www.dropbox.com
echo 127.0.0.1 dropbox.com
echo 127.0.0.1 www.onedrive.com
echo 127.0.0.1 onedrive.com
echo 127.0.0.1 drive.google.com
echo 127.0.0.1 www.office.com
echo 127.0.0.1 office.com

:: Additional notable sites
echo 127.0.0.1 www.wikipedia.org
echo 127.0.0.1 wikipedia.org
echo 127.0.0.1 www.imdb.com
echo 127.0.0.1 imdb.com
echo 127.0.0.1 www.paypal.com
echo 127.0.0.1 paypal.com
) >> hosts

echo Blocklist updated successfully.
echo Please restart your browser or flush DNS (ipconfig/flushdns) for changes to take effect.
pause
