-- Use spoofing name for lobby name
function NetworkMatchMakingEPIC:username()
  if Spoofer:lobby_name_enabled() then
    return Spoofer:lobby_name()
  elseif Spoofer:name_enabled() then
    return Spoofer:name()
  else
    return EpicMM:username()
  end
end
