AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
util.AddNetworkString("Clienteffekte")

function ENT:Initialize() -- Funktion, wenn Entity gespawnt wird
    self:SetModel("models/props_bar/bottle_02c.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:AddEffects(EF_ITEM_BLINK)
    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake() -- setzt die Physics des Entitys ein
    end
end

function ENT:Use(act, ply)
    self:EmitSound("npc/barnacle/barnacle_gulp2.wav")
    self:Remove()
    ply:ScreenFade(SCREENFADE.IN, Color(132, 241, 255, 44), 10, 30)

    if ply:Health() + gin_healthboost > 100  then -- Wenn die aktuelle Gesundheit + Healthboost größer als 100 ist, dann soll nur auf 100 gesetzt werden
        ply:SetHealth(100)
    else -- Sonst (wenn es nicht über 100 geht) soll Healthboost hinzuaddiert werden
        ply:SetHealth(ply:Health() + gin_healthboost)
    end

    ply:SetRunSpeed(ply:GetRunSpeed() * gin_speedfaktor)
    ply:SetWalkSpeed(ply:GetWalkSpeed() * gin_speedfaktor)

    timer.Simple(60, function()
        ply:SetRunSpeed(240) -- Standard DarkRP-Runspeed
        ply:SetWalkSpeed(160) -- Standard DarkRP-Walkspeed
    end)


--[[     ply:CreateRagdoll()
    waffen = ply:GetWeapons()
    ply:StripWeapons()
    --ply:Freeze(true)
    Ragdoll = ply:GetRagdollEntity()
    ply:SpectateEntity(Ragdoll)
    timer.Simple(3, function()
    ply:Freeze(false)
    end)
    for k, v in ipairs (waffen) do
    ply:Give(waffen)
    end ]]

    net.Start("Clienteffekte") -- Networking, um Clientseitige Effekte zu triggern
    net.Send(ply)
end
