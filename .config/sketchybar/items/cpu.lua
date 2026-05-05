local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local cpu = SBAR.add("graph", "widgets.cpu" , 42, {
  position = "right",
  graph = { color = colors.blue },
  background = {
    height = 22,
    color = { alpha = 0 },
    border_color = { alpha = 0 },
    drawing = true,
  },
  icon = { string = icons.cpu },
  label = {
    string = "CPU ??%",
    font = {
      family = settings.font.numbers,
      style = settings.font.style_map["Medium"],
      size = 10.0,
    },
    align = "right",
    padding_right = 0,
    width = 0,
    y_offset = 4
  },
  padding_right = settings.paddings + 6,
  update_freq = 2,
})

cpu:subscribe({"routine", "forced"}, function()
  SBAR.exec("top -l 2 -n 0 | awk '/CPU usage/{print $3}' | tail -1 | tr -d '%'", function(out)
    local load = tonumber(out) or 0
    cpu:push({ load / 100. })

    local color = colors.blue
    if load > 30 then
      if load < 60 then
        color = colors.yellow
      elseif load < 80 then
        color = colors.orange
      else
        color = colors.red
      end
    end

    cpu:set({
      graph = { color = color },
      label = { string = math.floor(load) .. "%", align = "right" },
    })
  end)
end)

SBAR.add("bracket", "widgets.cpu.bracket", { cpu.name }, {
  background = { color         = colors.bg05,
  border_color  = colors.bg1, border_width = 1 }
})

SBAR.add("item", "widgets.cpu.padding", {
  position = "right",
  width = settings.group_paddings
})
