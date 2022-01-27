util.AddNetworkString("Kaufen")


concommand.Add("geld", function(ply)
    ply:addMoney(100)
end)

concommand.Add("getwalkspeed", function(ply)
    print(ply:GetWalkSpeed())
end)

concommand.Add("getrunspeed", function(ply)
    print(ply:GetRunSpeed())
end)

concommand.Add("respawn", function(ply)
    ply:Spawn()
end)

concommand.Add("broke", function(ply)
    ply:addMoney(-100)
end)

net.Receive("Kaufen", function(len, ply)
    local index = net.ReadInt(5)
    local auswahl = AlkAuswahl.Items[index]

    if (ply:canAfford(auswahl.preis)) then
        ply:addMoney(-auswahl.preis)
        function AlkSpawn()
        entity = ents.Create(auswahl.ent) -- als "entity" wird im Folgenden das Spawnen des Entities bezeichnet || die Entityfiles müssen nicht included werden!!!
        spawnpunkt = ply:GetEyeTrace() -- "spawnpunkt" ist dort, wo der Spieler hinschaut
        entity:Spawn()
        entity:SetPos(spawnpunkt.HitPos + Vector(0, 0, 10)) -- Das Spawnen des Entities soll 10 Units über dem Punkt sein, wo der Spieler hinschaut
       end

       AlkSpawn()
    end
end)