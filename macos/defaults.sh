#!/usr/bin/env bash
set -euo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "macOS defaults skipped: not running on macOS"
  exit 0
fi

readonly SPOTLIGHT_SEARCH_HOTKEY_ID=64
readonly SPOTLIGHT_FINDER_SEARCH_HOTKEY_ID=65

configure_dock() {
  defaults write com.apple.dock autohide -bool true
  defaults write com.apple.dock show-recents -bool false
  defaults write com.apple.dock orientation -string left
}

disable_spotlight_hotkey() {
  local hotkey_id="$1" char_code="$2" key_code="$3" modifiers="$4"
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add "$hotkey_id" "
    <dict>
      <key>enabled</key><false/>
      <key>value</key>
      <dict>
        <key>parameters</key>
        <array>
          <integer>$char_code</integer>
          <integer>$key_code</integer>
          <integer>$modifiers</integer>
        </array>
        <key>type</key><string>standard</string>
      </dict>
    </dict>"
}

disable_spotlight() {
  disable_spotlight_hotkey "$SPOTLIGHT_SEARCH_HOTKEY_ID" 32 49 1048576
  disable_spotlight_hotkey "$SPOTLIGHT_FINDER_SEARCH_HOTKEY_ID" 32 49 1572864
  /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u || true
}

configure_keyboard() {
  defaults write NSGlobalDomain KeyRepeat -int 2
  defaults write NSGlobalDomain InitialKeyRepeat -int 15
}

configure_finder() {
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true
  defaults write com.apple.finder ShowPathbar -bool true
  defaults write com.apple.finder AppleShowAllFiles -bool true
  defaults write com.apple.finder ShowRecentTags -bool false
  defaults write com.apple.finder NewWindowTarget -string "PfLo"
  defaults write com.apple.finder NewWindowTargetPath -string "file://$HOME/Downloads/"
}

mute_startup_chime() {
  if nvram StartupMute 2>/dev/null | grep -q '%01'; then
    echo "✓ startup chime (already muted)"
  elif [[ -t 0 ]] || sudo -n true 2>/dev/null; then
    sudo nvram StartupMute=%01
  else
    echo "! startup chime not muted: no terminal for sudo, run 'sudo nvram StartupMute=%01'" >&2
  fi
}

restart_affected_apps() {
  killall Dock Finder SystemUIServer 2>/dev/null || true
}

configure_dock
disable_spotlight
configure_keyboard
configure_finder
restart_affected_apps
mute_startup_chime

echo "✓ macOS defaults applied (key repeat changes need a logout)"
