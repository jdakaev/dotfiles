#!/usr/bin/env bash
git clone https://github.com/jamescherti/minimal-emacs.d ~/.emacs.d
ln -s ~/.my-emacs/pre-init.el ~/.emacs.d
ln -s ~/.my-emacs/post-init.el ~/.emacs.d
ln -s ~/.my-emacs/pre-early-init.el ~/.emacs.d
ln -s ~/.my-emacs/post-early-init.el ~/.emacs.d
