#!/usr/bin/env python3
import os
import subprocess
import sys

BASE = os.path.abspath(sys.path[0])
HOME = os.path.expanduser('~')

def symlink(dir, blacklist={}):
    src = os.path.abspath('%s/%s' % (BASE, dir))
    dst = os.path.abspath('%s/%s' % (HOME, dir))
    for f in os.listdir(src):
        if f in blacklist:
            continue
        src_path = '%s/%s' % (src, f)
        cmd = ['ln', '-s', '-T', src_path, '%s/%s' % (dst, f)]
        subprocess.run(cmd)

symlink('.', {'.git', 'init.py', '.config', '.nvim'})
symlink('.config')
symlink('.nvim')

for d in ['backup', 'swap', 'undo']:
    os.makedirs('%s/.nvim/%s' % (HOME, d), exist_ok=True)
