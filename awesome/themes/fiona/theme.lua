---------------------------
-- Fiona's awesome theme --
---------------------------

theme = {}

theme.font          = "Bitstream Vera Sans Mono 8"
-- theme.font    = "sans 8"

theme.bg_normal     = "#000000"
theme.bg_focus      = "#00222c"
theme.bg_urgent     = "#ff4500"
theme.bg_minimize   = "#444444"

theme.fg_normal     = "#dddddd"
theme.fg_focus      = "#cccccc"
theme.fg_urgent     = "#111111"
theme.fg_minimize   = "#ffffff"

theme.border_width  = "1"
theme.border_normal = "#333333"
theme.border_focus  = "#00313e"
theme.border_marked = "#91231c"


-- There are another variables sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- Example:
--taglist_bg_focus = #ff0000

-- Display the taglist squares
theme.taglist_squares_sel = "/usr/share/awesome/themes/default/taglist/squarefw.png"
theme.taglist_squares_unsel = "/usr/share/awesome/themes/default/taglist/squarew.png"

theme.tasklist_floating_icon = "/usr/share/awesome/themes/default/tasklist/floatingw.png"


-- Variables set for theming menu
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "/usr/share/awesome/themes/default/submenu.png"
theme.menu_height   = "15"
theme.menu_width    = "100"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
-- bg_widget    = #cc0000

-- Define the image to load
theme.titlebar_close_button_normal = "/usr/share/awesome/themes/default/titlebar/close_normal.png"
theme.titlebar_close_button_focus = "/usr/share/awesome/themes/default/titlebar/close_focus.png"


theme.titlebar_ontop_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = "/usr/share/awesome/themes/default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/usr/share/awesome/themes/default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = "/usr/share/awesome/themes/default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = "/usr/share/awesome/themes/default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/usr/share/awesome/themes/default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = "/usr/share/awesome/themes/default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = "/usr/share/awesome/themes/default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/usr/share/awesome/themes/default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = "/usr/share/awesome/themes/default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = "/usr/share/awesome/themes/default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/usr/share/awesome/themes/default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = "/usr/share/awesome/themes/default/titlebar/maximized_focus_active.png"

-- You can use your own command to set your wallpaper
-- theme.wallpaper_cmd = { "feh --bg-scale /home/fiona/pictures/wallpaper/space4.jpg" }
theme.wallpaper_cmd = { "awsetbg /usr/share/awesome/themes/default/background.png" }

-- You can use your own layout icons like this:
theme.layout_tile = "/home/fiona/.config/awesome/themes/fiona/layouts/tilew.png"
theme.layout_tileleft = "/home/fiona/.config/awesome/themes/fiona/layouts/tileleftw.png"
theme.layout_tilebottom       = "/home/fiona/.config/awesome/themes/fiona/layouts/tilebottomw.png"
theme.layout_tiletop       = "/home/fiona/.config/awesome/themes/fiona/layouts/tiletopw.png"
theme.layout_fairv     = "/home/fiona/.config/awesome/themes/fiona/layouts/fairvw.png"
theme.layout_fairh      = "/home/fiona/.config/awesome/themes/fiona/layouts/fairhw.png"
theme.layout_max       = "/home/fiona/.config/awesome/themes/fiona/layouts/maxw.png"
theme.layout_magnifier       = "/home/fiona/.config/awesome/themes/fiona/layouts/magnifierw.png"
theme.layout_floating      = "/home/fiona/.config/awesome/themes/fiona/layouts/floatingw.png"

theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"

return theme
