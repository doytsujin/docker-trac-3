#!/usr/bin/env python
# -*- coding: utf-8 -*-
__date__= 'Jul 11, 2016 '
__author__= 'samuel'

import os
import sys
from ConfigParser import SafeConfigParser

SUPPORTED_OP = ['add', 'edit']

def main():
    try:
        ini_filename = sys.argv[1]
        op = sys.argv[2]
        section = sys.argv[3]
        option = sys.argv[4]
        value = ' '.join(sys.argv[5:])

    except:
        print '\n  edit_ini.py <ini_filename> <add/edit> <section> <option> <value>\n'

    if not os.path.isfile(ini_filename):
        print 'ini file(%s) is not exist' % ini_filename
        return 1

    parser = SafeConfigParser()
    parser.read(ini_filename)
    if op not in SUPPORTED_OP:
        print 'op(%s) is not supported' % op
        return 2


    if (len([x for x in parser.sections() if x == section]) == 0) and (op == 'add'):
        parser.add_section(section)

    if (len([x for x in parser.sections() if x == section]) == 0) and (op != 'add'):
        print 'section(%s) is not exist' % section
        return 3


    try:
        parser.set(section, option, value)
    except:
        print 'ini_filename: ', ini_filename
        print 'op: ', op
        print 'section: ', section
        print 'option: ', option
        print 'value: ', value
        return 4

    with open(ini_filename,'w') as f:
        parser.write(f)


if __name__ == '__main__':
    main()

