--Don't do setup twice
if _G.Spoofer then
  return
end

_G.Spoofer = _G.Spoofer or {}
Spoofer._mod_path = ModPath
Spoofer._save_path = SavePath .. "spoofer.json"
Spoofer._settings = {
  name_spoofing_enabled = false,
  name_spoofing_input = "",
  name_spoofing_animated_name_input = false,
  name_spoofing_lyrics_input = false,
  infamy_spoofing_enabled = false,
  infamy_spoofing_input = 0,
  level_spoofing_input = 100,
  lootdrop_spoof = false
}

Spoofer._name_values = {
  index = 0,
  add = true,
  lyrics_index = 1,
  lyrics_slowdown = 0,
  name_refresh = 0.3
}

function Spoofer:name_enabled()
  return self._settings.name_spoofing_enabled
end

function Spoofer:infamy_enabled()
  return self._settings.infamy_spoofing_enabled
end

function Spoofer:delay()
  return self._name_values.name_refresh or 0.3
end

Spoofer._lyrics = {
  "Pockets so fat, call me Orbit, Norbit, I mean",
  "Ain't gotta wait to make no moves 'cause I be loaded",
  "Ain't gotta wait to make no moves 'cause I be loaded",
  "While you out here drinkin' 40's, I just tote it",
  "Still that same nigga in a foreign, but it's stolen",
  "Ridin' sporty, actin' spoiled, I can't control it",
  "I'm doin' fraud, got that bag, yeah, I'm transportin'",
  "I got that bag on me, nigga, like I'm Jansportin'",
  "He dropped his mixtape, thought I woulda repost it",
  "I ain't post his mixtape 'cause I don't fuck with shorty",
  "I be booted to the morning, PM to the morning",
  "My lil' woadie wanna bag him, he just want a Rollie",
  "Hold up, nigga, don't you owe me? Yeah, you owe me, don't it?",
  "Like I'm in Islands of Adventure how I stay rollin'",
  "Tryna diss me",
  "I need you six feet",
  "She say she miss me",
  "She wanna kiss me",
  "Damn, I'm so crispy",
  "Xans got me dizzy",
  "Yeah, trust me I ain't shy",
  "I keep that Glizzy",
  "I will SpinBen (yeah-yeah)",
  "Frisbee",
  "What the lick read?",
  "Baby, come and lick me",
  "V12, how I'm ridin' in the 6-speed",
  "I be ballin' on you niggas out of this league",
  "Ain't gotta wait to make no moves 'cause I be loaded",
  "While you out here drinkin' 40's, I just tote it",
  "Still that same nigga in a foreign, but it's stolen",
  "Ridin' sporty, actin' spoiled, I can't control it",
  "I'm doin' fraud, got that bag, yeah, I'm transportin'",
  "I got that bag on me, nigga, like I'm Jansportin'",
  "He dropped his mixtape, thought I woulda repost it",
  "I ain't post his mixtape 'cause I don't fuck with shorty",
  "Yeah, that Glock got extended like a outlet",
  "How you outchea?",
  "I ain't catch you out yet",
  "I'm so damn fly, I do not step",
  "Yeah, I pop molly and I pop checks",
  "I don't know where I'm goin', I'm just floatin'",
  "My dawg got gun license but he let me hold it",
  "All these niggas phony, I do not condone it",
  "I be goin' ham, I do not baloney",
  "It's a Kodak moment, yeah, bought it 'cause I wanted it",
  "I be on the corner, yeah, fuck the law enforcement",
  "Project Baby got no stroller but I keep pushin'",
  "Shawty love for me to choke her when I'm in that pussy",
  "Ain't gotta wait to make no moves 'cause I be loaded",
  "While you out here drinkin' 40s, I just tote it",
  "Still that same nigga in a foreign, but it's stolen",
  "Ridin' sporty, actin' spoiled, I can't control it",
  "I'm doin' fraud, got that bag, yeah, I'm transportin'",
  "I got that bag on me, nigga, like I'm Jansportin'",
  "He dropped his mixtape, thought I woulda repost it",
  "I ain't post his mixtape 'cause I don't fuck with shorty"
}

function Spoofer:base_name()
  return self._settings.name_spoofing_input
end

