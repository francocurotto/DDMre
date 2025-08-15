// --- Settings ---
thickness = 0.1;              // mm – your extrusion height
scale_to_mm = 0.005;

// If your SVG was authored in mm and imports at correct scale,
// you can set scale_to_mm = 1 instead.

// --- One-piece extrude ---
linear_extrude(height = thickness)
    scale([scale_to_mm, scale_to_mm, 1])
        import("HEART.svg", center = true);
