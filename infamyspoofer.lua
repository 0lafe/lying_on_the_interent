local send_after_load_orig = NetworkPeer.send_after_load
function NetworkPeer:send_after_load(type, level, rank, ...)
    if type == "sync_profile" or type == "lobby_info" then
        if Spoofer:infamy_enabled() then
            return send_after_load_orig(self, type, Spoofer:level(), Spoofer:infamy(), ...)
        else
            return send_after_load_orig(self, type, level, rank, ...)
        end
    end

    return send_after_load_orig(self, type, level, rank, ...)
end
