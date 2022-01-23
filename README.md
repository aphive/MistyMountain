```
      /\                  /\
     /  \  /\            /  \  /\ Far over the Misty Mountains cold
  /\/    \/  \    /\    / /\/\/  \ To dungeons deep and caverns old
 /   /\/\  /\/\  /  \  /\/    \   \ We must away, ere break of day
/\/\/    \/    \/    \/        \   \ To find our long forgotten gold
    M I S T Y      M O U N T A I N                - J. R. R. Tolkien
                     an sddm theme
********************************************************************
```

## Why build this?

(◟ᅇ)◜

I wanted to get some experience with Tiling Window Managers and seeing that sddm is a common part of most builds I've seen, I wanted to give customizing this part of my system. After getting my first look at the [Nord](https://www.nordtheme.com/) style-guide I decided I wanted something nice looking for my login screen, plus, [ChrisTitusTech](https://github.com/ChrisTitusTech) is working on a sweet OS that I am using, so easy decision.

Since I was the only one using this computer, there is no need to have it display user pics. You are able to have multiple users but each person will type in their username and password to log in. However, if enough people use this and there is enough want for it, I can look into it or accept a pull request for the change.

If you see anything that can be made better, feel free to make a pull request with the update.

## Getting up and running

* Install the following packages:
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
* Reload Font Cache
```
sudo fc-cache -f -v
```
* Move the theme directory into place
```
cd ..
sudo mv MistyMountain /usr/share/sddm/themes/
```
* Restart your computer

## To Do

The following items need to be added or looked into to get them working.

* Set time to not be 24hr format
* Make username and password text-box content larger for readability
