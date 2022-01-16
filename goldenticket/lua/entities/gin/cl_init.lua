include("shared.lua")

ply = LocalPlayer()

farbeffekte = {
    ["$pp_colour_addr"] = 0.01,
    ["$pp_colour_addg"] = 0,
    ["$pp_colour_addb"] = 0,
    ["$pp_colour_brightness"] = 0,
    ["$pp_colour_contrast"] = 1.05,
    ["$pp_colour_colour"] = 2,
    ["$pp_colour_mulr"] = 0,
    ["$pp_colour_mulg"] = 0,
    ["$pp_colour_mulb"] = 0
}

function ENT:Draw()
    self:DrawModel()
end

net.Receive("Clienteffekte", function(len)

    hook.Add("RenderScreenspaceEffects", "MotionBlur", function()

        DrawMotionBlur(0.1, 1, 0.01)
        DrawSobel(0.08)
        DrawColorModify(farbeffekte)
        DrawToyTown(10, ScrH() / 2) -- Verschwemmen vom Screen um die Mitte herum

        --[[ timer.Simple(40, function() -- nach 40 Sekunden soll die DrawSobel-Variabel jede sekunde um 0.1 bis 1 erhöht werden, um einen "Erholungseffekt" zu bekommen
            DS = 0.05
            while DS < 1 do
            DrawSobel(DS)
            timer.Simple(1, function()
            DS = DS + 0.1
            end)
            end
        end) ]]

        timer.Simple(51, function()
            hook.Remove("RenderScreenspaceEffects", "MotionBlur")
        end)
    end)
end)