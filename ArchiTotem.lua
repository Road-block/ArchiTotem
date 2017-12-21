local _G = getfenv()
local L = ArchiTotemLocale
local version = GetAddOnMetadata("ArchiTotem", "Version")
local author = GetAddOnMetadata("ArchiTotem", "Author")

local _, class = UnitClass("player")
local CLOCK_UPDATE_RATE = 0.1
ArchiTotemCasted = nil
ArchiTotemCastedTotem = nil
ArchiTotemCastedElement = nil
ArchiTotemCastedButton = nil
ArchiTotemActiveTotem = {}

local totemElements = { "Earth", "Fire", "Water", "Air" }

local ArchiTotemPopout = {
	"ArchiTotemButton_Earth2",
	"ArchiTotemButton_Earth3",
	"ArchiTotemButton_Earth4",
	"ArchiTotemButton_Earth5",
	"ArchiTotemButton_Fire2",
	"ArchiTotemButton_Fire3",
	"ArchiTotemButton_Fire4",
	"ArchiTotemButton_Fire5",
	"ArchiTotemButton_Water2",
	"ArchiTotemButton_Water3",
	"ArchiTotemButton_Water4",
	"ArchiTotemButton_Water5",
	"ArchiTotemButton_Water6",
	"ArchiTotemButton_Air2",
	"ArchiTotemButton_Air3",
	"ArchiTotemButton_Air4",
	"ArchiTotemButton_Air5",
	"ArchiTotemButton_Air6",
	"ArchiTotemButton_Air7",
}

if not ArchiTotem_Options then
	
	ArchiTotem_Options = {}
	
	ArchiTotem_Options["Ear"] = {}
	ArchiTotem_Options["Ear"].max = 5
	ArchiTotem_Options["Ear"].shown = 1
	
	ArchiTotem_Options["Fir"] = {}
	ArchiTotem_Options["Fir"].max = 5
	ArchiTotem_Options["Fir"].shown = 1
	
	ArchiTotem_Options["Wat"] = {}
	ArchiTotem_Options["Wat"].max = 6
	ArchiTotem_Options["Wat"].shown = 1
	
	ArchiTotem_Options["Air"] = {}
	ArchiTotem_Options["Air"].max = 7
	ArchiTotem_Options["Air"].shown = 1
	
	ArchiTotem_Options["Apperance"] = {}
	ArchiTotem_Options["Apperance"].direction = "up"
	ArchiTotem_Options["Apperance"].scale = 1
	ArchiTotem_Options["Apperance"].allonmouseover = false
	ArchiTotem_Options["Apperance"].bottomoncast = true
	ArchiTotem_Options["Apperance"].shownumericcooldowns = true
	ArchiTotem_Options["Apperance"].showtooltips = true
	
	ArchiTotem_Options["Order"] = {}
	ArchiTotem_Options["Order"].first = "Earth"
	ArchiTotem_Options["Order"].second = "Fire"
	ArchiTotem_Options["Order"].third = "Water"
	ArchiTotem_Options["Order"].forth = "Air"
	
	ArchiTotem_Options["Debug"] = false
	
end

