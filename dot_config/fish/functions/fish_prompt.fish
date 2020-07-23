function fish_prompt
	if test -z $WINDOW
        printf '%s\uf007 %s %s\uf473 %s %s\ue5ff %s %s$%s ' (set_color yellow) (whoami) (set_color purple) (prompt_hostname) (set_color $fish_color_cwd) (basename (prompt_pwd)) (set_color blue) (set_color normal)
    else
        printf '%s\uf007 %s %s\uf473 %s %s\ue5ff %s%s%s %s$%s ' (set_color yellow) (whoami) (set_color purple) (prompt_hostname) (set_color white) (echo $WINDOW) (set_color $fish_color_cwd) (basename (prompt_pwd)) (set_color blue) (set_color normal)
    end
    if set -q VIRTUAL_ENV
        echo -n -s (set_color -b blue white) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
    end
end
