mindestalter = 16


hook.Add("OnPlayerChat", "Altersabfrage", function(ply, nachricht, team)
    nachricht = string.lower(nachricht) -- Setzt Nachricht in Kleinbuchstaben, sodass man auch die verschiedenen Buchstaben groß/kleinschreiben kann & es trotzdem ausgeführt wird

    if (nachricht == "!alk") then -- Wenn die Nachricht "!alk" ist dann:
        ply:ChatPrint("Moin und herzlich willkommen im Online-Alkohol-Bestellservice!\nBitte beachten Sie, dass jeglicher Alkohol hier erst ab " .. mindestalter .. " Jahren legal erwerbbar ist. \n\nGeben Sie demnach bitte nun Ihr Alter ein.\n\n\n\n")
        -- suppressed die Nachricht, sodass man sein eigenes nicht im Chat sieht

        return true
    end

    if string.match(nachricht, "[%a]") then -- Wenn es sich bei der Nachricht um einen Groß/Kleinbruchstaben handelt, DANN:
        ply:ChatPrint("Du kannst nicht '" .. nachricht .. "' Jahre alt sein, du Vollidiot...")

        timer.Simple(1, function()
            chat.AddText(rot, ply, "\n\n...Logged out...")
        end)

        hook.Remove("OnPlayerChat", "Altersabfrage") -- Bricht die Hook ab, sodass keine weiteren Prüfungen und Prints ausgeführt werden

        return true
    elseif string.match(nachricht, "[%d]") and tonumber(nachricht) > 80 then
        ply:ChatPrint("Wir befürchten, mit " .. nachricht .. " Jahren sind Sie bissl zu alt, Grandpa.")

        timer.Simple(1, function()
            chat.AddText(rot, ply, "\n\n...Logged out...")
        end)

        hook.Remove("OnPlayerChat", "Altersabfrage")

        return true
    elseif string.match(nachricht, "[%d]") and tonumber(nachricht) >= 16 then -- Wenn die nachricht eine Zahl beinhaltet, wird sie in ein integer verwandelt. Wenn diese Zahl größer/gleich 16 ist, DANN
        ply:ChatPrint("Gut, Sie sind mit " .. nachricht .. " Jahren alt genug für den Erwerb.")

        timer.Simple(5, function()
            chat.AddText(grün, ply, "\n\nSie wurden erfolgreich eingelogged!")
        end)

        timer.Simple(7, function()
            AlkAuswahl.Open()
        end)

        return true
    elseif (mindestalter - nachricht ~= 1) then -- Wenn Mindestalter - Zahl von nachricht ungleich 1 ist, DANN
        ply:ChatPrint("Scheinbar sind Sie zu jung für den Erwerb von Alkohol. Dauert wohl noch " .. mindestalter - nachricht .. " Jahre, Kid")

        timer.Simple(1, function()
            chat.AddText(rot, ply, "\n\n...Logged out...")
        end)

        hook.Remove("OnPlayerChat", "Altersabfrage")

        return true
    else -- sonst (wenn mindestalter - Zahl = 1) DANN
        ply:ChatPrint("Scheinbar sind Sie zu jung für den Erwerb von Alkohol. Dauert wohl noch " .. mindestalter - nachricht .. " Jahr, Kid")

        timer.Simple(1, function()
            chat.AddText(rot, ply, "\n\n...Logged out...")
        end)

        hook.Remove("OnPlayerChat", "Altersabfrage")

        return true
    end
end)

