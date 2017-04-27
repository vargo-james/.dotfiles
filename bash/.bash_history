cd .dotfiles/bash/.bashrc
vim .dotfiles/bash/.bashrc 
cd .dotfiles/
ls
git add --all
git commit -m 'color changes'
vim xmobar/.xmobarrc 
git add --all
git status
git rm bash/.bash_history 
git reset HEAD bash/.bash_history
git rm bash/.bash_history
git rm -f bash/.bash_history
git status
git commit -m 'more color changes'
cd
ls
cd .fonts/
ls -l
mv white-rabbit.zip ~/tarballs/
cd ..
mkdir .dotfiles/fonts
mv .fonts/ .dotfiles/fonts/
cd .dotfiles/
git add --all
git status
git commit -m 'added fonts'
cd
dotify 
python3
cd .fonts/
ls
safe
fc-list | grep White
xfontsel
mkfontdir 
mkfontscale 
fc-cache
xfontsel
less whitrabt.txt 
xfontsel
clear
exit
exit
ls
./youtube-playlist.sh 
less youtube-playlist.sh 
ps 
kill 20724
ps
clear
ls
exit
su
exit
vim /etc/lightdm/lightdm-gtk-greeter.conf 
su
exit
su
exit
cd /usr/share/
cd themes/
ls
cd ../fonts/
ls
cd ../
ls
cd lightdm/
ls
cd lightdm.conf.d/
ls
ls -a
cd ../..
cd themes/
ls
random-slides ~/.wallpaper/curves/
cd ../icons/
ls
cd hicolor/
ls
cd 64x64/
ls
cd app
cd apps
ls
feh .
feh /usr/share/icons/hicolor/
cd ../..
ls
vim index.theme
dm-tool switch-to-greeter
cd ..
ls
feh Adwaita/48x48/status/avatar-default.png 
find / -name 'lightdm-gtk-greeter.ui'
clear
ls
cd hicolor/
ls
cd 64x64/
ls
cd apps
ls
su
exit
cd .wallpaper/
ls
cd ../Downloads/
ls
feh laptop.png 
feh goat-head-frontal-outline.png 
ls
feh big-flower.png 
feh japanese-flower.png 
mkdir ~/icons
cd ../icons/
ls
feh animal-icon-donkey.png 
mv ~/Downloads/*.png .
ls
su
cd ..
ls
mkdir sysconfig
cp /etc/lightdm/lightdm-gtk-greeter.conf sysconfig/
cd sysconfig/
ls
ls -l
vim lightdm-gtk-greeter.conf 
mkdir lightdm
mv lightdm-gtk-greeter.conf lightdm/
cp /usr/share/icons/LightDM/index.theme lightdm/
fg
cd lightdm/
ls
cat << 'eof' > README
To configure the greeter, edit the light-gtk-greeter.conf file, located in
/etc/lightdm. The theme-name is the name of a gtk theme. This is a directory 
name in the /usr/share/themes directory. It must have a gtk3.0 subdirectory
to be usable in this config. The icon-theme must be a directory inside
/usr/share/icons. It must have a 64x64/devices subdirectory containing a 64x64
png file named avatar-default.png. That is the default avatar icon. There must 
also be a file named index.theme. Run the command 'gtk-update-icon-cache .' from
the top level icon theme directory.
eof

ls
clear
cd ..
ls
exit
su
exit
safe
clear
man xmonad
exit
man xmonad
man xset
aptitude search scrot
su
exit
