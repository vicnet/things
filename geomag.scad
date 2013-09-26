use <vcad/shapes.scad>
use <vcad/transform.scad>
include <vcad/constants.scad>

geomag_ball_radius = 12.7/2;
geomag_rod_sizes = [27,7.4/2]; // length, radius
geomag_dimple_deph = 0.43; // depth connection ball-rod

module geomag_ball() {
	color("LightSteelBlue")
		sphere(geomag_ball_radius);
}

module geomag_rod() {
	l = geomag_rod_sizes[0];
	r = geomag_rod_sizes[1];
	color("red")
		cylinder(h=l-2, r=r-0.5, center=true, $fn=8);
	
	hcap = 4;
	module cap() {
		color("red") {
			vcad_tz(1)
				vcad_tube(height=hcap-2, radius=r, thickness=1, $fn=30);
			vcad_tz(hcap-1)
				vcad_tore(outer=r, inner=1, $fn=15);
			cylinder(h=1, r1=r-1, r2=r, $fn=30);
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
geomag_rod();
