include("shared.lua")

farbeffekte = {
    ["$pp_colour_addr"] = 0.02,
    ["$pp_colour_addg"] = 0,
    ["$pp_colour_addb"] = 0.01,
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
        DrawSobel(0.4)
        DrawColorModify(farbeffekte)
        DrawToyTown(10, ScrH() / 2) -- Verschwemmen vom Screen um die Mitte herum

        timer.Simple(50, function()
            hook.Remove("RenderScreenspaceEffects", "MotionBlur")
        end)

    end)

end)