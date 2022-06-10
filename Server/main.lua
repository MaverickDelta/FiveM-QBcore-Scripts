local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('rentBike:pay', function(price, location, source)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local amount = math.floor(price + 0.5)

	if price > 0 then
		xPlayer.Functions.RemoveMoney('cash', amount)
        TriggerClientEvent('spawnRentedBike', source, location)
	end
end)

RegisterNetEvent('rentBike:refund', function(source)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	
	xPlayer.Functions.AddMoney('cash', tonumber(Config.returnPrice))
end)