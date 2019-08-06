ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('croone_walkietalkie:getItemAmount', function(source, cb, item)

    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer ~= nil then
    
        local items = xPlayer.getInventoryItem(item)

        if items == nil or items.count == 0 then
            cb(0)
        else
            cb(items.count)
        end
        
    end
end)