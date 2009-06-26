-- Include awesome libraries, with lots of useful function!
require("awful")
require("beautiful")

-- {{{ Variable definitions
-- My theme
theme_path = os.getenv("HOME") .. "/.config/awesome/themes/fiona/theme"
--theme_path = "/usr/share/awesome/themes/default/theme"
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
layouts =
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

-- Table of clients that should be floating
floatapp =
{
  ["gimp"] = true,
  ["Download"] = true
}

-- Apps that should be moved to a specific tag
apptags =
{
  ["Firefox"] = { screen = 1, tag = 1 }
}

-- Define if we want to use titlebar on all applications.
use_titlebar = false
-- }}}

-- {{{ Tags
tags = {}
tags.settings = {
	{ name = "i", layout = layouts[1], setslave = true },
	{ name = "d", layout = layouts[1], setslave = true },
	{ name = "e", layout = layouts[1] },
	{ name = "t", layout = layouts[1] },
	{ name = "m", layout = layouts[1] },
	{ name = "o", layout = layouts[1] },
	{ name = "y", layout = layouts[1] },
	{ name = "f", layout = layouts[10] }
}

-- Init tags
for s = 1, screen.count() do
	tags[s] = {}
	for i, v in ipairs(tags.settings) do
		tags[s][i] = tag(v.name)
		tags[s][i].screen = s
		awful.layout.set(v.layout, tags[s][i])
	end
	tags[s][1].selected = true
end


-- {{{ Wibox
seperator_left = widget({ type = "textbox", name = "seperator", align = "left"})
seperator_left.text = "<b> :: </b>"

seperator_right = widget({ type = "textbox", name = "seperator", align = "right"})
seperator_right.text = "<b> :: </b>"

-- Create time widget
timebox = widget({ type = "textbox", name = "time", align = "right" })
timebox.text = "<b><small> " .. AWESOME_RELEASE .. " </small></b>"

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
    mypromptbox[s] = widget({ type = "textbox", align = "left" })

    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist.new(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = widget({ type = "imagebox", align = "left" })
    mylayoutbox[s]:buttons(awful.util.table.join(
				awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))

    -- Create taglist and tasklist widgets
    mytaglist[s] = awful.widget.taglist.new(s, awful.widget.taglist.label.all, mytaglist.buttons)

    mytasklist[s] = awful.widget.tasklist.new(function(c)
                                                  return awful.widget.tasklist.label.currenttags(c, s)
                                              end, mytasklist.buttons)


    -- Create the wibox
    mywibox[s] = wibox({ position = "top", fg = beautiful.fg_normal, bg = beautiful.bg_normal })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
		mytaglist[s],
		seperator_left,
		mylayoutbox[s],
		seperator_left,
		mytasklist[s],
		mypromptbox[s],
		seperator_right,			
		timebox,
		s == 1 and mysystray or nil
	}
    mywibox[s].screen = s
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
		   awful.key({ modkey }, "Left", awful.tag.viewprev),
		   awful.key({ modkey }, "Right", awful.tag.viewnext),
		   awful.key({ modkey }, "Escape", awful.tag.history.restore),

		   -- Scrot on print screen
		   awful.key({}, "Print", function () awful.util.spawn("scrot 'screen-%Y-%m-%d_%H%M.png' -e 'mv $f ~/pictures/screens/'") end),

		   -- Dmenu binding
		   awful.key({ modkey }, "q", function () awful.util.spawn(
			 "`dmenu_path | dmenu -nb '#000000' -nf '#ffffff'` && exec $exe"
		   ) end),

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
    table.foreach(awful.key({ modkey }, i,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end), function(_, k) table.insert(globalkeys, k) end)
    table.foreach(awful.key({ modkey, "Control" }, i,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          tags[screen][i].selected = not tags[screen][i].selected
                      end
                  end), function(_, k) table.insert(globalkeys, k) end)
    table.foreach(awful.key({ modkey, "Shift" }, i,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end), function(_, k) table.insert(globalkeys, k) end)
    table.foreach(awful.key({ modkey, "Control", "Shift" }, i,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end), function(_, k) table.insert(globalkeys, k) end)
    table.foreach(awful.key({ modkey, "Shift" }, "F" .. i,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          for k, c in pairs(awful.client.getmarked()) do
                              awful.client.movetotag(tags[screen][i], c)
                          end
                      end
                   end), function(_, k) table.insert(globalkeys, k) end)
end

-- Set keys
root.keys(globalkeys)
-- }}}


-- {{{ Hooks
-- Hook function to execute when focusing a client.
awful.hooks.focus.register(function (c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_focus
    end
end)

-- Hook function to execute when unfocusing a client.
awful.hooks.unfocus.register(function (c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_normal
    end
end)

-- Hook function to execute when marking a client
awful.hooks.marked.register(function (c)
    c.border_color = beautiful.border_marked
end)

-- Hook function to execute when unmarking a client.
awful.hooks.unmarked.register(function (c)
    c.border_color = beautiful.border_focus
end)

-- Hook function to execute when the mouse enters a client.
awful.hooks.mouse_enter.register(function (c)
    -- Sloppy focus, but disabled for magnifier layout
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)


-- Hook function to execute when a new client appears.
awful.hooks.manage.register(function (c, startup)
    -- If we are not managing this application at startup,
    -- move it to the screen where the mouse is.
    -- We only do it for filtered windows (i.e. no dock, etc).
    if not startup and awful.client.focus.filter(c) then
        c.screen = mouse.screen
    end

    if use_titlebar then
        -- Add a titlebar
        awful.titlebar.add(c, { modkey = modkey })
    end
    -- Add mouse bindings
    c:buttons(awful.util.table.join(
        awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
        awful.button({ modkey }, 1, awful.mouse.client.move),
        awful.button({ modkey }, 3, awful.mouse.client.resize)
    ))
    -- New client may not receive focus
    -- if they're not focusable, so set border anyway.
    c.border_width = beautiful.border_width
    c.border_color = beautiful.border_normal

    -- Check if the application should be floating.
    local cls = c.class
    local inst = c.instance
    if floatapps[cls] then
        awful.client.floating.set(c, floatapps[cls])
    elseif floatapps[inst] then
        awful.client.floating.set(c, floatapps[inst])
    end

    -- Check application->screen/tag mappings.
    local target
    if apptags[cls] then
        target = apptags[cls]
    elseif apptags[inst] then
        target = apptags[inst]
    end
    if target then
        c.screen = target.screen
        awful.client.movetotag(tags[target.screen][target.tag], c)
    end

    -- Do this after tag mapping, so you don't see it on the wrong tag for a split second.
    client.focus = c

    -- Set key bindings
    c:keys(clientkeys)

    -- Put windows at the end of others instead of setting them as a master
    --awful.client.setslave(c)

    -- New floating windows don't cover the wibox and don't overlap until it's unavoidable
    --awful.placement.no_offscreen(c)
    --awful.placement.no_overlap(c)
    -- 
    -- Honoring size hints: false to remove gaps between windows
    c.size_hints_honor = false

end)


-- Hook function to execute when arranging the screen.
-- (tag switch, new client, etc)
awful.hooks.arrange.register(function (screen)
    local layout = awful.layout.getname(awful.layout.get(screen))
    if layout and beautiful["layout_" ..layout] then
        mylayoutbox[screen].image = image(beautiful["layout_" .. layout])
    else
        mylayoutbox[screen].image = nil
    end

    -- Give focus to the latest client in history if no window has focus
    -- or if the current window is a desktop or a dock one.
    if not client.focus then
        local c = awful.client.focus.history.get(screen, 0)
        if c then client.focus = c end
    end
end)

-- Hook called every second
awful.hooks.timer.register(1, function ()
	timebox.text = os.date("%A %d/%m/%y %X")
end)
-- }}}
