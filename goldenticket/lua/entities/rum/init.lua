AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
util.AddNetworkString("Clienteffekte")

function ENT:Initialize() -- Funktion, wenn Entity gespawnt wird
    self:SetModel("models/props_junk/glassjug01.mdl")
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
    ply:ScreenFade(SCREENFADE.IN, Color(196, 84, 33, 39), 10, 30)

    if ply:Health() + rum_healthboost > 100  then -- Wenn die aktuelle Gesundheit + Healthboost größer als 100 ist, dann soll nur auf 100 gesetzt werden
        ply:SetHealth(100)
    else -- Sonst (wenn es nicht über 100 geht) soll Healthboost hinzuaddiert werden
        ply:SetHealth(ply:Health() + rum_healthboost)
    end

    ply:SetRunSpeed(ply:GetRunSpeed() * rum_speedfaktor)
    ply:SetWalkSpeed(ply:GetWalkSpeed() * rum_speedfaktor)

    timer.Simple(60, function()
        ply:SetRunSpeed(240) -- Standard DarkRP-Runspeed
        ply:SetWalkSpeed(160) -- Standard DarkRP-Walkspeed
    end)

    net.Start("Clienteffekte") -- Networking, um Clientseitige Effekte zu triggern
    net.Send(ply)

end