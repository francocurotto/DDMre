// --- Settings ---
thickness = 0.1;              // mm – your extrusion height
//scale_to_mm = 0.005;
scale_to_mm = 0.001;
//icon = "../icons/HEART.svg";
//icon = "../icons/SUMMON_BEAST.svg";
//icon = "../icons/SUMMON_DRAGON.svg";
//icon = "../icons/SUMMON_SPELLCASTER.svg";
//icon = "../icons/SUMMON_UNDEAD.svg";
//icon = "../icons/SUMMON_WARRIOR.svg";
icon = "../icons/SUMMON_ITEM.svg";

// If your SVG was authored in mm and imports at correct scale,
// you can set scale_to_mm = 1 instead.

// --- One-piece extrude ---
linear_extrude(height = thickness)
    scale([scale_to_mm, scale_to_mm, 1])
        import(icon, center = true);
