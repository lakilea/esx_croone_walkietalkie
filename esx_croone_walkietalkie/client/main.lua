ESX             = nil
WalkieOpened    = false
HasLspdWalkie   = false
HasEmsWalkie    = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(0, Config.TurnOnOffKey) then
            hasLspdWalkieTalkie(function (haswalkie)
                HasLspdWalkie = haswalkie
            end)

            hasEmsWalkieTalkie(function (haswalkie)
                HasEmsWalkie = haswalkie
            end)

            ToggleWalkies()
        end
    end
end)

function ToggleWalkies()
    WalkieOpened = not WalkieOpened

    if WalkieOpened then
        if HasLspdWalkie then
            exports.tokovoip_script:addPlayerToRadio(Config.PoliceChannel)
        end

        if HasEmsWalkie then
            exports.tokovoip_script:addPlayerToRadio(Config.EMSChannel)
        end
    else
        exports.tokovoip_script:removePlayerFromRadio(Config.PoliceChannel)
		exports.tokovoip_script:removePlayerFromRadio(Config.EMSChannel)
    end
end

function hasLspdWalkieTalkie(cb)
    ESX.TriggerServerCallback('croone_walkietalkie:getItemAmount', function(qtty)
        cb(qtty > 0)
    end, 'walkie_lspd')
end

function hasEmsWalkieTalkie(cb)
    ESX.TriggerServerCallback('croone_walkietalkie:getItemAmount', function(qtty)
        cb(qtty > 0)
    end, 'walkie_ems')
end

function ShowNoWalkieWarning()
    if (ESX == nil) then return end
    ESX.ShowNotification(_U('no_item'))
end