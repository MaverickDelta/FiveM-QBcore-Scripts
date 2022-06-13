local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('forkliftJob:pay', function(source, pay)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	
	xPlayer.Functions.AddMoney('cash', tonumber(pay))
end)
