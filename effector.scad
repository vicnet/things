include <vcad/constants.scad>
use <vcad/transform.scad>
use <vcad/vector.scad>

use <geomag.scad>

effector_radius = 40;

vcad_triple() 
vcad_tx(-effector_radius) {
	geomag_ball_pos([0,0.5]);
	geomag_ball_pos([0,-0.5]);
	geomag_rod_y();
}

p1 = geomag_pos([0,0.5])+[-effector_radius,0];
p2 = geomag_pos([0,-0.5])+[-effector_radius,0];
pp1 = vcad_rotate2D(120,p1);
pp2 = vcad_rotate2D(120,p2);

inter_rod = vcad_distance(p2,pp1);
echo("inter-rod distance: ", inter_rod);

/*
test points
translate(p1) geomag_ball();
translate(p1) geomag_ball();
translate(p2) geomag_ball();
translate(pp1) geomag_ball();
translate(pp2) geomag_ball();
*/


delta_geomag_link = 7;

union() {
vcad_triple()
vcad_tx(-effector_radius/2-geomag_rod_radius()/2-delta_geomag_link/2)
    square([effector_radius + geomag_rod_radius() + delta_geomag_link,geomag_rod_length()],center=true);
}

color("blue") circle(30);