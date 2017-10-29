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

echo "Disable the warning before emptying the Trash."
defaults write com.apple.finder WarnOnEmptyTrash -bool false

echo "Show the ~/Library folder."
chflags nohidden ~/Library

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

echo "Press Tab to highlight each item on a web page."
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

echo "Show the full URL in the address bar (note: this still hides the scheme)."
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

echo "Set Safari’s home page to `about:blank` for faster loading."
defaults write com.apple.Safari HomePage -string "about:blank"

echo "Prevent Safari from opening ‘safe’ files automatically after downloading."
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

echo "Allow hitting the Backspace key to go to the previous page in history."
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

echo "Hide Safari’s bookmarks bar by default."
defaults write com.apple.Safari ShowFavoritesBar -bool false

echo "Hide Safari’s sidebar in Top Sites."
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

echo "Enable Safari’s debug menu."
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

echo "Enable the Develop menu and the Web Inspector in Safari."
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

echo "Update extensions automatically"
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

echo "Prevent Photos from opening automatically when devices are plugged in."
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

echo "Never go into computer sleep mode."
sudo systemsetup -setcomputersleep Off > /dev/null

echo "Disable automatic capitalization as it’s annoying when typing code"
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

echo "Disable smart dashes as they’re annoying when typing code"
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

echo "Disable automatic period substitution as it’s annoying when typing code"
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

echo "Disable smart quotes as they’re annoying when typing code"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

echo "Disable auto-correct"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

echo "Save screenshots to the desktop"
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

echo "Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)"
defaults write com.apple.screencapture type -string "png"

echo "Enable continuous spellchecking"
defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true

echo "Disable auto-correct"
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

echo "Installing Homebrew."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing applications."
brew cask install dropbox
brew cask install transmission
brew cask install spotify
brew cask install slack
brew cask install alfred
brew cask install mplayerx
brew cask install macdown
brew cask install sublime-text
brew cask install dash
brew cask install bartender
brew cask install itsycal
brew cask install flux
brew cask install caffeine
brew cask install rescuetime
brew cask install simpholders
brew cask install gitup
brew cask install recordit
brew cask install paparazzi
brew cask install paw
brew cask install telegram
brew cask install sketch
brew cask install wwdc
brew cask install google-chrome
brew cask install spectacle
brew cask install selfcontrol
brew cask install skype
brew cask install iterm2
brew cask install reveal
brew cask install realm-browser
brew cask install shortcat
brew cask install brisk
brew cask install muzzle
brew cask install contexts
brew cask install imageoptim
# QuickLook plugins
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package quicklookase qlvideo

echo "Installing command line tools."
brew install mas
brew install mitmproxy
brew install mackup
brew install z
brew install swiftlint
brew install carthage
brew install gistit
brew install diff-so-fancy
brew install m-cli
brew install llvm
brew install rbenv
brew install cmake
pip3 install mps-youtube

echo "rbenv & Ruby"
rbenv init
rbenv install 2.4.1
echo "Open new tab in Terminal. Execute rbenv global 2.4.1 and install gems: xcode-install, bundler, jekyll."
read -p "Press any key to continue... " -n1 -s

echo "Chisel setup."
brew install chisel
touch ~/.lldbinit
echo "command script import /usr/local/opt/chisel/libexec/fblldb.py" >> ~/.lldbinit

echo "Open Dropbox and wait until all things will download."
read -p "Press any key to continue... " -n1 -s

echo "Set Dropbox as the default location for new Finder windows."
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Dropbox/"

echo  '\n'
echo "Copying `.mackup.cfg` file to HOME."
cp -r ~/Dropbox/personal/computer_settings/Mackup/.mackup.cfg ~

echo "Replacing icons for Caffeine."
cp -r ${HOME}/Dropbox/personal/computer_settings/caffeine/* /Applications/Caffeine.app/Contents/Resources/

echo "Add SSH key and copy to Clipboard." # http://rabexc.org/posts/using-ssh-agent
ssh-keygen -t rsa -b 4096 -C "aleksander.grzyb@gmail.com"
eval `ssh-agent`
ssh-add ~/.ssh/id_rsa
pbcopy < ~/.ssh/id_rsa.pub
echo "Open GitHub/BitBucket settings and add SSH key in SSH and GPG keys panel (it's already copied to your clipboard)."
read -p "Press any key to continue... " -n1 -s

echo "Configuring git."
git config --global user.name "Aleksander Grzyb"
git config --global user.email aleksander.grzyb@gmail.com
touch ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global

echo "macOS config check."
git clone https://github.com/kristovatlas/osx-config-check.git
cd osx-config-check
python app.py
cd ..
rm -rf osx-config-check

echo "Installing AppStore apps. Firstly PL store."
mas signin aleksander.grzyb@gmail.com
mas install 568494494 # Pocket
mas install 1107421413 # 1Blocker
mas install 1091189122 # Bear
mas install 413965349 # Soulver
mas install 1037126344 # Apple Configurator
mas install 409183694 # Keynote
mas install 507257563 # Sip
mas install 1017470484 # Next Meeting

echo "US Store."
mas signout
mas signin aleksander.grzyb.usapple@gmail.com
mas install 443987910 # 1Password

echo "Canada Store."
mas signout
mas signin aleksander@candyrent.com 
mas install 904280696 # Things
mas install 880001334 # Reader
mas install 992076693 # MindNote

echo "Installing Sparrow."
cp -r ${HOME}/Dropbox/personal/computer_settings/sparrow/Sparrow.app /Applications/

echo "Set caps lock as ctrl."
echo "Set iTerm backup from HOME/Dropbox/personal/computer_settings/iTerm."
echo "Install Hack font from https://github.com/chrissimpkins/Hack"
echo "Enable three finger drag from Accessibility settings."
echo "After that restart computer, launch apps and log in."
echo "Restore all application settings and dot files using Mackup. -> mackup restore"
echo "Set up global .gitignore -> gi macos >> ~/.gitignore_global"
echo "Install newest version of Xcode via xcversion install <version>."
echo "Set sync of Dash to Dropbox."
echo "Set sync of Alfred."
echo "Open Spectacle and sync shortcuts -> cp -r ${HOME}/Dropbox/personal/computer_settings/spectacle/spectacle.json ~/Library/Application\ Support/Spectacle/Shortcuts.json 2> /dev/null"
echo "Open Photos and sync."
echo "Set up Context to use option+space and hide panel."

echo "Installing Oh My Zsh."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
