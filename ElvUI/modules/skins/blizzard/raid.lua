local E, L, P, G = unpack(select(2, ...)); --Inport: Engine, Locales, ProfileDB, GlobalDB
local S = E:GetModule('Skins')

local function LoadSkin()
	if E.global.skins.blizzard.enable ~= true or E.global.skins.blizzard.raid ~= true then return end
	local buttons = {
		"RaidFrameRaidInfoButton",
		"RaidFrameReadyCheckButton",
	}

	for i = 1, #buttons do
		S:HandleButton(_G[buttons[i]])
	end

	local StripAllTextures = {
		"RaidGroup1",
		"RaidGroup2",
		"RaidGroup3",
		"RaidGroup4",
		"RaidGroup5",
		"RaidGroup6",
		"RaidGroup7",
		"RaidGroup8",
	}

	for _, object in pairs(StripAllTextures) do
		if not _G[object] then print(object) end
		
		if _G[object] then
			_G[object]:StripTextures()
		end
	end

	for i=1, MAX_RAID_GROUPS*5 do
		S:HandleButton(_G["RaidGroupButton"..i], true)
	end

	for i=1,8 do
		for j=1,5 do
			_G["RaidGroup"..i.."Slot"..j]:StripTextures()
			_G["RaidGroup"..i.."Slot"..j]:SetTemplate("Transparent")
		end
	end
end

S:RegisterSkin("Blizzard_RaidUI", LoadSkin)