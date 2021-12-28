util.AddNetworkString("Kaufen")

concommand.Add("geld", function(ply)
    ply:addMoney(100)
end)

concommand.Add("broke", function(ply)
    ply:addMoney(-100)
end)

net.Receive("Kaufen", function(len, ply)

    local index = net.ReadInt(5)
    local auswahl = AlkAuswahl.Items[index]
    print(auswahl.name)

    if (ply:canAfford(auswahl.preis)) then                  --WENN BEDINGUNG WAHR
        ply:addMoney(-auswahl.preis)

       --[[ function AlkSpawn()
        include("entities/alk/init.lua")
        ENT:Spawn()
       end ]]

    else                                                    --WENN BEDINGUNG NICHT WAHR
        ply:ChatPrint("Du kannst dir " .. auswahl.name .. " nicht leisten.")
    end

end)



