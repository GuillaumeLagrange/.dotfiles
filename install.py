#! /usr/bin/python3

from argparse import ArgumentParser
from shutil import which
import os
import subprocess

dotfiles_dir = os.path.dirname(os.path.realpath(__file__))
home_dir = os.path.expanduser("~")
i3_dir = os.path.join(dotfiles_dir, "i3")

_DESCRIPTION = """\
This script installs necessary dotfiles for neovim, i3wm, urxvt, and misc settings
"""

_REQUIRED_SOFTWARE = [
    "i3",
    "nvim",
    "zsh",
    "urxvt",
]

_SYMBOLIC_LINKS = [
    os.path.join(".config", "i3status"),
    os.path.join(".config", "nvim"),
    ".vimrc",
    ".zshrc",
    "scripts",
    ".Xmodmap",
    ".Xressources",
]


def is_installed(name):
    """Check whether `name` is on PATH and marked as executable."""

    return which(name) is not None


def main():
    # Arguments parser
    parser = ArgumentParser(_DESCRIPTION)

    parser.add_argument("-i", "--i3",
                        help="Only generate i3 config",
                        dest="i3",
                        action="store_true")

    args = parser.parse_args()

    # Check required programs are installed and in PATH
    for name in _REQUIRED_SOFTWARE:
        if not is_installed(name):
            print(name + "is not in the PATH")
            return 1

    # Generate i3 config file (no source, so common and local files have to be cat)
    try:
        os.mkdir(os.path.join(home_dir, ".config"))
        os.mkdir(os.path.join(home_dir, ".config", ".i3"))
    except:
        pass

    # Cat both i3 config files
    with open(os.path.join(home_dir, ".config", "i3", "config"), 'w') as fp:
        with open(os.path.join(i3_dir, "config_common"), 'r') as config_common:
            fp.write(config_common.read())
        with open(os.path.join(i3_dir, "config_local"), 'r') as config_local:
            fp.write(config_local.read())

    # Create symbolic links
    for link in _SYMBOLIC_LINKS:
        # Remove old link or file
        subprocess.call(["rm", "-rf", os.path.join(home_dir, link)])
        # Create symlink
        os.symlink(os.path.join(dotfiles_dir, link), os.path.join(home_dir, link))

    # Download vim plug
    subprocess.call("curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
                    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim")
    # Install vim plugins
    subprocess.call("nvim +PlugClean +PlugUpdate +qa")


if __name__ == "__main__":
    main()
