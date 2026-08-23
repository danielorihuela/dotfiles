if ! command -v apt-get >/dev/null 2>&1; then
  echo "This bootstrap script currently supports apt-based Linux only."
  exit 0
fi

echo "Installing native Linux packages (ghostty, brave-browser, ...)"
sudo apt-get update
sudo apt-get install -y curl ghostty
sudo apt-get install -y virtualbox
sudo apt-get install -y virtualbox-qt

if ! command -v brave-browser >/dev/null 2>&1; then
  sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
  sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-release.sources https://brave-browser-apt-release.s3.brave.com/brave-browser.sources
  sudo apt-get update
  sudo apt-get install -y brave-browser
fi

echo "Native Linux bootstrap completed."
