// --- Settings ---
thickness = 5;              // mm – your extrusion height
px_per_mm = 96/25.4;        // Inkscape’s 96 DPI → 3.7795 px per mm
scale_to_mm = 1/px_per_mm;  // convert SVG px units to mm

// If your SVG was authored in mm and imports at correct scale,
// you can set scale_to_mm = 1 instead.

// --- One-piece extrude ---
linear_extrude(height = thickness)
    scale([scale_to_mm, scale_to_mm, 1])
        import("HEART.svg", center = true);
