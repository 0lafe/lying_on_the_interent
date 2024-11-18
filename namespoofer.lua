local _delay = 0
function fake_name(t)
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

local _orig = MenuManager.update
function MenuManager:update(t, dt)
	_orig(self, t, dt)

	if Spoofer:name_enabled() then
		fake_name(t)
	end
end