function AlkAuswahl.Open()
    Buttonabstand = 75 -- Variabel hier initialisiert, damit auch beim Zurück-clicken der Wert auf 75 zurückgesetzt wird
    hIconabstand = 75 -- Healthiconabstand
    rIconAbstand = 75 -- Runningiconabstand
    local frame = vgui.Create("XeninUI.Frame", frame)
    frame:SetSize(500, 700)
    frame:Center()
    frame:SetTitle("Online-Alkohol-Bestellservice")
    frame:MakePopup()
    frame:MoveTo(ScrW() / 2 - 250, ScrH() / 2 - 300, 1)

    local panel1 = vgui.Create("XeninUI.Panel", frame)
    panel1:SetSize(500, 660)
    panel1:SetPos(0, 40)


    panel1.Paint = function(pnl, w, h) -- 2 Linien beim Avatar + Tabelle der Boosts
        --surface.DrawOutlinedRect(0, 82.5, w, 576.5, 5)
        surface.SetDrawColor(255, 255, 255)
        surface.DrawRect(0, 0, 500, 1)
        surface.DrawRect(0, 82.5, 500, 1)
        surface.DrawRect(10, 247.5, 260, 1)
        surface.DrawRect(10, 322.5, 260, 1)
        surface.DrawRect(10, 397.5, 260, 1)
        surface.DrawRect(10, 472.5, 260, 1)
        surface.DrawRect(10, 547.5, 260, 1)
        surface.DrawRect(10, 622.5, 260, 1)

        surface.DrawRect(10, 247.5, 1, 375)
        surface.DrawRect(145, 247.5, 1, 375)
        surface.DrawRect(270, 247.5, 1, 375)