if not ArchiTotem_TotemData then
	ArchiTotem_TotemData = {}
	
	ArchiTotem_TotemData["ArchiTotemButton_Earth1"] = {}
	ArchiTotem_TotemData["ArchiTotemButton_Earth1"].icon = "Interface\\Icons\\Spell_Nature_StrengthOfEarthTotem02"
	ArchiTotem_TotemData["ArchiTotemButton_Earth1"].name = "Earthbind Totem"
	ArchiTotem_TotemData["ArchiTotemButton_Earth1"].duration = 45
	ArchiTotem_TotemData["ArchiTotemButton_Earth1"].cooldown = 15
	ArchiTotem_TotemData["ArchiTotemButton_Earth1"].cooldownstarted = nil
	ArchiTotem_TotemData["ArchiTotemButton_Earth1"].casted = nil
	
	ArchiTotem_TotemData["ArchiTotemButton_Earth2"] = {}
	ArchiTotem_TotemData["ArchiTotemButton_Earth2"].icon = "Interface\\Icons\\Spell_Nature_TremorTotem"
	ArchiTotem_TotemData["ArchiTotemButton_Earth2"].name = "Tremor Totem"
	ArchiTotem_TotemData["ArchiTotemButton_Earth2"].duration = 120
	ArchiTotem_TotemData["ArchiTotemButton_Earth2"].cooldown = 0
	ArchiTotem_TotemData["ArchiTotemButton_Earth2"].cooldownstarted = nil
	ArchiTotem_TotemData["ArchiTotemButton_Earth2"].casted = nil
	
	ArchiTotem_TotemData["ArchiTotemButton_Earth3"] = {}
	ArchiTotem_TotemData["ArchiTotemButton_Earth3"].icon = "Interface\\Icons\\Spell_Nature_EarthBindTotem"
	ArchiTotem_TotemData["ArchiTotemButton_Earth3"].name = "Strength of Earth Totem"
	ArchiTotem_TotemData["ArchiTotemButton_Earth3"].duration = 120
	ArchiTotem_TotemData["ArchiTotemButton_Earth3"].cooldown = 0
	ArchiTotem_TotemData["ArchiTotemButton_Earth3"].cooldownstarted = nil
	ArchiTotem_TotemData["ArchiTotemButton_Earth3"].casted = nil
	
	ArchiTotem_TotemData["ArchiTotemButton_Earth4"] = {}
	ArchiTotem_TotemData["ArchiTotemButton_Earth4"].icon = "Interface\\Icons\\Spell_Nature_StoneSkinTotem"
	ArchiTotem_TotemData["ArchiTotemButton_Earth4"].name = "Stoneskin Totem"
	ArchiTotem_TotemData["ArchiTotemButton_Earth4"].duration = 120
	ArchiTotem_TotemData["ArchiTotemButton_Earth4"].cooldown = 0
	ArchiTotem_TotemData["ArchiTotemButton_Earth4"].cooldownstarted = nil
	ArchiTotem_TotemData["ArchiTotemButton_Earth4"].casted = nil
	
	ArchiTotem_TotemData["ArchiTotemButton_Earth5"] = {}
	ArchiTotem_TotemData["ArchiTotemButton_Earth5"].icon = "Interface\\Icons\\Spell_Nature_StoneClawTotem"
	ArchiTotem_TotemData["ArchiTotemButton_Earth5"].name = "Stoneclaw Totem"
	ArchiTotem_TotemData["ArchiTotemButton_Earth5"].duration = 15
	ArchiTotem_TotemData["ArchiTotemButton_Earth5"].cooldown = 30
	ArchiTotem_TotemData["ArchiTotemButton_Earth5"].cooldownstarted = nil
	ArchiTotem_TotemData["ArchiTotemButton_Earth5"].casted = nil
	
	
	ArchiTotem_TotemData["ArchiTotemButton_Fire1"] = {}
	ArchiTotem_TotemData["ArchiTotemButton_Fire1"].icon = "Interface\\Icons\\Spell_Fire_SearingTotem"
	ArchiTotem_TotemData["ArchiTotemButton_Fire1"].name = "Searing Totem"
	ArchiTotem_TotemData["ArchiTotemButton_Fire1"].duration = 55
	ArchiTotem_TotemData["ArchiTotemButton_Fire1"].cooldown = 0
	ArchiTotem_TotemData["ArchiTotemButton_Fire1"].cooldownstarted = nil
	ArchiTotem_TotemData["ArchiTotemButton_Fire1"].casted = nil
	
	ArchiTotem_TotemData["ArchiTotemButton_Fire2"] = {}
	ArchiTotem_TotemData["ArchiTotemButton_Fire2"].icon = "Interface\\Icons\\Spell_Fire_SealOfFire"
	ArchiTotem_TotemData["ArchiTotemButton_Fire2"].name = "Fire Nova Totem"
	ArchiTotem_TotemData["ArchiTotemButton_Fire2"].duration = 5
	ArchiTotem_TotemData["ArchiTotemButton_Fire2"].cooldown = 15
	ArchiTotem_TotemData["ArchiTotemButton_Fire2"].cooldownstarted = nil
	ArchiTotem_TotemData["ArchiTotemButton_Fire2"].casted = nil
	
	ArchiTotem_TotemData["ArchiTotemButton_Fire3"] = {}
	ArchiTotem_TotemData["ArchiTotemButton_Fire3"].icon = "Interface\\Icons\\Spell_Fire_SelfDestruct"
	ArchiTotem_TotemData["ArchiTotemButton_Fire3"].name = "Magma Totem"
	ArchiTotem_TotemData["ArchiTotemButton_Fire3"].duration = 20
	ArchiTotem_TotemData["ArchiTotemButton_Fire3"].cooldown = 0
	ArchiTotem_TotemData["ArchiTotemButton_Fire3"].cooldownstarted = nil
	ArchiTotem_TotemData["ArchiTotemButton_Fire3"].casted = nil
	
	ArchiTotem_TotemData["ArchiTotemButton_Fire4"] = {}
	ArchiTotem_TotemData["ArchiTotemButton_Fire4"].icon = "Interface\\Icons\\Spell_FrostResistanceTotem_01"
	ArchiTotem_TotemData["ArchiTotemButton_Fire4"].name = "Frost Resistance Totem"
	ArchiTotem_TotemData["ArchiTotemButton_Fire4"].duration = 120
	ArchiTotem_TotemData["ArchiTotemButton_Fire4"].cooldown = 0
	ArchiTotem_TotemData["ArchiTotemButton_Fire4"].cooldownstarted = nil
	ArchiTotem_TotemData["ArchiTotemButton_Fire4"].casted = nil
	
	ArchiTotem_TotemData["ArchiTotemButton_Fire5"] = {}
	ArchiTotem_TotemData["ArchiTotemButton_Fire5"].icon = "Interface\\Icons\\Spell_Nature_GuardianWard"
	ArchiTotem_TotemData["ArchiTotemButton_Fire5"].name = "Flametongue Totem"
	ArchiTotem_TotemData["ArchiTotemButton_Fire5"].duration = 120
	ArchiTotem_TotemData["ArchiTotemButton_Fire5"].cooldown = 0
	ArchiTotem_TotemData["ArchiTotemButton_Fire5"].cooldownstarted = nil
	ArchiTotem_TotemData["ArchiTotemButton_Fire5"].casted = nil
	
	
	ArchiTotem_TotemData["ArchiTotemButton_Water1"] = {}
	ArchiTotem_TotemData["ArchiTotemButton_Water1"].icon = "Interface\\Icons\\Spell_Nature_ManaRegenTotem"
	ArchiTotem_TotemData["ArchiTotemButton_Water1"].name = "Mana Spring Totem"
	ArchiTotem_TotemData["ArchiTotemButton_Water1"].duration = 60
	ArchiTotem_TotemData["ArchiTotemButton_Water1"].cooldown = 0
	ArchiTotem_TotemData["ArchiTotemButton_Water1"].cooldownstarted = nil
	ArchiTotem_TotemData["ArchiTotemButton_Water1"].casted = nil
	
	ArchiTotem_TotemData["ArchiTotemButton_Water2"] = {}
	ArchiTotem_TotemData["ArchiTotemButton_Water2"].icon = "Interface\\Icons\\Spell_Frost_SummonWaterElemental"
	ArchiTotem_TotemData["ArchiTotemButton_Water2"].name = "Mana Tide Totem"
	ArchiTotem_TotemData["ArchiTotemButton_Water2"].duration = 12
	ArchiTotem_TotemData["ArchiTotemButton_Water2"].cooldown = 300
	ArchiTotem_TotemData["ArchiTotemButton_Water2"].cooldownstarted = nil
	ArchiTotem_TotemData["ArchiTotemButton_Water2"].casted = nil
	
	ArchiTotem_TotemData["ArchiTotemButton_Water3"] = {}
	ArchiTotem_TotemData["ArchiTotemButton_Water3"].icon = "Interface\\Icons\\Spell_FireResistanceTotem_01"
	ArchiTotem_TotemData["ArchiTotemButton_Water3"].name = "Fire Resistance Totem"
	ArchiTotem_TotemData["ArchiTotemButton_Water3"].duration = 120
	ArchiTotem_TotemData["ArchiTotemButton_Water3"].cooldown = 0
	ArchiTotem_TotemData["ArchiTotemButton_Water3"].cooldownstarted = nil
	ArchiTotem_TotemData["ArchiTotemButton_Water3"].casted = nil
	
	ArchiTotem_TotemData["ArchiTotemButton_Water4"] = {}
	ArchiTotem_TotemData["ArchiTotemButton_Water4"].icon = "Interface\\Icons\\Spell_Nature_PoisonCleansingTotem"
	ArchiTotem_TotemData["ArchiTotemButton_Water4"].name = "Poison Cleansing Totem"
	ArchiTotem_TotemData["ArchiTotemButton_Water4"].duration = 120
	ArchiTotem_TotemData["ArchiTotemButton_Water4"].cooldown = 0
	ArchiTotem_TotemData["ArchiTotemButton_Water4"].cooldownstarted = nil
	ArchiTotem_TotemData["ArchiTotemButton_Water4"].casted = nil
	
	ArchiTotem_TotemData["ArchiTotemButton_Water5"] = {}
	ArchiTotem_TotemData["ArchiTotemButton_Water5"].icon = "Interface\\Icons\\Spell_Nature_DiseaseCleansingTotem"
	ArchiTotem_TotemData["ArchiTotemButton_Water5"].name = "Disease Cleansing Totem"
	ArchiTotem_TotemData["ArchiTotemButton_Water5"].duration = 120
	ArchiTotem_TotemData["ArchiTotemButton_Water5"].cooldown = 0
	ArchiTotem_TotemData["ArchiTotemButton_Water5"].cooldownstarted = nil
	ArchiTotem_TotemData["ArchiTotemButton_Water5"].casted = nil
	
	ArchiTotem_TotemData["ArchiTotemButton_Water6"] = {}
	ArchiTotem_TotemData["ArchiTotemButton_Water6"].icon = "Interface\\Icons\\INV_Spear_04"
	ArchiTotem_TotemData["ArchiTotemButton_Water6"].name = "Healing Stream Totem"
	ArchiTotem_TotemData["ArchiTotemButton_Water6"].duration = 60
	ArchiTotem_TotemData["ArchiTotemButton_Water6"].cooldown = 0
	ArchiTotem_TotemData["ArchiTotemButton_Water6"].cooldownstarted = nil
	ArchiTotem_TotemData["ArchiTotemButton_Water6"].casted = nil
	
	
	ArchiTotem_TotemData["ArchiTotemButton_Air1"] = {}
	ArchiTotem_TotemData["ArchiTotemButton_Air1"].icon = "Interface\\Icons\\Spell_Nature_Brilliance"
	ArchiTotem_TotemData["ArchiTotemButton_Air1"].name = "Tranquil Air Totem"
	ArchiTotem_TotemData["ArchiTotemButton_Air1"].duration = 120
	ArchiTotem_TotemData["ArchiTotemButton_Air1"].cooldown = 0
	ArchiTotem_TotemData["ArchiTotemButton_Air1"].cooldownstarted = nil
	ArchiTotem_TotemData["ArchiTotemButton_Air1"].casted = nil
	
	ArchiTotem_TotemData["ArchiTotemButton_Air2"] = {}
	ArchiTotem_TotemData["ArchiTotemButton_Air2"].icon = "Interface\\Icons\\Spell_Nature_GroundingTotem"
	ArchiTotem_TotemData["ArchiTotemButton_Air2"].name = "Grounding Totem"
	ArchiTotem_TotemData["ArchiTotemButton_Air2"].duration = 45
	ArchiTotem_TotemData["ArchiTotemButton_Air2"].cooldown = 15
	ArchiTotem_TotemData["ArchiTotemButton_Air2"].cooldownstarted = nil
	ArchiTotem_TotemData["ArchiTotemButton_Air2"].casted = nil
	
	ArchiTotem_TotemData["ArchiTotemButton_Air3"] = {}
	ArchiTotem_TotemData["ArchiTotemButton_Air3"].icon = "Interface\\Icons\\Spell_Nature_Windfury"
	ArchiTotem_TotemData["ArchiTotemButton_Air3"].name = "Windfury Totem"
	ArchiTotem_TotemData["ArchiTotemButton_Air3"].duration = 120
	ArchiTotem_TotemData["ArchiTotemButton_Air3"].cooldown = 0
	ArchiTotem_TotemData["ArchiTotemButton_Air3"].cooldownstarted = nil
	ArchiTotem_TotemData["ArchiTotemButton_Air3"].casted = nil
	
	ArchiTotem_TotemData["ArchiTotemButton_Air4"] = {}
	ArchiTotem_TotemData["ArchiTotemButton_Air4"].icon = "Interface\\Icons\\Spell_Nature_InvisibilityTotem"
	ArchiTotem_TotemData["ArchiTotemButton_Air4"].name = "Grace of Air Totem"
	ArchiTotem_TotemData["ArchiTotemButton_Air4"].duration = 120
	ArchiTotem_TotemData["ArchiTotemButton_Air4"].cooldown = 0
	ArchiTotem_TotemData["ArchiTotemButton_Air4"].cooldownstarted = nil
	ArchiTotem_TotemData["ArchiTotemButton_Air4"].casted = nil
	
	ArchiTotem_TotemData["ArchiTotemButton_Air5"] = {}
	ArchiTotem_TotemData["ArchiTotemButton_Air5"].icon = "Interface\\Icons\\Spell_Nature_NatureResistanceTotem"
	ArchiTotem_TotemData["ArchiTotemButton_Air5"].name = "Nature Resistance Totem"
	ArchiTotem_TotemData["ArchiTotemButton_Air5"].duration = 120
	ArchiTotem_TotemData["ArchiTotemButton_Air5"].cooldown = 0
	ArchiTotem_TotemData["ArchiTotemButton_Air5"].cooldownstarted = nil
	ArchiTotem_TotemData["ArchiTotemButton_Air5"].casted = nil
	
	ArchiTotem_TotemData["ArchiTotemButton_Air6"] = {}
	ArchiTotem_TotemData["ArchiTotemButton_Air6"].icon = "Interface\\Icons\\Spell_Nature_EarthBind"
	ArchiTotem_TotemData["ArchiTotemButton_Air6"].name = "Windwall Totem"
	ArchiTotem_TotemData["ArchiTotemButton_Air6"].duration = 120
	ArchiTotem_TotemData["ArchiTotemButton_Air6"].cooldown = 0
	ArchiTotem_TotemData["ArchiTotemButton_Air6"].cooldownstarted = nil
	ArchiTotem_TotemData["ArchiTotemButton_Air6"].casted = nil
	
	ArchiTotem_TotemData["ArchiTotemButton_Air7"] = {}
	ArchiTotem_TotemData["ArchiTotemButton_Air7"].icon = "Interface\\Icons\\Spell_Nature_RemoveCurse"
	ArchiTotem_TotemData["ArchiTotemButton_Air7"].name = "Sentry Totem"
	ArchiTotem_TotemData["ArchiTotemButton_Air7"].duration = 300
	ArchiTotem_TotemData["ArchiTotemButton_Air7"].cooldown = 0
	ArchiTotem_TotemData["ArchiTotemButton_Air7"].cooldownstarted = nil
	ArchiTotem_TotemData["ArchiTotemButton_Air7"].casted = nil
	
