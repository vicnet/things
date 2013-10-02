include <vcad/constants.scad>
use <vcad/transform.scad>
use <vcad/vector.scad>

use <geomag.scad>

effector_radius = 40;
/*
vcad_triple() 
vcad_tx(-effector_radius) {
	geomag_ball_pos([0,0.5]);
	geomag_ball_pos([0,-0.5]);
	geomag_rod_y();
}
*/

p1 = geomag_pos([0,0.5])+[-effector_radius,0];
p2 = geomag_pos([0,-0.5])+[-effector_radius,0];
pp1 = vcad_rotate2D(120,p1);
pp2 = vcad_rotate2D(120,p2);
/*
echo(p1);
echo(p2);
echo(pp1);
echo(pp2);
*/
/*
translate(p1) geomag_ball();
translate(p2) geomag_ball();
translate(pp1) geomag_ball();
translate(pp2) geomag_ball();
*/

echo("inter-rod distance: ",vcad_distance(p2,pp1));
/*
inter_rod = 50;

vcad_triple() 
vcad_symetric(axe=VCAD_X)

translate([effector_radius,inter_rod/2]) {
	geomag_ball();
//	geomag_rod_pos([-0.5,0]);
//	geomag_rod_pos([0,-0.5]);
}

translate([effector_radius,inter_rod/2])
	rotate(240)
		geomag_rod_pos([0,-0.5]);
*/
