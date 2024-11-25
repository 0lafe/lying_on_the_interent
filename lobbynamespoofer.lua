-- Use spoofing name for lobby name
function NetworkMatchMakingEPIC:username()
  if Spoofer:name_enabled() then
    return Spoofer:base_name()
  else
    return EpicMM:username()
  end
end
