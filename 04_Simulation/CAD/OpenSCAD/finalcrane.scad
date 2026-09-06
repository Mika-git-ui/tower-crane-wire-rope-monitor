// =====================================================
// TOWER CRANE WIRE ROPE MONITOR
// CAD-10 — FINAL V1 CAD CLEANUP
// =====================================================
//
// Purpose:
// Split-shell retrofit collar for a 12 mm crane wire rope
// with:
//   1. MFL sensing concept
//   2. Encoder-based rope movement measurement
//   3. Spring/preload concept
//   4. Hinged opening
//   5. Locking mechanism
//   6. Protected sensor/cable regions
//
// STATUS:
// CAD V1 — CONCEPTUAL ENGINEERING MODEL
//
// Important:
// Hinge, latch, preload force and sensor dimensions
// require physical validation before manufacturing.
// =====================================================


$fn = 96;


// =====================================================
// MAIN PARAMETERS
// =====================================================

rope_dia = 12;

lift_off = 4;

wall_thickness = 6;

collar_length = 150;


// Derived dimensions

inner_dia =
    rope_dia
    + (2 * lift_off);

outer_dia =
    inner_dia
    + (2 * wall_thickness);


// =====================================================
// SPLIT COLLAR
// =====================================================

split_gap = 1;


// =====================================================
// LOCK PARAMETERS
// =====================================================

lock_tab_length = 18;

lock_tab_width = 8;

lock_tab_height = 6;

lock_hole_dia = 5;


// =====================================================
// HINGE PARAMETERS
// =====================================================

hinge_pin_dia = 4;

hinge_barrel_dia = 8;

hinge_positions = [
    25,
    75,
    125
];


// =====================================================
// MFL MAGNET PARAMETERS
// =====================================================

magnet_length = 20;

magnet_width = 10;

magnet_height = 5;


// =====================================================
// MFL SENSOR PARAMETERS
// =====================================================

sensor_length = 10;

sensor_width = 8;

sensor_height = 4;

sensor_gap = 5;


// =====================================================
// SENSOR MOUNT PARAMETERS
// =====================================================

sensor_pocket_clearance = 0.5;

sensor_mount_wall = 2;

sensor_pocket_length =
    sensor_length
    + 2 * sensor_pocket_clearance;

sensor_pocket_width =
    sensor_width
    + 2 * sensor_pocket_clearance;

sensor_pocket_depth =
    sensor_height
    + sensor_mount_wall;


// =====================================================
// MFL POSITION
// =====================================================

mfl_z =
    collar_length / 2;


// =====================================================
// TOP MAGNET POSITION
// =====================================================

magnet_x = 0;

magnet_y =
    outer_dia / 2
    - magnet_height / 2;


// =====================================================
// TOP SENSOR POSITION
// =====================================================

sensor_x = 0;

sensor_y =
    magnet_y
    - magnet_height / 2
    - sensor_gap;


// =====================================================
// BOTTOM MAGNET POSITION
// =====================================================

bottom_magnet_x = 0;

bottom_magnet_y =
    -(outer_dia / 2
    - magnet_height / 2);


// =====================================================
// ENCODER PARAMETERS
// =====================================================

encoder_wheel_dia = 50;

encoder_wheel_width = 12;

encoder_axle_dia = 6;


// =====================================================
// ENCODER POSITION
// =====================================================

rope_radius =
    rope_dia / 2;


// Wheel is positioned so its outer surface
// reaches the rope.

encoder_x =
    rope_radius
    + encoder_wheel_dia / 2;

encoder_y = 0;

encoder_z =
    collar_length / 2;


// =====================================================
// ENCODER SIDE PLATES
// =====================================================
//
// Circular plates are used instead of large rectangular
// plates to reduce bulk while retaining axle support.
// =====================================================

encoder_plate_dia = 58;

encoder_plate_thickness = 4;

encoder_plate_offset =
    encoder_wheel_width / 2
    + encoder_plate_thickness / 2;


// =====================================================
// ENCODER ACCESS WINDOW
// =====================================================

encoder_window_width = 14;

encoder_window_height = 54;

encoder_window_depth =
    wall_thickness + 4;

encoder_window_z =
    collar_length / 2;


// =====================================================
// ENCODER PRELOAD SYSTEM
// =====================================================
//
// Concept:
// A pivoting arm supports the encoder assembly and a
// spring applies force toward the rope.
//
// This is a mechanical concept only.
// Actual spring rate and preload will be determined
// during hardware validation.
// =====================================================

preload_arm_length = 24;

preload_arm_width = 8;