end

function ArchiTotem_Print(msg, type)
	local prefix
	if type == "error" then
		prefix = "|CFF20B2AA[ArchiTotem] |CFFFF0000[ERROR]|r  "
	elseif type == "debug" then
		prefix = "|CFF20B2AA[ArchiTotem] |CFF0000CD[DEBUG]|r  "
	else
		prefix = "|CFF20B2AA[ArchiTotem]|r  "
	end
	return DEFAULT_CHAT_FRAME:AddMessage(prefix..msg)
end

function ArchiTotem_Noop()
	return
end

function ArchiTotem_OnLoad()
	if class == "SHAMAN" then
		this:RegisterForDrag("RightButton")
		for _,popout in ipairs(ArchiTotemPopout) do
			_G[popout]:SetScript("OnDragStart", ArchiTotem_Noop)
			_G[popout]:SetScript("OnDragStop", ArchiTotem_Noop)
		end
		this:RegisterEvent("VARIABLES_LOADED")
		this:RegisterEvent("SPELLCAST_STOP")
		this:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
		this:RegisterEvent("CHAT_MSG_SPELL_FAILED_LOCALPLAYER")
		SLASH_ARCHITOTEM1 = "/architotem"
		SLASH_ARCHITOTEM2 = "/at"
		-- A shortcut or alias
		SlashCmdList["ARCHITOTEM"] = ArchiTotem_Command
		DEFAULT_CHAT_FRAME:AddMessage("|CFF20B2AAArchiTotem|r "..author.." "..L["ver."].." "..version.." "..L["loaded"]..".")
	else
		this:UnregisterAllEvents()
		ArchiTotemFrame:Hide()
	end
