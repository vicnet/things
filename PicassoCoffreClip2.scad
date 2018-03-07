include <vcad/constants.scad>
use <vcad/transform.scad>
use <vcad/shapes.scad>
use <vcad/extrude.scad>

module dent() {
    vcube([3.4,1,0.4],centery=true);
}

module axe() {
    cylinder(r=3, h=11.9, $fn=20);
    vextrude_helix(h=6.6, p=1)
        dent();
}

module stop() {
    vspherical_cap(5.5, 3.3, $fn=20);
}

module rotule() {
    difference() {
        vspherical_cap(5.5, 4.75, $fn=20);
        vtr([-6,-6, 5-1]) cube([12,12,2]);
    }
}

vtz( 0.0) axe();
vtz( 6.6) stop();
vtz(11.9) rotule();
