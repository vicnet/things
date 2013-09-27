use <vcad/shapes.scad>
use <vcad/transform.scad>
include <vcad/constants.scad>

geomag_ball_radius = 12.7/2;
geomag_rod_sizes = [26.8,7.4/2]; // length, radius
geomag_dimple_deph = 0.43; // depth connection ball-rod

module geomag_ball() {
	color("LightSteelBlue")
		sphere(geomag_ball_radius);
}

module geomag_rod() {
	l = geomag_rod_sizes[0];
	r = geomag_rod_sizes[1];
	color("red")
		cylinder(h=l-2, r=r-0.6, center=true, $fn=6);
	
	hcap = 5.8;
	module cap() {
		color("red") {
			vcad_tz(2)
				vcad_tube(height=hcap-3, radius=r, thickness=1, $fn=30);
			vcad_tz(hcap-1)
				vcad_tore(outer=r, inner=1, $fn=15);
			cylinder(h=2, r1=r-1, r2=r, $fn=30);
		}
		color("LightSteelBlue") 
			vcad_tz(hcap-1+VCAD_EPSILON)
				circle(r-1);
	}
	vcad_symetric(axe=[1,0,0])
		vcad_tz(l/2-hcap)
			cap();
}

*geomag_ball();
*geomag_rod();

module geomag_pos(pos=[0,0,0]) {
    l = geomag_rod_sizes[0];
    r = geomag_ball_radius - geomag_dimple_deph;
    d = 2*r+l;
    translate(d*pos)
        child();
}

module geomag_rod_pos(pos=[0,0,0]) {
    geomag_pos(pos)
    if ((pos[0]*2)%2!=0) {
        rotate([0,90,0])
        geomag_rod();
    } else if ((pos[1]*2)%2!=0) {
        rotate([90,0,0])
        geomag_rod();
    } else {
        geomag_rod();
    }
}

module geomag_ball_pos(pos=[0,0,0]) {
    geomag_pos(pos)
        geomag_ball();
}

geomag_ball_pos();
geomag_ball_pos([0,0,1]);
geomag_ball_pos([1,0,0]);
geomag_ball_pos([0,1,0]);
geomag_rod_pos([0,0,0.5]);
geomag_rod_pos([0.5,0,0]);
geomag_rod_pos([0,0.5,0]);
