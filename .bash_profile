# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

export PATH=$HOME/.local/bin:$HOME/bin:$HOME/bin/containers:$HOME/bin/rails:$HOME/bin/gnu_c:$HOME/bin/tools:$HOME/bin/java::$HOME/bin/ide/:$HOME/bin/cad:$PATH
export PS1="\e[0;36m[\u@\h \W]\$ \e[m"

command -v direnv > /dev/null 2>&1 && \
	eval "$(direnv hook bash)"

export DISPLAY=192.168.1.161:0
