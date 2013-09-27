use <vcad/shapes.scad>
use <vcad/transform.scad>
include <vcad/constants.scad>

geomag_ball_radius = 12.7/2;
geomag_rod_sizes = [26.8,7.4/2]; // length, radius
geomag_dimple_deph = 0.43; // depth connection ball-rod


granularity = 30;

module geomag_ball() {
	color("LightSteelBlue")
		sphere(geomag_ball_radius, $fn=granularity/2);
}

module geomag_rod(color="red") {
	l = geomag_rod_sizes[0];
	r = geomag_rod_sizes[1];

	module beam() {
		color(color)
			cylinder(h=l-2, r=r-0.6, center=true, $fn=6);
	}
	
	hcap = 5.8;
	module cap() {
		color(color) {
			vcad_tz(2)
				vcad_tube(height=hcap-3, radius=r, thickness=1, $fn=granularity);
			vcad_tz(hcap-1)
				vcad_tore(outer=r, inner=1, $fn=granularity/2);
			cylinder(h=2, r1=r-1, r2=r, $fn=granularity);
		}
		color("LightSteelBlue") 
			vcad_tz(hcap-1+VCAD_EPSILON)
				circle(r-1);
	}

	// assembly
	beam();
	vcad_symetric(axe=[1,0,0])
		vcad_tz(l/2-hcap)
			cap();
}

module geomag_pos(pos=[0,0,0]) {
    l = geomag_rod_sizes[0];
    r = geomag_ball_radius - geomag_dimple_deph;
    d = 2*r+l;
    translate(d*pos)
        child();
}

module geomag_rod_x(color="red") {
	rotate([0,90,0])
		geomag_rod(color);
}

module geomag_rod_y(color="red") {
	rotate([90,0,0])
		geomag_rod(color);
}

module geomag_rod_z(color="red") {
	geomag_rod(color);
}
	
module geomag_rod_pos(pos=[0,0,0], color="red") {
    geomag_pos(pos)
		if ((pos[0]*2)%2!=0) {
			geomag_rod_x(color);
		} else if ((pos[1]*2)%2!=0) {
			geomag_rod_y(color);
		} else {
			geomag_rod_z(color);
		}
}

module geomag_ball_pos(pos=[0,0,0], color="red") {
    geomag_pos(pos)
        geomag_ball();
}

module geomag_chair() {
	for (x=[0,1], y=[0,1]) {
		geomag_ball_pos([x,y,1]);
		geomag_rod_pos([x,y,0.5]);
	}
	for (x=[0,1]) {
		geomag_rod_pos([0.5,x,1]);
		geomag_rod_pos([x,0.5,1]);
	}
	for (x=[0,1]) {
		geomag_ball_pos([x,0,2]);
		geomag_rod_pos([x,0,1.5]);
	}
	geomag_rod_pos([0.5,0,2]);
}

// use <openscad geomag.scad -D example=x -o geomag.xxx> to generate examples output
example=5;

if (example==1) {
	geomag_ball();
}
if (example==2) {
	geomag_rod("yellow");
}
if (example==3) {
	geomag_ball_pos([0,0,0]);
	geomag_ball_pos([0,0,1]);
	geomag_rod_pos([0,0,0.5]);
}
if (example==4) {
	geomag_chair();
}
if (example==5) {
	geomag_ball();
	geomag_pos([0.5,0,0])
		geomag_rod_x("green");
	geomag_pos([0,0.5,0])
		geomag_rod_y("lightblue");
	geomag_pos([0,0,0.5])
		geomag_rod_z("red");
}
