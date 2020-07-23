set fish_greeting
set -x POWERLINE_DIR (python3 -c "import powerline, os; print(os.path.dirname(powerline.__file__))")
set -x VIMRUNTIME $HOME/.local/usr/local/share/vim/vim82
set -x LD_LIBRARY_PATH $HOME/.local/lib
set PATH /snap/bin "$HOME/.local/usr/local/bin" "$HOME/.local/bin" $PATH
set -x PYTHON_USER_BASE_DIR (python3 -m site --user-base)
set PATH $PATH "$PYTHON_USER_BASE_DIR/bin"
set PATH $PATH "/usr/local/msql/bin"
set PATH $PATH "$HOME/emsdk" "$HOME/emsdk/node/12.9.1_64bit/bin" "$HOME/emsdk/upstream/emscripten"
set -x P4CONFIG "$HOME/.p4env"
alias vi="vim"
alias julia="julia --color=yes"
alias ag='ag --path-to-ignore ~/.ignore'
set -x FZF_DEFAULT_COMMAND 'ag -g ""'
