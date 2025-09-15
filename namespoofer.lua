local _delay = 0
local _crimenet_delay = 0

local function fake_name(t)
	if not _delay or t - _delay > Spoofer:delay() then -- every .3 seconds
		_delay = t

		if managers.network:session() and managers.network:session():local_peer() then
			-- fake your local name
			managers.network:session():local_peer():set_name(Spoofer:name())
			for _, peer in pairs(managers.network:session():peers()) do
				peer:send("request_player_name_reply", Spoofer:name()) -- sync the fake name to other players
			end
		end
	end
end

local function lobby_name(t)
	if Network:is_server() and (not _crimenet_delay or t - _crimenet_delay > 5) then
		_crimenet_delay = t

		local existing_data = managers.network.matchmake:get_lobby_data()

		existing_data.owner_name = Spoofer:lobby_name()

		if Spoofer._name_values.animate_lobby_position then
			existing_data.state = "0"
			Spoofer._name_values.animate_lobby_position = false
		else
			existing_data.state = "1"
			Spoofer._name_values.animate_lobby_position = true
		end

		managers.network.matchmake.lobby_handler:set_lobby_data(existing_data)
	end
end

local _orig = MenuManager.update
function MenuManager:update(t, dt)
	_orig(self, t, dt)

	if Spoofer:name_enabled() then
		fake_name(t)
	end

	if Spoofer:lobby_name_enabled() then
		lobby_name(t)
	end
end
