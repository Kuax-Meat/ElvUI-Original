local E, L, P, G = unpack(select(2, ...)); --Inport: Engine, Locales, ProfileDB, GlobalDB
local DT = E:GetModule('DataTexts')

--[[This file is a blank datatext example template, this file will not be loaded.]]

local function Update(self, t)

end

local function OnEvent(self, event, ...)

end

local function Click()

end

local function OnEnter(self)
	DT:SetupTooltip(self)

	GameTooltip:Show()
end

--[[
	DT:RegisterDatatext(name, events, eventFunc, updateFunc, clickFunc, onEnterFunc, onLeaveFunc)
	
	name - name of the datatext (required)
	events - must be a table with string values of event names to register 
	eventFunc - function that gets fired when an event gets triggered
	updateFunc - onUpdate script target function
	click - function to fire when clicking the datatext
	onEnterFunc - function to fire OnEnter
	onLeaveFunc - function to fire OnLeave, if not provided one will be set for you that hides the tooltip.
]]
DT:RegisterDatatext('DTName', {'PLAYER_ENTERING_WORLD'}, OnEvent, Update, Click, OnEnter)

