// CONFIGURATION:

// angle of the seat tube, this one is for sl7 size 56
seat_tube_angle = 73.5;
// distance between the sides, should be slightly bigger than the real seat tube width
seat_tube_width = 21.4;

// outer diameter to fit inside of garmin mount
outerD = 28.8;
// inner diameter to fit inside of garmin mount
innerD = 23.8;
// dimensions of the holes to fit inside of garmin mount
hole_height = 2;
hole_width = 10.5;

// height of the sides
side_height = 7;
// thickness of the wall that attaches to the seat tube
contact_thickness = 2;

// CONSTANTS:
big = 100;
inf = 1000;

rotation_angle = 90 - seat_tube_angle;
bottom_height = hole_height+1;

difference() {
    // the base shape we cut out of
    cylinder(d = outerD, h = big, $fn = 100);
    
    // the bottom cut
    difference() {
        union() {
            cylinder(d = innerD, h = big, $fn = 100);
            centeredCube([outerD, hole_width, hole_height]);
        }
        translate([-outerD/2, -outerD/2, bottom_height]) {
            rotate([rotation_angle, 0, 0]) {
                cube(inf);
            }
        }
    }
    
    // the top cut
    union() {
        translate([0, 0, bottom_height+contact_thickness]) {
            translate([-seat_tube_width/2, -outerD/2, 0]) {
                rotate([rotation_angle, 0, 0]) {
                    cube([seat_tube_width, inf, inf]);
                }
            }    
        }
        translate([-inf/2, -outerD/2, bottom_height+contact_thickness+side_height]) {
            rotate([rotation_angle, 0, 0]) {
                cube(inf);    
            }
        }
    }
}


module centeredCube(size) {
    translate([-size.x/2, -size.y/2, 0]) {
        cube(size);
    }
}
