brew install fontconfig

# download the font
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip

# unzip the font
unzip FiraCode.zip -d FiraCode

# move the fonts to system fonts direcotry
mkdir -p ~/.local/share/fonts/FiraCode

mv FiraCode/* ~/.local/share/fonts/FiraCode/

# # move the fonts to system-wide direcory
# sudo mv FiraCode/* /usr/share/fonts/
#
# update font cache
fc-cache -fv

# clean up
rm -rf FiraCode.zip FiraCode