function Spoofer:name()
  if self._settings.name_spoofing_animated_name_input then
    return self:_animated_name()
  elseif self._settings.name_spoofing_lyrics_input then
    return self:_lyrics_name()
  else
    return self._settings.name_spoofing_input
  end
end

function Spoofer:_lyrics_name()
  local index = self._name_values.lyrics_index
  local out = self._lyrics[index]

  self._name_values.lyrics_index = index + 1
  if self._name_values.lyrics_index == #self._lyrics then
    self._name_values.lyrics_index = 1
  end

  return out or "abcd"
end

function Spoofer:_animated_name()
  local str = self._settings.name_spoofing_input

  if self._name_values.index >= #str then
    self._name_values.add = false
  end
  if self._name_values.index == 0 then
    self._name_values.add = true
  end
  str = string.sub(str, 1, self._name_values.index)
  if self._name_values.add then
    self._name_values.index = self._name_values.index + 1
  else
    self._name_values.index = self._name_values.index - 1
  end

  return str
end

function Spoofer:infamy()
  return self._settings.infamy_spoofing_input or 0
end

function Spoofer:level()
  return self._settings.level_spoofing_input or 100
end

--Load settings function
function Spoofer:load_settings()
  if io.file_is_readable(self._save_path) then
    Spoofer._settings = io.load_as_json(self._save_path)
  end
end

function Spoofer:save_settings()
  local save_data = Spoofer._settings
  io.save_as_json(save_data, self._save_path)
end

Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_spoofer", function(loc)
  loc:add_localized_strings({
    ["spoofing_menu"] = "Spoofing Menu",
    ["spoofing_menu_desc"] = "Menu for spoofing",
    ["name_spoofing_enabled"] = "Enable Name Spoofing",
    ["name_spoofing_enabled_desc"] = "Silly goofy lying time",
    ["name_spoofing_input"] = "Name",
    ["name_spoofing_input_desc"] = "Set name to spoof",
    ["name_spoofing_animated_name_input"] = "Animate name",
    ["name_spoofing_animated_name_input_desc"] = "Animate name length",
    ["name_spoofing_lyrics_input"] = "Toggle Name Change",
    ["name_spoofing_lyrics_input_desc"] = "Toggle Name Change",
    ["infamy_spoofing_enabled"] = "Enable Progression Spoofing",
    ["infamy_spoofing_enabled_desc"] = "Silly goofy lying time part 2",
    ["infamy_spoofing_input"] = "Infamy",
    ["infamy_spoofing_input_desc"] = "Set infamy to spoof",
    ["level_spoofing_input"] = "Level",
    ["level_spoofing_input_desc"] = "Set level to spoof",
    ["lootdrop_spoof"] = "Lootdrop",
    ["lootdrop_spoof_desc"] = "Silly Little Lootdrops",
  })
end)

local function handle_spoofer_name_change(item)
  if item.selected == 1 then
    Spoofer._settings[item:name()] = true
  else
    Spoofer._settings[item:name()] = false
  end

  if item:name() == "name_spoofing_lyrics_input" then
    Spoofer._name_values.lyrics_index = 1
    if item.selected == 1 then
      Spoofer._name_values.name_refresh = 3
    else
      Spoofer._name_values.name_refresh = 0.3
    end
  end
end

Hooks:Add("MenuManagerInitialize", "spoofer_menu_init", function(menu_manager)
  MenuCallbackHandler.spoofer_toggle_menu_item = function(self, item)
    if item:name() == "infamy_spoofing_input" or item:name() == "level_spoofing_input" then
      Spoofer._settings[item:name()] = tonumber(item._input_text) or 0
    elseif item:name() == "name_spoofing_animated_name_input" or item:name() == "name_spoofing_lyrics_input" then
      handle_spoofer_name_change(item)
    else
      Spoofer._settings[item:name()] = item._input_text
    end
    Spoofer:save_settings()
  end

  MenuCallbackHandler.spoofer_toggle_boolean = function(self, item)
    if item.selected == 1 then
      Spoofer._settings[item:name()] = true
    else
      Spoofer._settings[item:name()] = false
    end
    Spoofer:save_settings()
  end

  Spoofer:load_settings()
  MenuHelper:LoadFromJsonFile(Spoofer._mod_path .. "menu.json", Spoofer, Spoofer._settings)
end)