end

function ArchiTotem_UpdateCooldown(Buttonname, duration)
	if ArchiTotem_Options["Debug"] then ArchiTotem_Print("+++++" .. Buttonname .. "+++++", "debug") end
	local cooldown = _G[Buttonname .. "Cooldown"]
	if cooldown ~= nil then
		local start = GetTime()
		if duration == 0 then duration = 1.5 end
		local enable = 1
		CooldownFrame_SetTimer(cooldown, start, duration, enable)
		if ArchiTotem_Options["Debug"] then ArchiTotem_Print(start .. "-" .. duration .. "-" .. enable) end
		
	else
		if ArchiTotem_Options["Debug"] then ArchiTotem_Print("+++++" .. Buttonname .. " NOT FOUND") end
	end
end

function ArchiTotem_OnEvent(event)
	if event == "VARIABLES_LOADED" then
		ArchiTotem_ClearAllCooldowns()
		ArchiTotem_UpdateTextures()
		ArchiTotem_UpdateShown()
		ArchiTotem_SetDirection(ArchiTotem_Options["Apperance"].direction)
		ArchiTotem_SetScale(ArchiTotem_Options["Apperance"].scale)
		ArchiTotem_Order(ArchiTotem_Options["Order"].first, ArchiTotem_Options["Order"].second, ArchiTotem_Options["Order"].third, ArchiTotem_Options["Order"].forth)
	elseif event == "CHAT_MSG_SPELL_FAILED_LOCALPLAYER" then
		ArchiTotemCasted = 0
	elseif event == "SPELLCAST_STOP" then
		if ArchiTotemCasted == 1 then
			ArchiTotemActiveTotem[ArchiTotemCastedElement] = ArchiTotemCastedTotem
			ArchiTotemActiveTotem[ArchiTotemCastedElement].casted = GetTime()
			ArchiTotem_TotemData[ArchiTotemCastedButton].cooldownstarted = GetTime()
			
			ArchiTotem_UpdateAllCooldowns(ArchiTotemCastedButton)
			
			if ArchiTotem_Options["Apperance"].bottomoncast == true then
				local buttonNumber = tonumber(string.sub(ArchiTotemCastedButton, -1, -1))
				if buttonNumber > 1 then
					local topbutton, bottombutton
					for i = buttonNumber, 2, -1 do
						-- For all buttons of that element
						topbutton = string.sub(ArchiTotemCastedButton, 1, -2) .. i
						bottombutton = string.sub(ArchiTotemCastedButton, 1, -2) ..(i - 1)
						ArchiTotem_Switch(topbutton, bottombutton)
						if ArchiTotem_TotemData[topbutton].cooldownstarted == nil then
							local duration = 1.5
							CooldownFrame_SetTimer(_G[topbutton .. "Cooldown"], GetTime(), duration, 1)
						end
					end
					local duration = ArchiTotem_TotemData[bottombutton].cooldown
					if duration == 0 then duration = 1.5 end
					CooldownFrame_SetTimer(_G[bottombutton .. "Cooldown"], GetTime(), duration, 1)
				end
			end	
			ArchiTotemCasted = nil
			ArchiTotemCastedTotem = nil
			ArchiTotemCastedButton = nil
		end
	end
