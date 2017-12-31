local LOCALE = GetLocale()
ArchiTotemLocale = setmetatable({},{__index = function(t,k)
  local v = tostring(k)
  rawset(t,k,v)
  if (LOCALE ~= "enUS") and (LOCALE ~= "enGB") then
  	ArchiTotem_Print(string.format(" %q not found for %s",v,LOCALE),"debug")
  end
  return v
end})
local L = ArchiTotemLocale
BINDING_NAME_CAST_EARTH_TOTEM = L["Cast Earth Totem"]
BINDING_NAME_CAST_FIRE_TOTEM = L["Cast Fire Totem"]
BINDING_NAME_CAST_WATER_TOTEM = L["Cast Water Totem"]
BINDING_NAME_CAST_AIR_TOTEM = L["Cast Air Totem"]