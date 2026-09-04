import os

config.load_autoconfig()
c.content.javascript.clipboard = "access"
c.qt.args = ['enable-features=PictureInPicture,MiddleClickAutoScroll']
c.qt.environ = {"QTWEBENGINE_FORCE_USE_GBM": "0"}

config.bind(';;', 'hint links spawn webtorrent --mpv {hint-url}')
config.bind('<Ctrl-e>', 'rl-accept', mode="insert")
config.bind('<F8>', 'spawn -u "reload-bookmarks.sh"')

with open(os.path.expanduser("~/.cache/wal/colors"), "r") as file:
    colors = [line.strip() for line in file]
    background = colors[0]
    foreground = colors[15]
    translucid = "#00000000"

    c.colors.statusbar.normal.bg               = background
    c.colors.statusbar.command.bg              = background
    c.colors.statusbar.normal.fg               = colors[14]
    c.colors.statusbar.command.fg              = foreground
    c.colors.statusbar.passthrough.fg          = colors[14]
    c.colors.statusbar.url.fg                  = colors[13]
    c.colors.statusbar.url.success.https.fg    = colors[13]
    c.colors.statusbar.url.hover.fg            = colors[12]
    c.colors.tabs.bar.bg                       = translucid
    c.colors.tabs.even.bg                      = background
    c.colors.tabs.odd.bg                       = background
    c.colors.tabs.even.fg                      = foreground
    c.colors.tabs.odd.fg                       = foreground
    c.colors.tabs.selected.even.bg             = foreground
    c.colors.tabs.selected.odd.bg              = foreground
    c.colors.tabs.selected.even.fg             = background
    c.colors.tabs.selected.odd.fg              = background
    c.colors.hints.bg                          = background
    c.colors.hints.fg                          = foreground
    c.colors.completion.item.selected.match.fg = colors[6]
    c.colors.completion.match.fg               = colors[6]
    
    c.colors.tabs.indicator.start              = colors[10]
    c.colors.tabs.indicator.stop               = colors[8]
    c.colors.completion.odd.bg                 = background
    c.colors.completion.even.bg                = background
    c.colors.completion.fg                     = foreground
    c.colors.completion.category.bg            = background
    c.colors.completion.category.fg            = foreground
    c.colors.completion.item.selected.bg       = background
    c.colors.completion.item.selected.fg       = foreground
    
    c.colors.messages.info.bg                  = background
    c.colors.messages.info.fg                  = foreground
    c.colors.messages.error.bg                 = background
    c.colors.messages.error.fg                 = foreground
    c.colors.downloads.error.bg                = background
    c.colors.downloads.error.fg                = foreground
    
    c.colors.downloads.bar.bg                  = background
    c.colors.downloads.start.bg                = colors[10]
    c.colors.downloads.start.fg                = foreground
    c.colors.downloads.stop.bg                 = colors[8]
    c.colors.downloads.stop.fg                 = foreground
    
    c.colors.tooltip.bg                        = background
    c.colors.tooltip.fg                        = foreground
    #c.colors.webpage.bg                        = background
    c.hints.border                             = foreground