end

function ArchiTotem_OnDragStart()
	if IsControlKeyDown() then
		ArchiTotemFrame:StartMoving()
	end
end

function ArchiTotem_OnDragStop()
	ArchiTotemFrame:StopMovingOrSizing()
end

function ArchiTotem_OnEnter()
	-- When entering a button, show all totems of that element
	if ArchiTotem_Options["Apperance"].allonmouseover == true then
		for k, v in totemElements do
			-- For all the elements
			local threeLetterElement = string.sub(v, 1, 3)
			-- Get the 3 first letters of the element
			for i = 1, ArchiTotem_Options[threeLetterElement].max do
				-- For all buttons of that element
				_G["ArchiTotemButton_" .. v .. i]:Show()
			end
		end
	else
		local totemElement = string.sub(this:GetName(), 1, -2)
		-- ArchiTotemButton_Earth, ArchiTotemButton_Fire..
		local maxOfElement = string.sub(this:GetName(), 18, 20)
		-- Get the 3 first letters of the element: "Ear", "Fir"..
		for i = 2, ArchiTotem_Options[maxOfElement].max do
			-- For all buttons
			local button = _G[totemElement .. i]
			if button then
				button:Show()
				-- Show
			end
		end
	end
	
	-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	if ArchiTotem_Options["Apperance"].showtooltips == true then
		local tooltipspellID = ArchiTotem_GetSpellId(ArchiTotem_TotemData[this:GetName()].name)
		if tooltipspellID > 0 then
			local spellName = GetSpellName(tooltipspellID, BOOKTYPE_SPELL)
			GameTooltip_SetDefaultAnchor(GameTooltip, this)
			GameTooltip:SetSpell(tooltipspellID, SpellBookFrame.bookType)	
		end
	end
	-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
end

function ArchiTotem_GetSpellId(spell)
	local localizeSpell = L[spell]
	local spellID = 0
	for id = 1, 180 do
		local spellName = GetSpellName(id, BOOKTYPE_SPELL)
		if spellName and string.find(spellName, localizeSpell) then
			spellID = id
		end
	end
	return spellID
end

function ArchiTotem_OnLeave()
	-- When leaving a button, hide all totems that are to be hidden
	ArchiTotem_UpdateShown()
end

function ArchiTotem_OnClick()
	-- When clicking a button, you either want to move it up or down, or cast the totem
	if IsAltKeyDown() then
		local underTotemNumber = string.sub(this:GetName(), -1, -1) -1
		-- Number of the totem below the one you clicked
		local underTotem = string.sub(this:GetName(), 1, -2) .. underTotemNumber
		-- Earth1, Fire1..
		if underTotemNumber > 0 then
			-- If the totem you clicked isn't the bottom one
			ArchiTotem_Switch(this:GetName(), underTotem)
			-- Switch them (the clicked and the one below)
		end
		
	elseif IsControlKeyDown() then
		local overTotemNumber = string.sub(this:GetName(), -1, -1) + 1
		-- Number of the totem over the one you clicked
		local overTotem = string.sub(this:GetName(), 1, -2) .. overTotemNumber
		-- Earth3, Fire2..
		local maxOfElement = string.sub(this:GetName(), 18, 20)
		-- Get the 3 first letters of the element: "Ear", "Fir"..
		if overTotemNumber < ArchiTotem_Options[maxOfElement].max + 1 then
			-- If there is a totem over the one you clicked
			ArchiTotem_Switch(this:GetName(), overTotem)
			-- Switch them (the clicked and the one above)
		end
		
	else
		ArchiTotem_CastTotem()
	end
end

function ArchiTotem_CastTotem()
	ArchiTotemCasted = 1
	ArchiTotemCastedTotem = ArchiTotem_TotemData[this:GetName()]
	ArchiTotemCastedElement = string.sub(this:GetName(), 18, -2)
	ArchiTotemCastedButton = this:GetName()
	
	if ArchiTotemCastedTotem.casted == nil then ArchiTotemCastedTotem.casted = GetTime() - ArchiTotemCastedTotem.cooldown end
	local mincooldown = ArchiTotemCastedTotem.cooldown
	if mincooldown < 1.5 then mincooldown = 1.5 end
	local localizeSpell = L[ArchiTotem_TotemData[this:GetName()].name]
	CastSpellByName(localizeSpell)
	-- If control or alt isn't pressed, cast the totem
end

