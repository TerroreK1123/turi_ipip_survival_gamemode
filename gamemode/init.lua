AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("hud.lua")
AddCSLuaFile("menu.lua")

include("shared.lua")
include("concommands.lua")

local open = false

DeriveGamemode("sandbox")
local clock = os.clock

concommand.Add("eco_addmoney", addmoney)

function addmoney(ply, money)

	ply:SetNWInt("playerMoney", ply:GetNWInt("playerMoney") + money)

end

function sleep(n)  -- seconds
  local t0 = clock()
  while clock() - t0 <= n do end
end

function GM:PlayerInitialSpawn(ply)
	
	if (ply:GetPData("playerMoney") == nil) then
		ply:SetNWInt("playerMoney", 50)
	else
		ply:SetNWInt("playerMoney", tonumber(ply:GetPData("playerMoney")))
	end

end

function GM:Initialize()
end

function GM:PlayerSpawn(ply)

	ply:SetMaxHealth(50)
	ply:StripWeapons()
	ply:Give("ohandsswep")
	ply:Give("weapon_physgun")
	ply:SetupHands()

end

function GM:OnNPCKilled(npc, attacker, inflictor)
	attacker:SetNWInt("playerMoney", attacker:GetNWInt("playerMoney") + 100)
end

function GM:PlayerDeath(victim, inflictor, attacker)

end

util.AddNetworkString("FMenu")

function GM:ShowSpare2(ply)

	if (open == false) then
		open = true
	else
		open = false
	end
	net.Start("FMenu")
	net.WriteBit(open)
	net.Broadcast()

end

function GM:PlayerDisconnected(ply)
	ply:SetPData("playerMoney", ply:GetNWInt("playerMoney"))
end

function GM:ShutDown()
	for k, v in pairs(player.GetAll()) do
		v:SetPData("playerMoney", v:GetNWInt("playerMoney"))
	end
end