--[[          for k, v in ipairs(AlkAuswahl.Items) do
            healeffektabstand = 75
            surface.SetTextColor(255, 255, 255)
            surface.SetFont("CloseCaption_Normal")
            surface.SetTextPos(72.5, 195 + healeffektabstand)
            surface.DrawText("+ " .. v.healeffekt .. "%")
            healeffektabstand = healeffektabstand + 75
        end ]]

        surface.SetTextColor(255, 255, 255)
        surface.SetFont("CloseCaption_Normal")

        surface.SetTextPos(72.5, 270) -- Whiskey        -- Wallah Billah, voll der billige Hase
        surface.DrawText("+ 15%         - 15%")

        surface.SetTextPos(72.5, 345) -- Rum
        surface.DrawText("+ 5%          + 20%")

        surface.SetTextPos(72.5, 420) -- Gin
        surface.DrawText("+ 15%         - 15%")

        surface.SetTextPos(72.5, 495) -- Wodka
        surface.DrawText("+ 10%         + 10%")

        surface.SetTextPos(72.5, 570) -- Rotwein
        surface.DrawText("+ 20%         - 30%")
    end

    for k, v in ipairs(AlkAuswahl.Items) do
        local healthicon = vgui.Create("DImage", frame)
        healthicon:SetImage(v.health)
        healthicon:SetSize(50, 50)
        healthicon:SetPos(15, 225 + hIconabstand)
        hIconabstand = hIconabstand + 75
        local runningicon = vgui.Create("DImage", frame)
        runningicon:SetImage(v.speed)
        runningicon:SetSize(50, 50)
        runningicon:SetPos(150, 225 + rIconAbstand)
        rIconAbstand = rIconAbstand + 75
    end

    local avatar = vgui.Create("AvatarImage", frame)
    avatar:SetPos(5, 45)
    avatar:SetSize(75, 75)
    avatar:SetPlayer(LocalPlayer(), 64)
    local text_oben = vgui.Create("XeninUI.Panel", frame)
    text_oben:SetSize(500, 300)
    text_oben:Center()
    text_oben:Dock(TOP)

    text_oben.Paint = function(pnl, w, h)
        surface.SetTextColor(70, 116, 204)
        surface.SetTextPos(35, 95)
        surface.SetFont("CloseCaption_Bold")
        surface.DrawText("Zur Auswahl stehen die unteren Produkte")
        surface.SetTextColor(color_white)
        surface.SetFont("CloseCaption_Normal")
        surface.SetTextPos(17.5, 180)
        surface.DrawText("Um Details zu diesen zu erfahren oder zu kaufen,")
        surface.SetTextPos(20, 205)
        surface.DrawText(" klicken Sie einfach auf den zugehörigen Button.")
        surface.SetTextPos(100, 30)
        surface.DrawText(ply:Nick())
    end

    for k, v in ipairs(AlkAuswahl.Items) do
        local Button_Auswahl = vgui.Create("XeninUI.ButtonV2", frame)
        Button_Auswahl:SetSize(150, 50)
        Button_Auswahl:SetPos(300, 225 + Buttonabstand) -- Buttons sollen bei jedem Schleif-Durchgang um Buttonabstand weiter nach unten verschoben werden
        Button_Auswahl:SetText(v.name)
        Button_Auswahl:SetSolidColor(v.color)
        Button_Auswahl:SetTextColor(v.color_text)
        Buttonabstand = Buttonabstand + 75 -- Bei jedem Indexcheck wird der Button um 75 weiter nach unten verschoben -> Alle Buttons sind untereinander

        Button_Auswahl.DoClick = function()
            frame:Remove() -- entfernt den ersten Frame
            local frame2 = vgui.Create("XeninUI.Frame", frame2) -- erstellt neuen Frame
            frame2:SetTitle("Informationen zu: " .. v.name)
            frame2:SetSize(500, 700)
            frame2:Center()
            frame2:MoveTo(ScrW() / 2 - 250, ScrH() / 2 - 300, 1)
            local panel2 = vgui.Create("XeninUI.Panel", frame2) -- neues Panel im Panel, damit icon verschoben werden kann mit einem Rahmen
            panel2:SetSize(500, 660)
            panel2:SetPos(0, 40) -- 82.5

            panel2.Paint = function(pnl, w, h)
                surface.SetDrawColor(30, 30, 30)
                surface.DrawRect(0, 0, w, h)
                surface.SetDrawColor(v.color)
                surface.DrawOutlinedRect(0, 87.5, w, 572.5, 5)
                surface.SetTextColor(v.color)
                surface.SetTextPos(200, 307.5)
                surface.SetFont("CloseCaption_Bold")
                surface.DrawText("Preis: $" .. v.preis)

                surface.SetDrawColor(255, 255, 255)
                surface.DrawRect(0, 0, 500, 1)
                surface.DrawRect(0, 82.5, 500, 1)
            end

            local icon = vgui.Create("DModelPanel", panel2)
            icon:SetPos(-45, -17.5)
            icon:SetSize(600, 600)
            icon:SetModel(v.prop)
            local avatar2 = vgui.Create("AvatarImage", frame2)
            avatar2:SetPos(5, 45)
            avatar2:SetSize(75, 75)
            avatar2:SetPlayer(LocalPlayer(), 64)
            local beschreibung = vgui.Create("XeninUI.Panel", frame2)
            beschreibung:SetSize(500, 300)
            beschreibung:Center()
            beschreibung:Dock(TOP)

            function kaufenzurueck()
                Button_kaufen = vgui.Create("XeninUI.ButtonV2", frame2)
                Button_kaufen:SetSize(150, 50)
                Button_kaufen:SetPos(300, 600)
                Button_kaufen:SetSolidColor(grün)
                Button_kaufen:SetText("Kaufen")
                Button_kaufen:SetTextColor(color_black)
                Button_zurueck = vgui.Create("XeninUI.ButtonV2", frame2)
                Button_zurueck:SetSize(150, 50)
                Button_zurueck:SetPos(50, 600)
                Button_zurueck:SetSolidColor(rot)
                Button_zurueck:SetText("Zurück")
                Button_zurueck:SetTextColor(color_black)

                Button_zurueck.DoClick = function()
                    frame2:Remove()
                    Buttonabstand = Buttonabstand - 375 -- setzt die Buttons beim Zurückkehren um ein Intervall der Verschiebung zurück (an die originalen Positionen)
                    AlkAuswahl.Open()
                end

                Button_kaufen.DoClick = function()
                    frame2:SetAlpha(100)
                    framebestaetigung = vgui.Create("XeninUI.Frame")
                    framebestaetigung:SetTitle("Kaufbestätigung")
                    framebestaetigung:SetSize(475, 300)
                    framebestaetigung:Center()
                    framebestaetigung:MoveTo(ScrW() / 2 - 237.5, ScrH() / 2 - 140, 0.5)
                    bestaetigungstext = vgui.Create("XeninUI.Panel", framebestaetigung)
                    bestaetigungstext:SetSize(475, 250)
                    bestaetigungstext:Center()

                    bestaetigungstext.Paint = function(pnl, w, h)
                        surface.SetFont("CloseCaption_Normal")
                        surface.SetTextColor(color_white)
                        surface.SetTextPos(70, 75)
                        surface.DrawText("Möchten Sie wirklich " .. v.name .. " kaufen?")
                    end

                    Button_ja = vgui.Create("XeninUI.ButtonV2", framebestaetigung)
                    Button_ja:SetSize(150, 50)
                    Button_ja:SetPos(300, 200)
                    Button_ja:SetSolidColor(grün)
                    Button_ja:SetText("Ja")
                    Button_ja:SetTextColor(color_black)
                    Button_nein = vgui.Create("XeninUI.ButtonV2", framebestaetigung)
                    Button_nein:SetSize(150, 50)
                    Button_nein:SetPos(25, 200)
                    Button_nein:SetSolidColor(rot)
                    Button_nein:SetText("Nein")
                    Button_nein:SetTextColor(color_black)

                    Button_nein.DoClick = function()
                        frame2:SetAlpha(255)
                        framebestaetigung:Remove()
                    end

                    Button_ja.DoClick = function()
                        frame2:Remove()
                        framebestaetigung:Remove()

                        net.Start("Kaufen")
                        net.WriteInt(k, 5) -- Key des Buttons im Server weiterverwenden
                        net.WriteString("Kaufen")
                        net.SendToServer()

                        if (ply:canAfford(v.preis)) then -- Wenn der Spieler das Produkt bezahlen kann, dann
                            notification.AddLegacy("Du hast eine Flasche " .. v.name .. " für $" .. v.preis .. " gekauft.", 0, 10)
                        else
                            notification.AddLegacy("Du kannst dir kein " .. v.name .. " leisten.", 1, 10)
                        end
                    end
                end
            end

            if k == 1 then
                beschreibung.Paint = function(pnl, w, h)
                    surface.SetTextColor(v.color)
                    surface.SetTextPos(209, 120)
                    surface.SetFont("CloseCaption_Bold")
                    surface.DrawText(v.name)
                    surface.SetTextColor(color_white)
                    surface.SetFont("CloseCaption_Normal")
                    surface.SetTextPos(100, 30)
                    surface.DrawText(ply:Nick())
                    surface.SetFont("HudHintTextLarge")
                    surface.SetTextPos(20, 180)
                    surface.DrawText("Whisky wird aus Getreide hergestellt, mit Wasser und Hefe vergoren")
                    surface.SetTextPos(20, 195)
                    surface.DrawText("sowie Hefe vergoren und zu einem Brand destilliert, welcher schließlich")
                    surface.SetTextPos(20, 210)
                    surface.DrawText("im Holzfass für mindestens drei Jahre gelagert wird.")
                    surface.SetTextPos(20, 230)
                    surface.DrawText("Der Geschmack wird meistens als süß, würzig, malzig, holzig")
                    surface.SetTextPos(20, 245)
                    surface.DrawText("rauchig und streng von unseren zufriedenen Kunden bezeichnet.")
                end

                kaufenzurueck()
            elseif k == 2 then
                beschreibung.Paint = function(pnl, w, h)
                    surface.SetTextColor(v.color)
                    surface.SetTextPos(230, 120)
                    surface.SetFont("CloseCaption_Bold")
                    surface.DrawText(v.name)
                    surface.SetTextColor(color_white)
                    surface.SetFont("CloseCaption_Normal")
                    surface.SetTextPos(100, 30)
                    surface.DrawText(ply:Nick())
                    surface.SetFont("HudHintTextLarge")
                    surface.SetTextPos(20, 180)
                    surface.DrawText("Die Maische von Rum aus Zuckerrohrsaft und Wasser wird fermentiert")
                    surface.SetTextPos(20, 195)
                    surface.DrawText("und erhält einen Alkoholgehalt. Dieser Zuckerwein wird destilliert und")
                    surface.SetTextPos(20, 210)
                    surface.DrawText("durch das Destillat hat man daraufhin einen mit Wasser verdünnten")
                    surface.SetTextPos(20, 225)
                    surface.DrawText("weißen Rum, welcher durch Geschmacksstoffe seinen Braunton erhält.")
                    surface.SetTextPos(20, 245)
                    surface.DrawText("Rum schmeckt süßlich, mild und gilt als zweitbestes unserer Produkte.")
                end

                kaufenzurueck()
            elseif k == 3 then
                beschreibung.Paint = function(pnl, w, h)
                    surface.SetTextColor(v.color)
                    surface.SetTextPos(237.5, 120)
                    surface.SetFont("CloseCaption_Bold")
                    surface.DrawText(v.name)
                    surface.SetTextColor(color_white)
                    surface.SetFont("CloseCaption_Normal")
                    surface.SetTextPos(100, 30)
                    surface.DrawText(ply:Nick())
                    surface.SetFont("HudHintTextLarge")
                    surface.SetTextPos(20, 180)
                    surface.DrawText("Gin wird aus kohlenhydrathaltigen Ausgangsstoffen gebrannt, welche")
                    surface.SetTextPos(20, 195)
                    surface.DrawText("meist Getreide oder Melasse sind.")
                    surface.SetTextPos(20, 210)
                    surface.DrawText("Seinen charakteristischen Geschmack erhält Gin durch die Aromatisie-")
                    surface.SetTextPos(20, 225)
                    surface.DrawText("rung mit Gewürzen, darunter vor allem Wacholderbeeren.")
                    surface.SetTextPos(20, 245)
                    surface.DrawText("Unser Gin ist selfmade und für seinen starken Geschmack sehr bekannt.")
                end

                kaufenzurueck()
            elseif k == 4 then
                beschreibung.Paint = function(pnl, w, h)
                    surface.SetTextColor(v.color)
                    surface.SetTextPos(215, 120)
                    surface.SetFont("CloseCaption_Bold")
                    surface.DrawText(v.name)
                    surface.SetTextColor(color_white)
                    surface.SetFont("CloseCaption_Normal")
                    surface.SetTextPos(100, 30)
                    surface.DrawText(ply:Nick())
                    surface.SetFont("HudHintTextLarge")
                    surface.SetTextPos(20, 180)
                    surface.DrawText("Herkömmliche Maische wird mit Hefe gegärt und der entstehende")
                    surface.SetTextPos(20, 195)
                    surface.DrawText("Alkohol wird mehrfach gebrannt, gekocht, fermentiert, gefiltert,")
                    surface.SetTextPos(20, 210)
                    surface.DrawText("auf Trinkstärke verschnitten und aromatisiert.")
                    surface.SetTextPos(20, 230)
                    surface.DrawText("Nach der fein-russischen Art wird unser Wodka hergestellt und konnte")
                    surface.SetTextPos(20, 245)
                    surface.DrawText("93% der Käufer derart überzeugen, dass sie es mehrach kauften.")
                end

                kaufenzurueck()
            elseif k == 5 then
                beschreibung.Paint = function(pnl, w, h)
                    surface.SetTextColor(v.color)
                    surface.SetTextPos(210, 120)
                    surface.SetFont("CloseCaption_Bold")
                    surface.DrawText(v.name)
                    surface.SetTextColor(color_white)
                    surface.SetFont("CloseCaption_Normal")
                    surface.SetTextPos(100, 30)
                    surface.DrawText(ply:Nick())
                    surface.SetFont("HudHintTextLarge")
                    surface.SetTextPos(20, 180)
                    surface.DrawText("Nach dem wochenlangen Gären der Trauben-Maische, welche für den")
                    surface.SetTextPos(20, 195)
                    surface.DrawText("Alkohol und die Kohlensäure verantwortlich ist, wird dieser")
                    surface.SetTextPos(20, 210)
                    surface.DrawText("gepresst, filrtiert und letztlich monate- oder gar jahrelang gelagert.")
                    surface.SetTextPos(20, 230)
                    surface.DrawText("Mit seinem süß-bitteren Geschmack hat unser Wein bereits tausende")
                    surface.SetTextPos(20, 245)
                    surface.DrawText("Kunden zufrieden gestellt.")
                end

                kaufenzurueck()
            end
        end
    end
end