preload_arm_height = 6;

preload_pivot_dia = 6;


// Pivot located above/outside encoder

preload_pivot_x =
    outer_dia / 2
    + 12;

preload_pivot_y = 0;

preload_pivot_z =
    encoder_z
    + 30;


// =====================================================
// PRELOAD SPRING
// =====================================================

spring_outer_dia = 8;

spring_inner_dia = 5;

spring_length = 18;


// =====================================================
// ENCODER GUARD
// =====================================================
//
// Compact guard around the outer portion of the wheel.
// Rope-side section remains accessible.
// =====================================================

guard_thickness = 3;

guard_outer_dia =
    encoder_wheel_dia + 8;

guard_inner_dia =
    encoder_wheel_dia + 2;


// =====================================================
// CABLE PROTECTION
// =====================================================

cable_block_length = 14;

cable_block_width = 10;

cable_block_height = 8;


// =====================================================
// CABLE EXIT
// =====================================================

cable_exit_dia = 5;


// =====================================================
// MOUNTING BOSS
// =====================================================

mount_boss_dia = 10;

mount_boss_height = 8;


// =====================================================
// ROPE
// =====================================================

color("gray")
cylinder(
    h = collar_length,
    d = rope_dia
);


// =====================================================
// ENCODER WINDOW MODULE
// =====================================================

module encoder_window()
{
    translate([
        outer_dia / 2
        - encoder_window_depth
        + 1,

        -encoder_window_width / 2,

        encoder_window_z
        - encoder_window_height / 2
    ])
    cube([
        encoder_window_depth,
        encoder_window_width,
        encoder_window_height
    ]);
}


// =====================================================
// COLLAR HALF MODULE
// =====================================================
//
// Creates one semicircular shell.
// =====================================================

module collar_half(side = 1)
{
    difference()
    {

        intersection()
        {

            cylinder(
                h = collar_length,
                d = outer_dia
            );


            if (side == 1)
            {
                translate([
                    -outer_dia,
                    0,
                    -1
                ])
                cube([
                    outer_dia * 2,
                    outer_dia,
                    collar_length + 2
                ]);
            }

            else
            {
                translate([
                    -outer_dia,
                    -outer_dia,
                    -1
                ])
                cube([
                    outer_dia * 2,
                    outer_dia,
                    collar_length + 2
                ]);
            }
        }


        // Rope clearance

        translate([
            0,
            0,
            -1
        ])
        cylinder(
            h = collar_length + 2,
            d = inner_dia
        );


        // Encoder access

        encoder_window();
    }
}


// =====================================================
// FIRST COLLAR HALF
// =====================================================

color("gold")
collar_half(1);


// =====================================================
// SECOND COLLAR HALF
// =====================================================

color("gold")
collar_half(-1);


// =====================================================
// VISIBLE SPLIT SEAM
// =====================================================
//
// Small dark seam makes the two-piece opening obvious
// in the presentation model.
// =====================================================

translate([
    outer_dia / 2 - 0.5,
    -0.5,
    0
])
color("black")
cube([
    1,
    1,
    collar_length
]);


// =====================================================
// HINGE BARRELS
// =====================================================

for (z = hinge_positions)
{

    // Lower hinge barrel

    translate([
        0,

        outer_dia / 2
        + hinge_barrel_dia / 2
        - 1,

        z
    ])
    rotate([
        0,
        90,
        0
    ])
    color("black")
    difference()
    {
        cylinder(
            h = 12,
            d = hinge_barrel_dia,
            center = true
        );

        cylinder(
            h = 14,
            d = hinge_pin_dia,
            center = true
        );
    }


    // Upper hinge barrel

    translate([
        12,

        outer_dia / 2
        + hinge_barrel_dia / 2
        - 1,

        z
    ])
    rotate([
        0,
        90,
        0
    ])
    color("black")
    difference()
    {
        cylinder(
            h = 8,
            d = hinge_barrel_dia,
            center = true
        );

        cylinder(
            h = 10,
            d = hinge_pin_dia,
            center = true
        );
    }
}


// =====================================================
// LOCKING MECHANISM
// =====================================================

lock_x =
    outer_dia / 2 - 2;

lock_y = 0;

lock_z =
    collar_length / 2;


// =====================================================
// LOWER LOCK TAB
// =====================================================

translate([
    lock_x,
    lock_y - lock_tab_width / 2,
    lock_z
])
difference()
{
    cube([
        lock_tab_length,
        lock_tab_width,
        lock_tab_height
    ]);


    translate([
        lock_tab_length / 2,
        lock_tab_width / 2,
        -1
    ])
    cylinder(
        h = lock_tab_height + 2,
        d = lock_hole_dia
    );
}