function ArchiTotem_Switch(arg1, arg2)
	-- Switch the data of two totems, then update the textures
	local temp = ArchiTotem_TotemData[arg1]
	ArchiTotem_TotemData[arg1] = ArchiTotem_TotemData[arg2]
	ArchiTotem_TotemData[arg2] = temp
	_G[arg1 .. "CooldownText"]:Hide()
	_G[arg1 .. "CooldownBg"]:Hide()
	_G[arg2 .. "CooldownText"]:Hide()
	_G[arg2 .. "CooldownBg"]:Hide()
	-- ArchiTotem_Print(ArchiTotem_GetSpellId(ArchiTotem_TotemData[arg1].name))
	if ArchiTotem_GetSpellId(ArchiTotem_TotemData[arg1].name) ~= 0 then
		local _, duration1 = GetSpellCooldown(ArchiTotem_GetSpellId(ArchiTotem_TotemData[arg1].name), BOOKTYPE_SPELL)
		CooldownFrame_SetTimer(_G[arg1 .. "Cooldown"], ArchiTotem_TotemData[arg1].casted, duration1, 1)
	end
	if ArchiTotem_GetSpellId(ArchiTotem_TotemData[arg2].name) ~= 0 then
		local _, duration2 = GetSpellCooldown(ArchiTotem_GetSpellId(ArchiTotem_TotemData[arg2].name), BOOKTYPE_SPELL)
		CooldownFrame_SetTimer(_G[arg2 .. "Cooldown"], ArchiTotem_TotemData[arg2].casted, duration2, 1)
	end
	ArchiTotem_UpdateTextures()
end

function ArchiTotem_ClearAllCooldowns()
	-- Clear all the cooldowns of the totems, or strange things may happen when loggin in
	for k, v in ArchiTotem_TotemData do
		v.cooldownstarted = nil
	end
end

function ArchiTotem_UpdateTextures()
	-- Set the textures of all buttons
	for k, v in totemElements do
		-- For all the elements
		local threeLetterElement = string.sub(v, 1, 3)
		-- Get the 3 first letters of the element
		for i = 1, ArchiTotem_Options[threeLetterElement].max do
			-- For all buttons of that element
			_G["ArchiTotemButton_" .. v .. i .. "Texture"]:SetTexture(ArchiTotem_TotemData["ArchiTotemButton_" .. v .. i].icon)
			-- Set the texture
		end
	end
end

function ArchiTotem_UpdateShown()
	-- Show buttons that should be shown, hide buttons that should be hidden
	for k, v in totemElements do
		-- For all the elements
		local threeLetterElement = string.sub(v, 1, 3)
		-- Get the 3 first letters of the element
		for i = 1, ArchiTotem_Options[threeLetterElement].max do
			-- For all buttons of that element
			if i <= ArchiTotem_Options[threeLetterElement].shown then
				_G["ArchiTotemButton_" .. v .. i]:Show()
			else
				_G["ArchiTotemButton_" .. v .. i]:Hide()
			end
		end
	end
end

function ArchiTotem_UpdateAllCooldowns()
	for k, v in ArchiTotem_TotemData do
		-- Handles the cooldowns of all totems
		if v.casted == nil then v.casted = GetTime() - v.cooldown end
		local duration = 1.5
		if GetTime() > (v.casted + v.cooldown) then
			if ArchiTotemCastedButton == k then duration = v.cooldown else duration = 1.5 end
			ArchiTotem_UpdateCooldown(k, duration)
		end
	end
end

function ArchiTotem_SetDirection(dir)
	-- Set the direction totems pop up when hovering, up or down
	ArchiTotem_Options["Apperance"].direction = dir
	-- Save the direction
	local anchor1, anchor2
	if dir == "down" then
		anchor1 = "TOPLEFT"
		anchor2 = "BOTTOMLEFT"
		EarthDurationText:SetPoint("CENTER", ArchiTotemButton_Earth1, "CENTER", 0, 26)
		FireDurationText:SetPoint("CENTER", ArchiTotemButton_Fire1, "CENTER", 0, 26)
		WaterDurationText:SetPoint("CENTER", ArchiTotemButton_Water1, "CENTER", 0, 26)
		AirDurationText:SetPoint("CENTER", ArchiTotemButton_Air1, "CENTER", 0, 26)
	elseif dir == "up" then
		anchor1 = "BOTTOMLEFT"
		anchor2 = "TOPLEFT"
		EarthDurationText:SetPoint("CENTER", ArchiTotemButton_Earth1, "CENTER", 0, -26)
		FireDurationText:SetPoint("CENTER", ArchiTotemButton_Fire1, "CENTER", 0, -26)
		WaterDurationText:SetPoint("CENTER", ArchiTotemButton_Water1, "CENTER", 0, -26)
		AirDurationText:SetPoint("CENTER", ArchiTotemButton_Air1, "CENTER", 0, -26)
	end
	for k, v in totemElements do
		-- For all the elements
		local threeLetterElement = string.sub(v, 1, 3)
		-- Get the 3 first letters of the element
		for i = 2, ArchiTotem_Options[threeLetterElement].max do
			-- For all buttons of that element
			local relativeTotem = _G["ArchiTotemButton_" .. v ..(i - 1)]
			-- The totem to be anchored to
			_G["ArchiTotemButton_" .. v .. i]:ClearAllPoints()
			-- Clear all anchors, or the buttons will be messed up
			_G["ArchiTotemButton_" .. v .. i]:SetPoint(anchor1, relativeTotem, anchor2)
			-- Set the anchor
		end
	end
end

