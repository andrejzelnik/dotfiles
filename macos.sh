#!/usr/bin/env zsh
# macOS system preferences — run once on a new machine

# Dock
defaults write com.apple.dock autohide          -bool true
defaults write com.apple.dock tilesize          -int 24
defaults write com.apple.dock magnification     -bool true
defaults write com.apple.dock largesize         -int 32
defaults write com.apple.dock show-recents      -bool false
defaults write com.apple.dock mru-spaces        -bool false

# Finder
defaults write com.apple.finder AppleShowAllFiles        -bool true
defaults write com.apple.finder ShowPathbar              -bool true
defaults write com.apple.finder ShowStatusBar            -bool true
defaults write com.apple.finder FXPreferredViewStyle     -string "Nlsv"
defaults write NSGlobalDomain  AppleShowAllExtensions    -bool true

# Keyboard
defaults write NSGlobalDomain KeyRepeat                              -int 2
defaults write NSGlobalDomain InitialKeyRepeat                       -int 15
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled   -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled    -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled     -bool false

# Screenshots — save as PNG without shadow
defaults write com.apple.screencapture type            -string "png"
defaults write com.apple.screencapture disable-shadow  -bool true

# Apply
killall Dock    2>/dev/null || true
killall Finder  2>/dev/null || true

print "macOS defaults applied. Some changes require a logout/restart to take effect."
