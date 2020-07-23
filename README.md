# minimal-dotfiles

Minimal environment for using tmux and vim on a fresh macOS/linux machine.

```
mkdir ~/.local
cd ~/.local
curl -sfL https://git.io/chezmoi | sh
./bin/chezmoi init https://github.com/rjkat/minimal-dotfiles.git
./bin/chezmoi apply
source ~/.bashrc
volt get -l
volt build -full
```
