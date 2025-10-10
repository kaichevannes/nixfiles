# Installation
1. Install terminal emulator
2. [Install nix](https://nixos.org/download/)
3. [Install home-manager](https://nix-community.github.io/home-manager/index.xhtml#ch-installation)
4. Clone the repo
5. home-manager switch
6. Set up SSH key

## Windows
### Elevated Powershell
1. Install Wezterm
```
winget install wez.wezterm
```
2. Install WSL and Nix
```bash
wsl.exe --install
wsl.exe -d Ubuntu
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
exit
```
3. Install home-manager and initialise dotfiles
```
wsl.exe -d Ubuntu
cd
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
git clone https://github.com/kaichevannes/nixfiles.git
home-manager switch -f ~/nixfiles/home.nix
```
4. Initialise SSH key
```
ssh-keygen
cat ~/.ssh/id_ed25519.pub
```
## Arch Linux
```bash
pacman -S wezterm
wsl.exe -d Ubuntu
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
git clone https://github.com/kaichevannes/nixfiles.git
home-manager switch -f ~/nixfiles/home.nix
ssh-keygen
cat ~/.ssh/id_ed25519.pub
```
