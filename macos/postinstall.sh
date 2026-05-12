#!/bin/bash
set -e

log() {
  echo "=== $1"
}

log "Disabling Siri..." # https://term7.info/kill-siri/
defaults write com.apple.assistant.support 'Siri Data Sharing Opt-In Status' -int 2
defaults write com.apple.assistant.support 'Assistant Enabled' -bool false
defaults write com.apple.assistant.backedup 'Use device speaker for TTS' -int 3
defaults write com.apple.SetupAssistant 'DidSeeSiriSetup' -bool True
defaults write com.apple.Siri 'StatusMenuVisible' -bool false
defaults write com.apple.Siri 'UserHasDeclinedEnable' -bool true

launchctl disable "user/$UID/com.apple.assistantd"
launchctl disable "gui/$UID/com.apple.assistantd"
sudo launchctl disable 'system/com.apple.assistantd'
launchctl disable "user/$UID/com.apple.Siri.agent"
launchctl disable "gui/$UID/com.apple.Siri.agent"
sudo launchctl disable 'system/com.apple.Siri.agent'

log "Disabling Spotlight..."
sudo mdutil -a -i off
defaults write com.apple.Spotlight MenuItemHidden -bool true
killall Spotlight 2>/dev/null

log "Setting key repeat rate..."
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 25

log "Hiding menu bar..."
defaults write NSGlobalDomain AppleMenuBarVisibleInFullscreen -bool false
defaults write NSGlobalDomain _HIHideMenuBar -bool true

log "Disabling UI sound effects..."
defaults write NSGlobalDomain com.apple.sound.uiaudio.enabled -int 0

log "Disabling Stage Manager..."
defaults write com.apple.WindowManager GloballyEnabled -bool false

log "Disabling Optimized Battery Charging..."
defaults write com.apple.PowerChime.plist ChimeOnAllHardware -bool true
defaults write com.apple.powerAdapter.modern BatteryUpdateInterval -int 3600
defaults write com.apple.powerAdapter.modern OptimizedBatteryCharging -int 0

log "Setting Fish as default shell..."
if command -v fish >/dev/null 2>&1; then
  FISH_PATH=$(which fish)
  if ! grep -qx "$FISH_PATH" /etc/shells; then
    echo "$FISH_PATH" | sudo tee -a /etc/shells
  fi
  sudo chsh -s "$FISH_PATH" "$USER"
fi

if [[ "$(scutil --get ComputerName 2>/dev/null)" == *"MN6P92HJN4"* ]]; then
  log "Authenticating with GitHub Enterprise..."
  if ! command -v gh >/dev/null 2>&1; then
    brew install gh
  fi
  if ! gh auth status --hostname github.twdcgrid.net &>/dev/null; then
    gh auth login --hostname github.twdcgrid.net
  fi
  gh auth setup-git --hostname github.twdcgrid.net
  brew tap --custom-remote cost/tap https://github.twdcgrid.net/COST/homebrew-tap
  brew tap --custom-remote devproductivity/devx-cli https://github.twdcgrid.net/devproductivity/homebrew-devx-cli
fi

log "Making sure all Brew packages are installed and up to date..."
if command -v brew >/dev/null 2>&1; then
  if ! brew list brew-file >/dev/null 2>&1; then
    brew install rcmdnk/file/brew-file
  fi
  brew file install
fi

log "Symlinking AeroSpace CLI..."
ln -sf /Applications/AeroSpace.app/Contents/MacOS/AeroSpace /opt/homebrew/bin/aerospace

log "Setting Firefox as default browser and PDF viewer..."
if command -v duti >/dev/null 2>&1; then
  duti -s org.mozilla.firefox http
  duti -s org.mozilla.firefox pdf all
fi

log "Installing Yazi packages..."
if command -v ya >/dev/null 2>&1; then
  ya pkg install
fi

mkdir -p ~/Work

log "Launching Karabiner and AeroSpace..."
open -a "Karabiner-Elements"
open -a "AeroSpace"

log "Changes applied. Some changes may require a restart to take effect."
