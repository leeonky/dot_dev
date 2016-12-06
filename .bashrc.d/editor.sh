alias e="if [ \"\$BASH_HOST\" == dvim ]; then exit; elif [ -f project.vim ]; then dexe dvim vim -S project.vim; else dexe dvim vim; fi"
