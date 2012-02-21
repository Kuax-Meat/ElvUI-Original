local E, L, P, G = unpack(select(2, ...)); --Inport: Engine, Locales, ProfileDB, GlobalDB
local CH = E:GetModule('Chat')

E.Options.args.chat = {
	type = "group",
	name = L["Chat"],
	get = function(info) return E.db.chat[ info[#info] ] end,
	set = function(info, value) E.db.chat[ info[#info] ] = value end,
	args = {
		intro = {
			order = 1,
			type = "description",
			name = L["CHAT_DESC"],
		},		
		enable = {
			order = 2,
			type = "toggle",
			name = L["Enable"],
			get = function(info) return E.global.chat.enable end,
			set = function(info, value) E.global.chat.enable = value; StaticPopup_Show("GLOBAL_RL") end
		},				
		general = {
			order = 3,
			type = "group",
			name = L["General"],
			guiInline = true,
			args = {	
				url = {
					order = 1,
					type = 'toggle',
					name = L['URL Links'],
					desc = L['Attempt to create URL links inside the chat.'],
				},
				shortChannels = {
					order = 2,
					type = 'toggle',
					name = L['Short Channels'],
					desc = L['Shorten the channel names in chat.'],
				},				
			},
		},
	},
}