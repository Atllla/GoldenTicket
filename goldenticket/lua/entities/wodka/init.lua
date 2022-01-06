AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
util.AddNetworkString("Clienteffekte")

function ENT:Initialize() -- Funktion, wenn Entity gespawnt wird
    self:SetModel("models/props_junk/GlassBottle01a.mdl")
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
    ply:ScreenFade(SCREENFADE.IN, Color(165, 106, 106, 73), 10, 30)
    --ply:CreateRagdoll()
    --ply:Freeze(true)
    --Ragdoll = ply:GetRagdollEntity()
    --ply:SpectateEntity(Ragdoll)
    --timer.Simple(3, function()
    --ply:Freeze(false)
    --end)

    net.Start("Clienteffekte") -- Networking, um Clientseitige Effekte zu triggern
    net.Send(ply)

--fadmin!!!
end
--ply:SetColor(Color(211,211,211))
--ply:AddEffects(EF_ITEM_BLINK)