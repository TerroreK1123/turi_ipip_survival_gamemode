function buyEntity(ply, cmd, args)
    if (args[1] != nil) then
        local ent = ents.Create(args[1])
        local tr = ply:GetEyeTrace()
        local balance = ply:GetNWInt("playerMoney")
        if (ent:IsValid()) then
            local ClassName = ent:GetClass()
            

        if (!tr.Hit) then return end

            local entCount = ply:GetNWInt(ClassName .. "count")

        if (entCount < ent.Limit && balance >= ent.Cost) then
            local spawnPos = ply:GetShootPos() + ply:GetForward() * 80

            ent.Owner = ply

            ent:SetPos(spawnPos)
            ent:Spawn()
            ent:Activate()
            
            ply:SetNWInt("playerMoney", ply:GetNWInt("playerMoney") - ent.Cost)
            ply:SetNWInt(ClassName .. "count", entCount + 1)

            return ent
        end

            return
        end
    end
end
concommand.Add("buy_entity", buyEntity)

function buyGun(ply, cmd, args)
    
    if (args[1] != nil && args[2] != nil) then

        local balance = ply:GetNWInt("playerMoney")
        local gunCost = tonumber(args[2])

        if (balance >= gunCost) then
            ply:SetNWInt("playerMoney", balance - gunCost)
            ply:Give(args[1])
            ply:GiveAmmo(20, ply:GetWeapon(args[1]):GetPrimaryAmmoType(), false)
        end
    end
end
concommand.Add("buy_gun", buyGun)