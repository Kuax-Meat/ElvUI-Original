local E, L, P, G = unpack(select(2, ...)); --Inport: Engine, Locales, ProfileDB, GlobalDB
local B = E:GetModule('Bags');

local TOTAL_BAGS = NUM_BAG_FRAMES + 1

local function OnEnter()
	if E.db.bags.bagBar.mouseover ~= true then return; end
	UIFrameFadeIn(ElvUIBags, 0.2, ElvUIBags:GetAlpha(), 1)
end

local function OnLeave()
	if E.db.bags.bagBar.mouseover ~= true then return; end
	UIFrameFadeOut(ElvUIBags, 0.2, ElvUIBags:GetAlpha(), 0)
end

function B:SkinBag(bag)
	local icon = _G[bag:GetName().."IconTexture"]
	bag.oldTex = icon:GetTexture()
	
	bag:StripTextures()
	bag:SetTemplate("Default", true)
	bag:StyleButton(true)
	icon:SetTexture(bag.oldTex)
	icon:ClearAllPoints()
	icon:Point("TOPLEFT", 2, -2)
	icon:Point("BOTTOMRIGHT", -2, 2)
	icon:SetTexCoord(.08, .92, .08, .92)
end

function B:SizeAndPositionBagBar()
	if E.global.bags.bagBar.enable ~= true or not ElvUIBags then return; end
	if E.db.bags.bagBar.mouseover then
		ElvUIBags:SetAlpha(0)
	else
		ElvUIBags:SetAlpha(1)
	end
	
	if E.db.bags.bagBar.showBackdrop then
		ElvUIBags.backdrop:Show()
	else
		ElvUIBags.backdrop:Hide()
	end
	
	for i=1, #ElvUIBags.buttons do
		local button = ElvUIBags.buttons[i]
		local prevButton = ElvUIBags.buttons[i-1]
		button:Size(E.db.bags.bagBar.size)
		button:ClearAllPoints()
		if E.db.bags.bagBar.growthDirection == 'HORIZONTAL' and E.db.bags.bagBar.sortDirection == 'ASCENDING' then
			if i == 1 then
				button:SetPoint('LEFT', ElvUIBags, 'LEFT', E.db.bags.bagBar.spacing, 0)
			elseif prevButton then
				button:SetPoint('LEFT', prevButton, 'RIGHT', E.db.bags.bagBar.spacing, 0)
			end
		elseif E.db.bags.bagBar.growthDirection == 'VERTICAL' and E.db.bags.bagBar.sortDirection == 'ASCENDING' then
			if i == 1 then
				button:SetPoint('TOP', ElvUIBags, 'TOP', 0, -E.db.bags.bagBar.spacing)
			elseif prevButton then
				button:SetPoint('TOP', prevButton, 'BOTTOM', 0, -E.db.bags.bagBar.spacing)
			end		
		elseif E.db.bags.bagBar.growthDirection == 'HORIZONTAL' and E.db.bags.bagBar.sortDirection == 'DESCENDING' then	
			if i == 1 then
				button:SetPoint('RIGHT', ElvUIBags, 'RIGHT', -E.db.bags.bagBar.spacing, 0)
			elseif prevButton then
				button:SetPoint('RIGHT', prevButton, 'LEFT', -E.db.bags.bagBar.spacing, 0)
			end		
		else
			if i == 1 then
				button:SetPoint('BOTTOM', ElvUIBags, 'BOTTOM', 0, E.db.bags.bagBar.spacing)
			elseif prevButton then
				button:SetPoint('BOTTOM', prevButton, 'TOP', 0, E.db.bags.bagBar.spacing)
			end			
		end
	end
	
	if E.db.bags.bagBar.growthDirection == 'HORIZONTAL' then
		ElvUIBags:Width(E.db.bags.bagBar.size*(TOTAL_BAGS) + E.db.bags.bagBar.spacing*(TOTAL_BAGS) + E.db.bags.bagBar.spacing)
		ElvUIBags:Height(E.db.bags.bagBar.size + E.db.bags.bagBar.spacing*2)	
	else
		ElvUIBags:Height(E.db.bags.bagBar.size*(TOTAL_BAGS) + E.db.bags.bagBar.spacing*(TOTAL_BAGS) + E.db.bags.bagBar.spacing)
		ElvUIBags:Width(E.db.bags.bagBar.size + E.db.bags.bagBar.spacing*2)		
	end
end

function B:LoadBagBar()
	if E.global.bags.bagBar.enable ~= true then return; end

	local ElvUIBags = CreateFrame("Frame", "ElvUIBags", E.UIParent)
	ElvUIBags:SetPoint('TOPLEFT', LeftChatPanel, 'TOPRIGHT', 4)
	ElvUIBags.buttons = {};
	ElvUIBags:CreateBackdrop()
	ElvUIBags.backdrop:SetAllPoints()
	ElvUIBags:EnableMouse(true)
	ElvUIBags:SetScript("OnEnter", OnEnter)
	ElvUIBags:SetScript("OnLeave", OnLeave)

	MainMenuBarBackpackButton:SetParent(ElvUIBags)
	MainMenuBarBackpackButton.SetParent = E.dummy
	MainMenuBarBackpackButton:ClearAllPoints()	
	MainMenuBarBackpackButtonCount:FontTemplate(nil, 10)
	MainMenuBarBackpackButtonCount:ClearAllPoints()
	MainMenuBarBackpackButtonCount:Point("BOTTOMRIGHT", MainMenuBarBackpackButton, "BOTTOMRIGHT", -1, 4)
	MainMenuBarBackpackButton:HookScript('OnEnter', OnEnter)
	MainMenuBarBackpackButton:HookScript('OnLeave', OnLeave)
		
	table.insert(ElvUIBags.buttons, MainMenuBarBackpackButton)
	self:SkinBag(MainMenuBarBackpackButton)

	for i=0, NUM_BAG_FRAMES-1 do
		local b = _G["CharacterBag"..i.."Slot"]
		b:SetParent(ElvUIBags)
		b.SetParent = E.dummy
		b:HookScript('OnEnter', OnEnter)
		b:HookScript('OnLeave', OnLeave)
		
		self:SkinBag(b)
		table.insert(ElvUIBags.buttons, b)
	end
	
	self:SizeAndPositionBagBar()
	E:CreateMover(ElvUIBags, 'BagsMover', 'Bags')
end