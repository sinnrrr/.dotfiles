#!/bin/bash

sudo -v

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
killall Spotlight

log "Disabling Stage Manager..."
defaults write com.apple.WindowManager GloballyEnabled -bool false

log "Disabling Optimized Battery Charging..."
defaults write com.apple.PowerChime.plist ChimeOnAllHardware -bool true
defaults write com.apple.powerAdapter.modern BatteryUpdateInterval -int 3600
defaults write com.apple.powerAdapter.modern OptimizedBatteryCharging -int 0

log "Making sure all Brew packages are installed and up to date..."
brew install rcmdnk/file/brew-file
brew file install

log "Changes applied. Some changes may require a restart to take effect."

