# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

export PATH=$HOME/.local/bin:$HOME/bin:$HOME/bin/containers:$HOME/bin/rails:$HOME/bin/gnu_c:$HOME/bin/tools:$PATH
export PS1="\e[0;36m[\u@\h \W]\$ \e[m"
