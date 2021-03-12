include <vcad/constants.scad>

use <vcad/colors.scad>
use <vcad/duplicate.scad>
use <vcad/shapes.scad>
use <vcad/duplicate.scad>


h=10; // hauteur de la base, h total = 2*h

module pied_arriere() {
    l=32; // largeur/longueur du pied

    module pied(e=0) {
        vcube([l+e,l+e,h], true, centerz=false);
    }

    vtz(-h) pied();

    difference() {
        pied(7);
        vtz(2) pied(2);
    }

    vduplicate_rot(n=VZ, r=l/2, $fn=4)
    vreinfor([3,l,3]);

    //vred() pied();
}

la1 = 32;

module pied_avant() {
    la2 = 41;
    lo = 38;
    module pied(e=0) {
        module forme() {
            pts = [[e,-e], [-la1-e,-e], [-la2-e*1.5,lo+e], [e,lo+e]];
            vtx(la1/2) vty(-lo/2) polygon(pts);
        }
        linear_extrude(h) forme();
    }

    vtz(-h) pied();

    difference() {
        pied(7);
        vtz(2) pied(2);
    }

    vtx(la1/2) vreinfor([3,la2,3]);
    vty(-la2/2+1.6) vrz(-90) vreinfor([3,la1+2,3]);
    vty(la2/2) vtx(-5) vrz(90) vtx(-1.4) vreinfor([3,la2+2,3]);
    vtx(-la1/2-5) vrz(193) vreinfor([3,la2,3]);
}

//vtx(-la1/2-8)
//pied_avant();
mirror() /*vtx(-la1/2-8) */ pied_avant();