function ArchiTotem_Order(first, second, third, forth)
	if first == nil or second == nil or third == nil or forth == nil then
		return ArchiTotem_Print(L["Elements must be written in english!"].." <Earth, Fire, Water, Air>", "error")
	end
	-- Set the order of the totems Earth Fire Water Air.
	local firstButton, secondButton, thirdButton, forthButton
	firstButton = "ArchiTotemButton_" .. strupper(string.sub(first, 1, 1)) .. string.sub(first, 2) .. "1"
	secondButton = "ArchiTotemButton_" .. strupper(string.sub(second, 1, 1)) .. string.sub(second, 2) .. "1"
	thirdButton = "ArchiTotemButton_" .. strupper(string.sub(third, 1, 1)) .. string.sub(third, 2) .. "1"
	forthButton = "ArchiTotemButton_" .. strupper(string.sub(forth, 1, 1)) .. string.sub(forth, 2) .. "1"
	ArchiTotem_Options["Order"].first = strupper(string.sub(first, 1, 1)) .. string.sub(first, 2)
	ArchiTotem_Options["Order"].second = strupper(string.sub(second, 1, 1)) .. string.sub(second, 2)
	ArchiTotem_Options["Order"].third = strupper(string.sub(third, 1, 1)) .. string.sub(third, 2)
	ArchiTotem_Options["Order"].forth = strupper(string.sub(forth, 1, 1)) .. string.sub(forth, 2)
	
	_G[firstButton]:ClearAllPoints()
	-- Clear all anchors, or the buttons will be messed up
	_G[firstButton]:SetPoint("CENTER", ArchiTotemFrame, "CENTER")
	-- Set the anchor
	
	_G[secondButton]:ClearAllPoints()
	-- Clear all anchors, or the buttons will be messed up
	_G[secondButton]:SetPoint("BOTTOMLEFT", firstButton, "BOTTOMRIGHT")
	-- Set the anchor
	
	_G[thirdButton]:ClearAllPoints()
	-- Clear all anchors, or the buttons will be messed up
	_G[thirdButton]:SetPoint("BOTTOMLEFT", secondButton, "BOTTOMRIGHT")
	-- Set the anchor
	
	_G[forthButton]:ClearAllPoints()
	-- Clear all anchors, or the buttons will be messed up
	_G[forthButton]:SetPoint("BOTTOMLEFT", thirdButton, "BOTTOMRIGHT")
	-- Set the anchor
end

function ArchiTotem_SetScale(scale)
	-- Sets the scale of the entire ArchiTotem frame
	ArchiTotem_Options["Apperance"].scale = scale
	-- Save the scale
	for k, v in totemElements do
		-- For all the elements
		local threeLetterElement = string.sub(v, 1, 3)
		-- Get the 3 first letters of the element
		for i = 1, ArchiTotem_Options[threeLetterElement].max do
			-- For all buttons of that element
			_G["ArchiTotemButton_" .. v .. i]:SetScale(scale)
			-- Set the scale
		end
	end
end

function ArchiTotem_OnUpdate(arg1)
	-- Called on the OnUpdate event, deals with the timers
	this.TimeSinceLastUpdate = this.TimeSinceLastUpdate + arg1
	
	if this.TimeSinceLastUpdate > CLOCK_UPDATE_RATE then
		for k, v in ArchiTotemActiveTotem do
			-- Handles the duration of the active totems
			if GetTime() >(v.casted + v.duration) then
				v = nil
				_G[k .. "DurationText"]:Hide()
			else
				local seconds = string.format("%.0f",(v.duration +(v.casted - GetTime())))
				local minutes = string.format("0%.0f",((seconds - mod(seconds, 60)) / 60))
				local seconds = mod(seconds, 60)
				_G[k .. "DurationText"]:Show()
				if seconds < 10 then seconds = string.format("0%.0f", seconds) else seconds = string.format("%.0f", seconds) end
				_G[k .. "DurationText"]:SetText(minutes .. ":" .. seconds)
			end
		end
		for k, v in ArchiTotem_TotemData do
			-- Handles the cooldowns of all totems
			if ArchiTotem_Options["Apperance"].shownumericcooldowns == true then
				if v.cooldownstarted == nil then
				else
					if GetTime() > (v.cooldownstarted + v.cooldown) then
						_G[k .. "CooldownText"]:Hide()
						_G[k .. "CooldownBg"]:Hide()
						v.cooldownstarted = nil
					else
						_G[k .. "CooldownBg"]:Show()
						_G[k .. "CooldownText"]:Show()
						local seconds = string.format("%.0f",(v.cooldown +(v.cooldownstarted - GetTime())))
						local minutes = string.format("%.0f",((seconds - mod(seconds, 60)) / 60))
						local seconds = mod(seconds, 60)
						if minutes ~= "0" then
							_G[k .. "CooldownText"]:SetText(minutes .. ":" .. seconds)
						else
							_G[k .. "CooldownText"]:SetText(seconds)
						end
					end
				end
			end
		end
		this.TimeSinceLastUpdate = 0
	end
end