// =====================================================
// UPPER LOCK TAB
// =====================================================

translate([
    lock_x
    + lock_tab_length
    - 2,

    lock_y
    - lock_tab_width / 2,

    lock_z
    - lock_tab_height
])
difference()
{
    cube([
        lock_tab_length,
        lock_tab_width,
        lock_tab_height
    ]);


    translate([
        lock_tab_length / 2,
        lock_tab_width / 2,
        -1
    ])
    cylinder(
        h = lock_tab_height + 2,
        d = lock_hole_dia
    );
}


// =====================================================
// LOCK PIN
// =====================================================

translate([
    lock_x
    + lock_tab_length / 2,

    lock_y,

    lock_z
    - lock_tab_height / 2
])
rotate([
    90,
    0,
    0
])
color("silver")
cylinder(
    h = lock_tab_width + 4,
    d = lock_hole_dia,
    center = true
);


// =====================================================
// TOP MFL MAGNET
// =====================================================

translate([
    magnet_x
    - magnet_length / 2,

    magnet_y
    - magnet_width / 2,

    mfl_z
    - magnet_height / 2
])
color("red")
cube([
    magnet_length,
    magnet_width,
    magnet_height
]);


// =====================================================
// MFL SENSOR MOUNT
// =====================================================

translate([
    sensor_x
    - sensor_pocket_length / 2,

    sensor_y
    - sensor_pocket_width / 2,

    mfl_z
    - sensor_pocket_depth
])
difference()
{
    color("blue")
    cube([
        sensor_pocket_length
        + 2 * sensor_mount_wall,

        sensor_pocket_width
        + 2 * sensor_mount_wall,

        sensor_pocket_depth
    ]);


    translate([
        sensor_mount_wall,
        sensor_mount_wall,
        sensor_mount_wall
    ])
    cube([
        sensor_pocket_length,
        sensor_pocket_width,
        sensor_height + 1
    ]);
}


// =====================================================
// BOTTOM MFL MAGNET
// =====================================================

translate([
    bottom_magnet_x
    - magnet_length / 2,

    bottom_magnet_y
    - magnet_width / 2,

    mfl_z
    - magnet_height / 2
])
color("red")
cube([
    magnet_length,
    magnet_width,
    magnet_height
]);


// =====================================================
// ENCODER WHEEL
// =====================================================

translate([
    encoder_x,
    encoder_y,
    encoder_z
])
rotate([
    90,
    0,
    0
])
color("orange")
difference()
{
    cylinder(
        h = encoder_wheel_width,
        d = encoder_wheel_dia,
        center = true
    );


    cylinder(
        h = encoder_wheel_width + 2,
        d = encoder_axle_dia,
        center = true
    );
}


// =====================================================
// ENCODER AXLE
// =====================================================

encoder_axle_length =
    encoder_wheel_width + 10;


translate([
    encoder_x,
    encoder_y,
    encoder_z
])
rotate([
    90,
    0,
    0
])
color("silver")
cylinder(
    h = encoder_axle_length,
    d = encoder_axle_dia,
    center = true
);


// =====================================================
// LEFT CIRCULAR ENCODER PLATE
// =====================================================

translate([
    encoder_x,

    -encoder_plate_offset,

    encoder_z
])
rotate([
    90,
    0,
    0
])
color("darkgray")
difference()
{
    cylinder(
        h = encoder_plate_thickness,
        d = encoder_plate_dia,
        center = true
    );


    cylinder(
        h = encoder_plate_thickness + 2,
        d = encoder_axle_dia,
        center = true
    );
}


// =====================================================
// RIGHT CIRCULAR ENCODER PLATE
// =====================================================

translate([
    encoder_x,

    encoder_plate_offset,

    encoder_z
])
rotate([
    90,
    0,
    0
])
color("darkgray")
difference()
{
    cylinder(
        h = encoder_plate_thickness,
        d = encoder_plate_dia,
        center = true
    );


    cylinder(
        h = encoder_plate_thickness + 2,
        d = encoder_axle_dia,
        center = true
    );
}


// =====================================================
// ENCODER PRELOAD PIVOT
// =====================================================

translate([
    preload_pivot_x,
    preload_pivot_y,
    preload_pivot_z
])
rotate([
    90,
    0,
    0
])
color("silver")
difference()
{
    cylinder(
        h = preload_arm_width + 4,
        d = preload_pivot_dia,
        center = true
    );


    cylinder(
        h = preload_arm_width + 6,
        d = 3,
        center = true
    );
}


