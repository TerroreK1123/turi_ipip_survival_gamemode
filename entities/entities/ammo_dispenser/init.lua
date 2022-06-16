AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")


function ENT:Initialize()
    self:SetModel(self.Model)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    self:SetUseType(SIMPLE_USE)

    local phys = self:GetPhysicsObject()

    if (IsValid(phys)) then
        phys:Wake()
    end

    self:SetHealth(self.BaseHealth)
end

function ENT:SpawnFunction(ply, tr, turi_ammodispenser)
    if (!tr.Hit) then return end

    local entCount = ply:GetNWInt(turi_ammodispenser .. "count")

    if (entCount < self.Limit) then
        local spawnPos = ply:GetShootPos() + ply:GetForward() * 80
        local ent = ents.Create(turi_ammodispenser)

        self.Owner = ply

        ent:SetPos(spawnPos)
        ent:Spawn()
        ent:Activate()

        ply:SetNWInt(turi_ammodispenser .. "count", entCount + 1)

        return ent
    end

    return
end

function ENT:Use(activator, caller)
    local ammoType = activator:GetActiveWeapon():GetPrimaryAmmoType()
    local selfPos = self:GetPos()
    local health = self:Health()
    local giveAmmo = math.random(3, math.random(30, 50))
    

    activator:GiveAmmo((giveAmmo), ammoType, false)
    sound.Play("buttons/button1.wav", selfPos, 75, 100, 20)
end


function ENT:Think()

end

function ENT:OnTakeDamage(damage)
    local selfPos = self:GetPos()

    self:SetHealth(self:Health() - damage:GetDamage())

    local sparkSoundRandom = math.random(1, 6)

    if (sparkSoundRandom == 1) then
        sound.Play("ambient/energy/spark1.wav", selfPos, 75, 100, 20)
    end

    if (sparkSoundRandom == 2) then
        sound.Play("ambient/energy/spark2.wav", selfPos, 75, 100, 20)
    end

    if (sparkSoundRandom == 3) then
        sound.Play("ambient/energy/spark3.wav", selfPos, 75, 100, 20)
    end

    if (sparkSoundRandom == 4) then
        sound.Play("ambient/energy/spark4.wav", selfPos, 75, 100, 20)
    end

    if (sparkSoundRandom == 5) then
        sound.Play("ambient/energy/spark5.wav", selfPos, 75, 100, 20)
    end

    if (sparkSoundRandom == 6) then
        sound.Play("ambient/energy/spark6.wav", selfPos, 75, 100, 20)
    end

    if (self:Health() <= 0) then
        self:Remove()
    end

end

function ENT:OnRemove()
    local Owner = self.Owner
    local className = self:GetClass()

if (Owner:IsValid()) then
    if (Owner:GetNWInt(ClassName.."count") > 0) then
            Owner:SetNWInt(className .. "count", Owner:GetNWInt(className .. "count") - 1)
        end
    end
end

