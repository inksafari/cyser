## Backup

### Atom

    apm list --installed --bare > Atomfile

### Arch

    # Install pacman packages
    sudo pacman -Syu --noconfirm --needed $(< pacman-deps.txt)

    # Install AUR packages
    yaourt -Syua --noconfirm --needed $(< aur-deps.txt)

### Brew

    brew bundle dump --force --file=./Brewfile
