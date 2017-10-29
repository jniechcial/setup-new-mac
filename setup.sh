#!/bin/sh

echo "Close any open System Preferences panes, to prevent them from overriding settings we’re about to change."
osascript -e 'tell application "System Preferences" to quit'

echo "Ask for the administrator password upfront."
sudo -v

echo "Disable animations when opening and closing windows."
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

echo "Disable animations when opening a Quick Look window."
defaults write -g QLPanelAnimationDuration -float 0

echo "Automatically quit printer app once the print jobs complete."
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

echo "Disable the “Are you sure you want to open this application?” dialog."
defaults write com.apple.LaunchServices LSQuarantine -bool false

echo "Disable smart quotes as they’re annoying when typing code."
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

echo "Disable smart dashes as they’re annoying when typing code."
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

echo "Increase sound quality for Bluetooth headphones/headsets."
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

echo "Use scroll gesture with the Ctrl (^) modifier key to zoom."
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

echo "Disable auto-correct."
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

echo "Disable shadow in screenshots."
defaults write com.apple.screencapture disable-shadow -bool true

echo "Finder: disable window animations and Get Info animations."
defaults write com.apple.finder DisableAllAnimations -bool true

echo "Finder: show all filename extensions."
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "Finder: show status bar."
defaults write com.apple.finder ShowStatusBar -bool true

echo "Finder: Show dotfiles"
defaults write com.apple.finder AppleShowAllFiles TRUE

echo "Display full POSIX path as Finder window title."
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo "Keep folders on top when sorting by name."
defaults write com.apple.finder _FXSortFoldersFirst -bool true

echo "When performing a search, search the current folder by default."
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

echo "Disable the warning when changing a file extension."
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "Avoid creating .DS_Store files on network or USB volumes."
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

echo "Use column view in all Finder windows by default."
# Four-letter codes for the other view modes: `Nlsv`, `icnv`, `Flwv`.
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

echo "Don’t animate opening applications from the Dock."
defaults write com.apple.dock launchanim -bool false

echo "Disable Dashboard."
defaults write com.apple.dashboard mcx-disabled -bool true

echo "Don’t show Dashboard as a Space."
defaults write com.apple.dock dashboard-in-overlay -bool true

echo "Don’t automatically rearrange Spaces based on most recent use."
defaults write com.apple.dock mru-spaces -bool false

echo "Remove the auto-hiding Dock delay & Remove the animation when hiding/showing the Dock."
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0

echo "Automatically hide and show the Dock."
defaults write com.apple.dock autohide -bool true

echo "Top left screen corner → Desktop."
defaults write com.apple.dock wvous-tl-corner -int 4
defaults write com.apple.dock wvous-tl-modifier -int 0

echo "Top right screen corner → Desktop."
defaults write com.apple.dock wvous-tr-corner -int 4
defaults write com.apple.dock wvous-tr-modifier -int 0

echo "Bottom right screen corner → Screen saver."
defaults write com.apple.dock wvous-br-corner -int 5
defaults write com.apple.dock wvous-br-modifier -int 0

echo "Expanding the save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

echo "Disable hibernation"
sudo pmset -a hibernatemode 0

echo "Turn off keyboard illumination when computer is not used for 1 minute"
defaults write com.apple.BezelServices kDimTime -int 60

echo "Disable keyboard from automatically adjusting backlight brightness in low light"
sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Automatic Keyboard Enabled" -bool false

echo "Requiring password immediately after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

echo "Prevent Photos from opening automatically when devices are plugged in."
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

echo "Never go into computer sleep mode."
sudo systemsetup -setcomputersleep Off > /dev/null

echo "Disable automatic capitalization as it’s annoying when typing code"
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

echo "Disable automatic period substitution as it’s annoying when typing code"
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

echo "Save screenshots to the desktop"
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

echo "Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)"
defaults write com.apple.screencapture type -string "png"

echo "Installing Homebrew."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing applications."
brew cask install dropbox
brew cask install google-drive-file-stream
brew cask install spotify
brew cask install slack
brew cask install sublime-text
brew cask install flux
brew cask install rescuetime
brew cask install google-chrome
brew cask install selfcontrol
brew cask install skype
brew cask install iterm2
brew cask install muzzle
brew cask install the-unarchiver
brew cask install kindle

echo "Setting Git to use Sublime Text as default editor"
git config --global core.editor "subl -n -w"

echo "Installing command line tools."
brew install mas
brew install z
brew install llvm
brew install cmake
brew install mackup
brew install vim

echo "Add SSH key and copy to Clipboard." # http://rabexc.org/posts/using-ssh-agent
ssh-keygen -t rsa -b 4096 -C "jakub.niechcial@gmail.com"
eval `ssh-agent`
ssh-add ~/.ssh/id_rsa
pbcopy < ~/.ssh/id_rsa.pub
echo "Save SSH keys in secure backups (it's already copied to your clipboard)."
read -p "Press any key to continue... " -n1 -s

echo "Configuring git."
git config --global user.name "Jakub Niechcial"
git config --global user.email jakub.niechcial@gmail.com
touch ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global

echo "macOS config check."
git clone https://github.com/kristovatlas/osx-config-check.git
cd osx-config-check
python app.py
cd ..
rm -rf osx-config-check

echo "Installing AppStore apps."
mas signin jakub.niechcial@gmail.com
mas install 409183694 # Keynote

echo "Installing Oh My Zsh."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
