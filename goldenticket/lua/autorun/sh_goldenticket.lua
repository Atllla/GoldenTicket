AlkAuswahl = AlkAuswahl or {} -- Wenn die Table schonmal definiert wurde, soll sie nicht jedes mal erneut werden
AlkAuswahl.Items = AlkAuswahl.Items or {}
--AlkAuswahl.Icons = AlkAuswahl.Icons or {}

rot = Color(255, 0, 0)
grün = Color(0, 255, 0)

AlkAuswahl.Items = {
    [1] = {
        name = "Whisky",
        preis = 50,
        prop = "models/props_bar/bottle_02a.mdl",
        color = Color(245, 179, 13),
        color_text = color_black,
        health = "materials/icons/hearticon.png",
        speed = "materials/icons/runningicon.png",
        ent = "whiskey"
        -- healeffekt = 15                              SIEHE: Entity-sharedfiles
        -- speedfaktor = 0.85                           SIEHE: Entity-sharedfiles
    },
    [2] = {
        name = "Rum",
        preis = 45,
        prop = "models/props_junk/glassjug01.mdl",
        color = Color(209, 62, 34),
        color_text = color_white,
        health = "materials/icons/hearticon.png",
        speed = "materials/icons/runningicon.png",
        ent = "rum"
        -- healeffekt = 5
        -- speedfaktor = 1.2
    },
    [3] = {
        name = "Gin",
        preis = 40,
        prop = "models/props_bar/bottle_02c.mdl",
        color = Color(181, 208, 216),
        color_text = color_black,
        health = "materials/icons/hearticon.png",
        speed = "materials/icons/runningicon.png",
        ent = "gin"
        -- healeffekt = 15
        -- speedfaktor = 0.85
    },
    [4] = {
        name = "Wodka",
        preis = 35,
        prop = "models/props_junk/GlassBottle01a.mdl",
        color = Color(27, 47, 172),
        color_text = color_white,
        health = "materials/icons/hearticon.png",
        speed = "materials/icons/runningicon.png",
        ent = "wodka"
        -- healeffekt = 10
        -- speedfaktor = 1.1
    },
    [5] = {
        name = "Rotwein",
        preis = 60,
        prop = "models/props_bar/bottle_01a.mdl",
        color = Color(138, 18, 40),
        color_text = color_white,
        health = "materials/icons/hearticon.png",
        speed = "materials/icons/runningicon.png",
        ent = "rotwein"
        -- healeffekt = 20
        -- speedfaktor = 0.7
    }
}

--[[ AlkAuswahl.Icons = {

    [1] = {health = "materials/icons/hearticon.png"},

    [2] = {running = "materials/icons/runningicon.png"}

} ]]