function ArchiTotem_Command(cmd)
	-- /slash commands
	local command = string.lower(cmd)
	
	local i = 1
	local arg = {}
	local tmparg = nil
	for tmparg in string.gfind(command, "%w+") do
		arg[i] = tmparg
		i = i + 1
	end
	
	if arg[1] == "set" then
		-- /at set, how many totems an element will show with no mouseover
		if arg[2] == "earth" then
			if tonumber(arg[3]) > 0 and tonumber(arg[3]) <= 5 then
				ArchiTotem_Options["Ear"].shown = tonumber(arg[3])
				ArchiTotem_UpdateShown()
				ArchiTotem_Print(L["Earth totems shown: "] .. arg[3])
			end
		elseif arg[2] == "fire" then
			if tonumber(arg[3]) > 0 and tonumber(arg[3]) <= 5 then
				ArchiTotem_Options["Fir"].shown = tonumber(arg[3])
				ArchiTotem_UpdateShown()
				ArchiTotem_Print(L["Fire totems shown: "] .. arg[3])
			end
		elseif arg[2] == "water" then
			if tonumber(arg[3]) > 0 and tonumber(arg[3]) <= 6 then
				ArchiTotem_Options["Wat"].shown = tonumber(arg[3])
				ArchiTotem_UpdateShown()
				ArchiTotem_Print(L["Water totems shown: "] .. arg[3])
			end
		elseif arg[2] == "air" then
			if tonumber(arg[3]) > 0 and tonumber(arg[3]) <= 7 then
				ArchiTotem_Options["Air"].shown = tonumber(arg[3])
				ArchiTotem_UpdateShown()
				-- ////////////////////////////////////////////////////////////////////
				ArchiTotem_Print(L["Air totems shown: "] .. arg[3])
			end
		else
			ArchiTotem_Print(L["Elements must be written in english!"].." <Earth, Fire, Water, Air>", "error")
		end
	elseif arg[1] == "direction" then
		-- /at direction, which direction the totems should go on mouseover
		if arg[2] == "down" then
			ArchiTotem_SetDirection("down")
			ArchiTotem_Print(L["Direction set to: Down"])
		elseif arg[2] == "up" then
			ArchiTotem_SetDirection("up")
			ArchiTotem_Print(L["Direction set to: Up"])
		else
			ArchiTotem_Print(L["Direction must be down or up!"], "error")
		end
	elseif arg[1] == "order" then
		-- /at order, which order the totems have, left to right
		ArchiTotem_Order(arg[2], arg[3], arg[4], arg[5])
		if arg[2] and arg[3] and arg[4] and arg[5] then -- check english elements
			ArchiTotem_Print(L["Order set to: "] .. arg[2] .. ", " .. arg[3] .. ", " .. arg[4] .. ", " .. arg[5])
		end
	elseif arg[1] == "scale" then
		-- /at scale, what scale the frame has
		if not arg[2] then
			return ArchiTotem_Print(L["Specify scale"], "error")
		elseif type(tonumber(arg[2])) ~= "number" then
			return ArchiTotem_Print(L["Scale must be a number!"], "error")
		end
		if arg[3] then
			ArchiTotem_SetScale(arg[2] .. "." .. arg[3])
			ArchiTotem_Print(L["Scale set to: "] .. arg[2] .. "." .. arg[3])
		else
			ArchiTotem_SetScale(arg[2])
			ArchiTotem_Print(L["Scale set to: "] .. arg[2])
		end
	elseif arg[1] == "showall" then
		-- /at showall, toggle showing of all totems on mouseover
		if ArchiTotem_Options["Apperance"].allonmouseover == false then
			ArchiTotem_Options["Apperance"].allonmouseover = true
			ArchiTotem_Print(L["Showing all totems on mouseover"])
		else
			ArchiTotem_Options["Apperance"].allonmouseover = false
			ArchiTotem_Print(L["Showing only one element on mouseover"])
		end
	elseif arg[1] == "bottomcast" then
		if ArchiTotem_Options["Apperance"].bottomoncast == false then
			ArchiTotem_Options["Apperance"].bottomoncast = true
			ArchiTotem_Print(L["Totems will move the the bottom line when cast"])
		else
			ArchiTotem_Options["Apperance"].bottomoncast = false
			ArchiTotem_Print(L["Totems will stay where they are when cast"])
		end
	elseif arg[1] == "timers" then
		if ArchiTotem_Options["Apperance"].shownumericcooldowns == false then
			ArchiTotem_Options["Apperance"].shownumericcooldowns = true
			ArchiTotem_Print(L["Timers are now turned on"])
		else
			ArchiTotem_Options["Apperance"].shownumericcooldowns = false
			ArchiTotem_Print(L["Timers are now turned off"])
			for k, v in ArchiTotem_TotemData do
				_G[k .. "CooldownText"]:Hide()
				_G[k .. "CooldownBg"]:Hide()
				v.cooldownstarted = nil
			end
			for k, v in ArchiTotemActiveTotem do
				_G[k .. "DurationText"]:Hide()
			end
		end
	elseif arg[1] == "tooltip" then
		if ArchiTotem_Options["Apperance"].showtooltips == false then
			ArchiTotem_Options["Apperance"].showtooltips = true
			ArchiTotem_Print(L["Tooltips are now turned on"])
		else
			ArchiTotem_Options["Apperance"].showtooltips = false
			ArchiTotem_Print(L["Tooltips are now turned off"])
		end
	elseif arg[1] == "debug" then
		if ArchiTotem_Options["Debug"] == false then
			ArchiTotem_Options["Debug"] = true
			ArchiTotem_Print(L["Debuging are now turned on"])
		else
			ArchiTotem_Options["Debug"] = false
			ArchiTotem_Print(L["Debuging are now turned off"])
		end
	elseif arg[1] == nil then
		ArchiTotem_Print(L["Available commands:"])
		ArchiTotem_Print(L["/at set <earth/fire/water/air> # - Sets the totems shown of that element to #."])
		ArchiTotem_Print(L["/at direction <up/down> - Set the direction totems pop up."])
		ArchiTotem_Print(L["/at order <element 1, element 2, element 3, element 4> - Sets the order of the totems, from left to right."])
		ArchiTotem_Print(L["/at scale # - Sets the scale of ArchiTotem, default is 1."])
		ArchiTotem_Print(L["/at showall - Toggles show all mode, displaying all totems on mouseover."])
		ArchiTotem_Print(L["/at bottomcast - Toggles moving totems to the bottom line when cast"])
		ArchiTotem_Print(L["/at timers - Toggles showing timers"])
		ArchiTotem_Print(L["/at tooltip - Toggles showing tooltips"])
		ArchiTotem_Print(L["/at debug - Toggles debuging"])
		DEFAULT_CHAT_FRAME:AddMessage("\n")
		ArchiTotem_Print(L["Moving the bar:"])
		ArchiTotem_Print(L["Ctrl-RightClick and Drag any of the main buttons"])
		ArchiTotem_Print(L["Ordering totems of same element:"])
		ArchiTotem_Print(L["Ctrl-LeftClick any of the buttons"])
	else
		ArchiTotem_Print(L["Unavailable command. Type /at for help."], "error")		
	end
end