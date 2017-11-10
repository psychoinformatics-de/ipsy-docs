#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

#
# About the site
#
AUTHOR = u'Alex Waite'
SITENAME = u'IPSY Docs'
SITEURL = ''

TIMEZONE = 'Europe/Berlin'
DEFAULT_LANG = u'en'
LOCALE = u'en_US.UTF-8'

#
# Configure Pelican a bit
#
PLUGIN_PATHS = ['pelican-plugins']
PLUGINS = ['pelican-page-hierarchy', 'tipue_search']

THEME = 'theme'
DIRECT_TEMPLATES = ['search'] # unset all templates
STATIC_PATHS = ['css', 'ts']

PATH_METADATA = 'pages/(?P<path>.*)\..*'

FEED_ALL_ATOM = None
AUTHOR_SAVE_AS = False
