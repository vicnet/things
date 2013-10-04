include <vcad/constants.scad>
use <vcad/transform.scad>
use <vcad/vector.scad>
use <vcad/figures.scad>
use <vcad/colors.scad>

include <geomag.scad>

effector_radius = 40;

p1 = geomag_pos([0,0.5])+[-effector_radius,0];
p2 = geomag_pos([0,-0.5])+[-effector_radius,0];
pp1 = vcad_rotate2D(120,p1);
pp2 = vcad_rotate2D(120,p2);


inter_rod = vcad_distance(p2,pp1);
echo("inter-rod distance: ", inter_rod);


module effector_geomags() {
	vcad_triple() 
		vcad_tx(-effector_radius) {
			geomag_ball_pos([0,0.5]);
			geomag_ball_pos([0,-0.5]);
			geomag_rod_y();
		}
}

/*
test points
translate(p1) geomag_ball();
translate(p1) geomag_ball();
translate(p2) geomag_ball();
translate(pp1) geomag_ball();
translate(pp2) geomag_ball();
*/


delta_geomag_link = [2,5]; // w,l links
/*
geomag_rod_y();
geomag_ball_pos([0,0.5]);
geomag_ball_pos([0,-0.5]);
*/
module geomag_support() {
    w = geomag_rod_radius()*2;
    l = geomag_rod_length();
    dw = delta_geomag_link[0];
    dl = delta_geomag_link[1];
    b = geomag_ball_radius;
    // under geomag
    square([w,l], center=true);
    // with spaces for links
    square([w+dw*2,l-dl*2], center=true);
    // and minimum leg
	vcad_tx(w/2+dw)
//		vcad_square([b-w/2,l], centery=true);
		vcad_square([b-w/2,l-dl*2], centery=true);
}

module effector_support() {
	l = geomag_rod_length();
	dw = delta_geomag_link[0];
	b = geomag_ball_radius;
	vcad_tx(10+b+dw)
		square([20,l+4*b], center=true);
}

//geomag_rod_y();
vcad_triple()
	vcad_tx(-effector_radius)
		geomag_support();
hull()
	vcad_triple()
		vcad_tx(-effector_radius)
			effector_support();

effector_geomags();
