# Installation
1. [Install nix](https://nixos.org/download/)
2. [Install home-manager](https://nix-community.github.io/home-manager/index.xhtml#ch-installation)
3. Clone the repo
4. home-manager switch

## Windows
**Elevated Powershell**
```bash
winget install wez.wezterm
wsl.exe --install
wsl.exe -d Ubuntu
cd ~
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
git clone https://github.com/kaichevannes/nixfiles.git
cd nixfiles
home-manager switch
```
