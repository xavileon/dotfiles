# Local VIM configuration and submodules.

That's my local configuration of VIM. It is specifically configured
for develop in python language under a Git version control. It has the
    following plugins:

* Pathogen (http://www.vim.org/scripts/script.php?script_id=2332):
    Easy manipulation of 'runtimepath','path','tags'.

* SnipMate (http://www.vim.org/scripts/script.php?script_id=2540):
    implements some of TextMate's snippets features in Vim.
    (submodule)

* Fugitive (http://www.vim.org/scripts/script.php?script_id=2975):
    A Git wrapper so awesome, it should be illegal. (submodule)

* Git Branch Info (http://www.vim.org/scripts/script.php?script_id=2258):
    A plugin for use on your status line to show info about Git branches

* NERD Tree (http://www.vim.org/scripts/script.php?script_id=1658):
    A tree explorer plugin for navigating the filesystem (submodule)

* PyFlakes (http://www.vim.org/scripts/script.php?script_id=2441):
    PyFlakes on-the-fly Python code checking 

* Pythoncomplete (http://www.vim.org/scripts/script.php?script_id=1542):
    Python Omni Completion

* Tagbar (http://www.vim.org/scripts/script.php?script_id=3465)
    Display tags of the current file ordered by scope

* Tcomment (http://www.vim.org/scripts/script.php?script_id=1173):
    An extensible & universal comment plugin that also handles embedded
    filetypes. (subcomment)

* Xmledit (http://www.vim.org/scripts/script.php?script_id=301):
    A filetype plugin to help edit XML, HTML and SGML documents

* Easytags (http://peterodding.com/code/vim/easytags/):
    Automated tag generation and syntax highlighting in Vim

* FuzzyFinder (http://www.vim.org/scripts/script.php?script_id=1984):
    buffer/file/command/tag/etc explorer with fuzzy matching

* L9 Vim-script library (needed by FuzzyFinder):

* VimRoom (https://github.com/mikewest/vimroom.git):
    Simulating a vaguely WriteRoom-like environment in Vim

Since is using pathogen all plugins are under ~/.vim/bundle path and you 
can delete them in an easier way just deleting the plugin directory 
(and unregistering the submodule in the .gitmodules and .git/config files 
in some cases).

Installation:

    git clone git://github.com/jdevesa/dotvim.git

Create symlinks:

    ln -s ~/.vim/vimrc ~/.vimrc


Initialize submodules:

    git submodule init
    git submodule update

Install ctags:

apt-get install exuberant-ctags (for ubuntu users)  
pacman -S ctags (for archlinux users)
