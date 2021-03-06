-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

-- {{{ Variable definitions
-- My theme
theme_path = os.getenv("HOME") .. "/.config/awesome/themes/fiona/theme.lua"
-- theme_path = "/usr/share/awesome/themes/default/theme.lua"
beautiful.init(theme_path)

terminal = "urxvt"
browser = "firefox"
colorlight = "#4b7885"
colordark = "#223b56"

-- This is used later as the default terminal and editor to run.
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating
}

-- {{{ Tags
tags = {}
tags_list = {"i", "d", "e", "t", "m", "o", "y", "f"}

-- Init tags
for s = 1, screen.count() do
	tags[s] = awful.tag(tags_list, s, -- awful.layout.suit.tile.left )

	{ layouts[1], layouts[1], layouts[1], 
	layouts[1], layouts[1], layouts[1],
	layouts[1], layouts[10]} )
end


-- {{{ Wibox
seperator_left = widget({ type = "textbox", name = "seperator", align = "left"})
seperator_left.text = "<b> :: </b>"

seperator_right = widget({ type = "textbox", name = "seperator", align = "right"})
seperator_right.text = "<b> :: </b>"

-- Create time widget
timebox = awful.widget.textclock({ align = "right" })

-- Create a systray
mysystray = widget({ type = "systray", align = "right" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
						awful.button({ }, 1, awful.tag.viewonly),
                       	awful.button({ modkey }, 1, awful.client.movetotag),
						awful.button({ }, 3, function (tag) tag.selected = not tag.selected end),
                      	awful.button({ modkey }, 3, awful.client.toggletag),
                      	awful.button({ }, 4, awful.tag.viewnext),
                      	awful.button({ }, 5, awful.tag.viewprev)
					)
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
						awful.button({ }, 1, function (c)
						                 if not c:isvisible() then
                                              awful.tag.viewonly(c:tags()[1])
                                          end
                                          client.focus = c
                                          c:raise()
                                      end),
                        awful.button({ }, 3, function () if instance then instance:hide() end instance = awful.menu.clients({ width=250 }) end),
                        awful.button({ }, 4, function ()
                                          awful.client.focus.byidx(1)
                                          if client.focus then client.focus:raise() end
                                      end),
                        awful.button({ }, 5, function ()
                                          awful.client.focus.byidx(-1)
                                          if client.focus then client.focus:raise() end
                                      end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })

    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
				awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))

    -- Create taglist and tasklist widgets
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    mytasklist[s] = awful.widget.tasklist(function(c)
                                                  return awful.widget.tasklist.label.currenttags(c, s)
                                              end, mytasklist.buttons)


    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
		{
			mytaglist[s],
			seperator_left,
			mylayoutbox[s],
			seperator_left,
			layout = awful.widget.layout.horizontal.leftright
		},
		timebox,
		mypromptbox[s],
		seperator_right,
		s == 1 and mysystray or nil,
		mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
	}
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}


-- {{{ Key bindings
globalkeys = awful.util.table.join(

		   -- Navigating tags
           -- awful.key({ modkey }, "Left", awful.tag.viewprev),
		   -- awful.key({ modkey }, "Right", awful.tag.viewnext),
		   awful.key({ modkey }, "Escape", awful.tag.history.restore),

		   -- Scrot on print screen
		   awful.key({}, "Print", function () awful.util.spawn("scrot 'screen-%Y-%m-%d_%H%M.png' -e 'mv $f ~/pictures/screens/'") end),

		   -- Standard program
		   awful.key({ modkey }, "Return", function () awful.util.spawn(terminal) end),
		   awful.key({ modkey, "Control" }, "r", awesome.restart),
		   awful.key({ modkey, "Shift"   }, "q", awesome.quit),

		   awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
	       awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
		   awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
	       awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
	       awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
	       awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
	       awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
	       awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),
           awful.key({ modkey }, "Next",  function () awful.client.moveresize( 20,  20, -40, -40) end),
           awful.key({ modkey }, "Prior", function () awful.client.moveresize(-20, -20,  40,  40) end),
           awful.key({ modkey }, "Down",  function () awful.client.moveresize(  0,  20,   0,   0) end),
           awful.key({ modkey }, "Up",    function () awful.client.moveresize(  0, -20,   0,   0) end),
           awful.key({ modkey }, "Left",  function () awful.client.moveresize(-20,   0,   0,   0) end),
           awful.key({ modkey }, "Right", function () awful.client.moveresize( 20,   0,   0,   0) end),
		   -- Layout manipulation
		   awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1) end),
		   awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1) end),
		   awful.key({ modkey, "Control" }, "j", function () awful.screen.focus( 1)       end),
		   awful.key({ modkey, "Control" }, "k", function () awful.screen.focus(-1)       end),
		   awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
		   awful.key({ modkey,           }, "Tab",
           			   function ()
					     awful.client.focus.history.previous()
						 if client.focus then
						   client.focus:raise()
						 end
					   end),

		   -- Prompt
		   awful.key({ modkey }, "r",
              function ()
                  awful.prompt.run({ prompt = "Run: " },
                  mypromptbox[mouse.screen],
                  awful.util.spawn, awful.completion.shell,
                  awful.util.getdir("cache") .. "/history")
              end),

		    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen],
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),

		   -- Dmenu binding
		   awful.key({ modkey }, "q",
		     function ()
			   awful.util.spawn(
			     "dmenu_run -nb '#000000' -nf '#ffffff'"
		   		 )
			  end)

)


-- Client awful tagging: this is useful to tag some clients and then do stuff like move to tag on them
clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey }, "t", awful.client.togglemarked),
    awful.key({ modkey,}, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)


-- Bind keyboard digits
-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end


clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
    { rule = { instance = "plugin-container" },
        properties = { floating = true } },
    { rule = { instance = "swtor.exe" },
        properties = { floating = true, fullscreen = true } },
    { rule = { class = ".*Wine.*" },
        properties = { floating = true, fullscreen = true } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}


-- Hook called every second
--awful.hooks.timer.register(1, function ()
--	timebox.text = os.date("%A %d/%m/%y %X")
--end)
-- }}}

