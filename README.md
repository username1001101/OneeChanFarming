# OneeChanFarming Scripts

Two small scripts for farming [Uber Hillock](https://pathofexile.gamepedia.com/Hillock#Uber_Hillock) / [Oni-Goroshi](https://pathofexile.gamepedia.com/Oni-Goroshi)

* **OneChanFarming.ahk**: This script is for actually opening instances and check if Uber Hillock is present - requires Dx11 and PoEHUD
* **OneChanLeveling.ahk**: This script is for automatic levelling up chars in The Twilight Strand - requires DX9/ex and Exiled Bot
* **mailsoundtest.ahk**: This script is to test whether sound and email notifications work


**WARNING: USING THESE SCRIPTS CAN GET YOUR ACCOUNT BANNED.** Don't whine if that happens. Best to make a new account.

## OneeChanFarming.ahk

### Prerequisites

You need:
* [Path of Exile](https://www.pathofexile.com/) and an account with it
* [PoEHUD](https://github.com/TehCheat/PoEHUD)
* [AutoHotkey](https://autohotkey.com/)
* DirectX 11

### Preparation

* Make sure to use DirectX 11
* On your Uber Hillock / Oni-Goroshi account create at least 3 chars (highly recommended to have at least 4 chars, maximum is 6 chars) and level them to level 6, better 7
* With those chars, **DO NOT ENTER TOWN*** 
* See further down on how to best level the characters to lvl 6 or 7 or the next main section for the OneeChanLeveling.ahk script explanation
* Also make sure that **Preload Alerts** is enabled in the PoEHUD
* Download this script, set the characters slot options at the beginning to "y" for each of the character that shall be used for farming. When running it for the first time, it should make a copy of config.tpl to config.ahk. Edit the config.ahk. If copy was not made, do it manually.
* Enable also the tray notification, if you want constant updates on the amount of runs you've made this far (can get annoying)
* Save the edited script

### How to farm

* Start PoE
* Start the PoEHud
* Log into account and go to the character selection list
* Start this script by double-clicking it
* The script will then go through each enabled slot character, enter The Twilight Strand and check for Uber Hillock
* If Uber Hillock was found, a popup appears and the script exist - you have to kill him manually.
* If Uber Hillock was not found, after a while - depending on the amount of slots you have enabled, the script will go back to character selection
* The next slot character in line will be selected and it wil enter The Twilight Strand again
* This continues until Uber Hillock if sound, or you manually exist/pause the script from the system tray or reboot your system....

### How many Runs are needed

I can't answer this yet since I just recently added the run counter. However I think I have found Uber Hillock twice with about 500 runs.

### How to level characters and to what level should they go?

According to the wiki linked above, Uber Hillock can appear with a lvl 7 character. However that is wrong as I had at least 1 instance where the character was only level 6.
From what I gather, chances to get Uber Hillock are best at lvl 7, but I don't know for sure.

Only characters that are directly visible right after login can be used. So it's recommended to create (at least 4) characters with a name that preceeds other characters.

Also you need a character of at least lvl 25 in order to trade the found Oni-Goroshis (and other currency you picked up during leveling) to another account.

**Notice**: Several sources claim, that 1 character can find more than 1 Oni-Goroshi. However with latest patch (v.3.2) the drop rate of Oni-Goroshi was massively altered. Whether you still can find more than 1 Oni-Goroshi with 1 character is unkown to me. I'll update as soon as I know.

As for the character to actually farm, the **scion** is the best choice. Since you need a lvl 25 character anyway, you can easily rush that one to Upper Tower in act. 3. On the same floor as you'll find the exit to the roof (Dominus).

The reason why the **Scion** is recommended is two-fold:

* right at the beginning you can select a mana regen node. More mana regen - faster killing; after that you go for the projectile damage nodes; this results in faster killing, hence faster levelling; the increased attack speeds and movement nodes would only be of importance, you you'd run Hillock all the time (also hafter hitting lvl 6 or lvl 7)
* Spectral Throw goes through multiple enemies. Uber Hillock is rather tough and when you have him down to 50%, he'll draw the sword and do leap slam attacks. With the leap slam attacks, he'll also spawns quite tough addons - they are fast and hit hard. So kiting with Spectral Throw is easiest

As for the reason why you should have at least 4 characters is that you cannot enter town, because then you can't go back to The Twilight Strand and you can't manually open a new instance. So we need to wait aroud 2 minutes until the instance resets. With 4 characters, once they're level 5 or 6, killing all mobs (to gain more experience) and killing Hillock takes about 40 seconds. So cycling through 4 chars will allow you to constantly spawn new instances on the selected char and hence level them up faster.

For the same reason 6 characters are preferred for the script, as there is less waiting time between each character.


## OneeChanLeveling.ahk

**NOTICE**: This will continue to level until you stop it. It will level beyond level 7 if you don't stop it.

### Prerequisites

You need:
* [Path of Exile](https://www.pathofexile.com/) and an account with it
* [Exiled Bot](http://exiled-bot.net/)
* [AutoHotkey](https://autohotkey.com/)
* DirectX 9 or 9ex

### Preparation

* Make sure to use DirectX 9 or 9ex
* On your Uber Hillock / Oni-Goroshi account create at least 3 chars (highly recommended to have at least 4 chars, maximum is 6 chars) - see below for initial start
* Download this script, set the characters slot options at the beginning to "y" for each of the character that shall be used for farming. When running it for the first time, it should make a copy of config.tpl to config.ahk. Edit the config.ahk. If copy was not made, do it manually.
* Save the edited script
* Copy the OniGoroshi folder to your Exiled Bot\Configuration\ folder so that it's like Exiled Bot\Configuration\OniGoroshi

### How to auto-level

* Start PoE
* Log into account and go to the character selection list
* Start Exiled Bot
* On the profile on the bottom select "OniGoroshi"
* **Notice:** Left mouse button should be move only; right mouse button is Spectral Throw attack
* Start this script by double-clicking it - it will ask for admin privilegs because it's needed for controlling the bot - you have to give those
* The script will then go through each enabled slot character, enter The Twilight Strand and kill monsters. If it kills Hillock it will exit otherwise it will exit after 2 minutes and cycle to next character
* This continues until you stop it. You can use the F4 key to pause/resume the OneeChanLeveling.ahk script. F12 can be used to pause/resume the Exiled Bot

### Initial character setup

As said above, you should use at least 3 chars, better 6 chars (but that will take longer for reaching lvl 6 or 7). Also I recommend to do a first manual kill of Hillock, because you can get the gems and a second weapon that way.

The following is mostly aimed at the scion - for other classes the gems and first passive skill point are different though.

* Create new char
* Go into The Twilight Strand
* Click the "Skip all Tutorials" button
* Pick up the sword laying on the beach
* Change left mouse button to **Move Only** and right mouse button to use **Spectral Throw**
* Talk with the dying exile and kill the first zombie
* Pick up the Spectral Throw gem and put it into your picked up sword
* Just walk more or less to the top right direction and open the Large Chest on the way
* Pick up the Onslaught support gem and put it into your picked up sword
* Continue to walk omore or less towards the top right until you find Hillock
* Kill Hillock - he drops at least another rusted sword. Pick it up and equip it. Eventually he drops other/better weapons etc.
* Equip your char. No further life flask is needed, just mana flask
* When you kill Hillock, you should also have levelled up. Select the Mana Regen passive first - because mana is an issue in the beginning until you have 3 mana flasks.
* Exit and create next char until you have at least 3, better 6 of them.

### How long does it take to get to level 7

I don't know... I guess it will probably take 6-8h to get 6 chars to level 7 but I haven't tried it yet.
