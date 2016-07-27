#! /usr/bin/env python3

##
# GPL license
# Code based on MATE-HUD.
# URL: https://bitbucket.org/ubuntu-mate/mate-hud/
# Modifications made by Dave Davenport  <qball@gmpclient.org>
##

import gi

gi.require_version("Gtk", "3.0")


from gi.repository import Gio, GLib, Gtk


def rgba_to_hex(color):
    return "#{0:02x}{1:02x}{2:02x}".format( int(color.red   * 255), int(color.green * 255), int(color.blue * 255))



window = Gtk.Window()

style_context = window.get_style_context()


bg_color = rgba_to_hex(style_context.lookup_color('theme_bg_color')[1])
fg_color = rgba_to_hex(style_context.lookup_color('theme_fg_color')[1])

selected_bg_color = rgba_to_hex(style_context.lookup_color('theme_selected_bg_color')[1])
selected_fg_color = rgba_to_hex(style_context.lookup_color('theme_selected_fg_color')[1])
error_bg_color = rgba_to_hex(style_context.lookup_color('error_bg_color')[1])
error_fg_color = rgba_to_hex(style_context.lookup_color('error_fg_color')[1])
warning_bg_color = rgba_to_hex(style_context.lookup_color('warning_bg_color')[1])
warning_fg_color = rgba_to_hex(style_context.lookup_color('warning_fg_color')[1])
text_color = rgba_to_hex(style_context.lookup_color('theme_text_color')[1])
borders = rgba_to_hex(style_context.lookup_color('theme_unfocused_fg_color')[1])



print( 'rofi.color-window: '+ bg_color +", " + borders + ", " + borders)
print( 'rofi.color-normal: '+ bg_color +", " + fg_color + ", " + bg_color + ", " + selected_bg_color + ", " + selected_fg_color)
print( 'rofi.color-active: '+ bg_color +", " + fg_color + ", " + bg_color + ", " + warning_bg_color + ", " + warning_fg_color)
print( 'rofi.color-urgent: '+ bg_color +", " + fg_color + ", " + bg_color + ", " + error_bg_color + ", " + error_fg_color)
