AlkAuswahl = AlkAuswahl or {} -- Wenn die Table schonmal definiert wurde, soll sie nicht jedes mal erneut werden
AlkAuswahl.Items = AlkAuswahl.Items or {}

rot = Color(255, 0, 0)
grün = Color(0, 255, 0)

AlkAuswahl.Items = {
    [1] = {
        name = "Whisky",
        preis = 50,
        prop = "models/props_bar/bottle_02a.mdl",
        color = Color(245, 179, 13),
        color_text = color_black,
    },
    [2] = {
        name = "Rum",
        preis = 25,
        prop = "models/props_junk/glassjug01.mdl",
        color = Color(209, 62, 34),
        color_text = color_white
    },
    [3] = {
        name = "Gin",
        preis = 40,
        prop = "models/props_bar/bottle_02c.mdl",
        color = Color(181, 208, 216),
        color_text = color_black
    },
    [4] = {
        name = "Wodka",
        preis = 35,
        prop = "models/props_junk/GlassBottle01a.mdl",
        color = Color(27, 47, 172),
        color_text = color_white
    },
    [5] = {
        name = "Rotwein",
        preis = 60,
        prop = "models/props_bar/bottle_01a.mdl",
        color = Color(138, 18, 40),
        color_text = color_white
    }
}