// =====================================================
// PRELOAD ARM
// =====================================================
//
// Arm extends from pivot toward encoder assembly.
// =====================================================

arm_angle =
    atan2(
        encoder_z - preload_pivot_z,
        encoder_x - preload_pivot_x
    );

arm_length =
    sqrt(
        pow(
            encoder_x - preload_pivot_x,
            2
        )
        +
        pow(
            encoder_z - preload_pivot_z,
            2
        )
    );


translate([
    preload_pivot_x,
    -preload_arm_width / 2,
    preload_pivot_z
])
rotate([
    0,
    -arm_angle,
    0
])
color("darkgray")
cube([
    arm_length,
    preload_arm_width,
    preload_arm_height
]);


// =====================================================
// PRELOAD SPRING
// =====================================================
//
// Simplified spring representation between the
// mounting region and preload arm.
// =====================================================

spring_x =
    (preload_pivot_x + encoder_x) / 2;

spring_z =
    (preload_pivot_z + encoder_z) / 2;


translate([
    spring_x,
    0,
    spring_z
])
color("yellow")
difference()
{
    cylinder(
        h = spring_length,
        d = spring_outer_dia,
        center = true
    );


    cylinder(
        h = spring_length + 2,
        d = spring_inner_dia,
        center = true
    );
}


// =====================================================
// ENCODER COMPACT GUARD
// =====================================================
//
// Annular guard protects the outer wheel surface.
// =====================================================

translate([
    encoder_x,

    0,

    encoder_z
])
rotate([
    90,
    0,
    0
])
color("black")
difference()
{
    cylinder(
        h = guard_thickness,
        d = guard_outer_dia,
        center = true
    );


    cylinder(
        h = guard_thickness + 2,
        d = guard_inner_dia,
        center = true
    );
}


// =====================================================
// CABLE PROTECTION BLOCK
// =====================================================

cable_block_x =
    outer_dia / 2 + 2;

cable_block_y =
    -cable_block_width / 2;

cable_block_z =
    collar_length / 2 + 32;


translate([
    cable_block_x,
    cable_block_y,
    cable_block_z
])
color("black")
cube([
    cable_block_length,
    cable_block_width,
    cable_block_height
]);


// =====================================================
// CABLE STRAIN RELIEF
// =====================================================

cable_exit_x =
    cable_block_x
    + cable_block_length;


cable_exit_z =
    cable_block_z
    + cable_block_height / 2;


translate([
    cable_exit_x,
    0,
    cable_exit_z
])
rotate([
    0,
    90,
    0
])
color("black")
difference()
{
    cylinder(
        h = 8,
        d = 9,
        center = true
    );


    cylinder(
        h = 10,
        d = cable_exit_dia,
        center = true
    );
}


// =====================================================
// MOUNTING REINFORCEMENT BOSS
// =====================================================

mount_boss_x =
    outer_dia / 2 + 1;

mount_boss_y = 0;

mount_boss_z =
    collar_length / 2;


translate([
    mount_boss_x,
    mount_boss_y,
    mount_boss_z
])
rotate([
    0,
    90,
    0
])
color("darkgray")
difference()
{
    cylinder(
        h = mount_boss_height,
        d = mount_boss_dia,
        center = true
    );


    cylinder(
        h = mount_boss_height + 2,
        d = encoder_axle_dia + 2,
        center = true
    );
}


// =====================================================
// SPLIT-COLLAR OPENING TABS
// =====================================================
//
// Small tabs make the opening/clamping concept easier
// to understand visually.
// =====================================================

opening_tab_length = 12;

opening_tab_width = 5;

opening_tab_height = 5;


// First tab

translate([
    -opening_tab_length / 2,
    -outer_dia / 2 - opening_tab_width,
    collar_length / 2
])
color("darkgray")
cube([
    opening_tab_length,
    opening_tab_width,
    opening_tab_height
]);


// Second tab

translate([
    -opening_tab_length / 2,
    outer_dia / 2,
    collar_length / 2
])
color("darkgray")
cube([
    opening_tab_length,
    opening_tab_width,
    opening_tab_height
]);


// =====================================================
// END OF CAD-10
// =====================================================
//
// CAD V1 CONCEPT COMPLETE
//
// Next engineering phase:
// PYTHON SIGNAL SIMULATION
//
// healthy signal
//      ↓
// defect signal
//      ↓
// realistic noise
//      ↓
// filtering
//      ↓
// feature extraction
//      ↓
// anomaly detection
//      ↓
// localization
// =====================================================