```
      /\                  /\
     /  \  /\            /  \  /\ Far over the Misty Mountains cold
  /\/    \/  \    /\    / /\/\/  \ To dungeons deep and caverns old
 /   /\/\  /\/\  /  \  /\/    \   \ We must away, ere break of day
/\/\/    \/    \/    \/        \   \ To find our long forgotten gold
    M I S T Y      M O U N T A I N       
                     an sddm theme
********************************************************************
```

## Why build this?

(◟ᅇ)◜

I wanted to get some experience with Tiling Window Managers and see that sddm is a common part of lots of tool-belt of others that have been in the game for a while. AFter getting my first look at the  [Nord](https://www.nordtheme.com/) style-guide I decided I wanted something nice looking for my login screen, plus, [ChrisTitusTech](https://github.com/ChrisTitusTech) is working on a sweet OS that I am using, so easy decision.

I decided that since I was the only one using this computer I would use no login screen to keep it very minimal. You are able to have multiple users but each person will type in their username and password to log in.

## Getting up and running

* Install the following package:
```
sudo apt install dit qml-module-qtquick-layouts qml-module-qtquick-controls2 qml-module-qtquick-templates2 qml-module-qtgraphicaleffects
```
* Cone the repository
```
git clone https://github.com/aphive/MistyMountain.git
```
* Cd into the cloned repo:
```
cd MistyMountain
```
* Install fonts
```
mkdir ~/.fonts
mv components/*.tff ~/.fonts/
```

## To Do

The following items need to be added or looked into to get them working.

* Set time to not be 24hr format
* Make username and password textbox content larger for readability
