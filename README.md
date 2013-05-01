# My dot files

Since everytime I configure a new clean computer I have to do the same, then I've
decided to automate it and push it to GitHub to share with other developers.

Hope to give ideas and any suggestion is welcome

## Use it

Clone it into the .dotfiles directory in your $HOME path

```bash 
$ git clone git://github.com/jdevesa/dotfiles.git .dotfiles
```

Execute the 'dotfilize' script to link the configuration files into their proper
place and modify some environment statements.

```bash 
$ cd .dotfiles
$ dotfilize
```

Clone the vim plugin repos:

```
$ git submodule update --init
```
