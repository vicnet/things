include <vcad/constants.scad>
use <vcad/figures.scad>
use <vcad/shapes.scad>
use <vcad/transform.scad>
use <vcad/duplicate.scad>

// hauteur de la fixation
h = 80;
// largeur du porte-recette
l = 100;
// largeur du support
p = 40;
// hauteur bloqueur
b = 5;
// epaisseur des parois
e = 5;
// largeur accroche
la = 2;
// hauteur accroche
ha = 1;

module forme() {
    module support(p) {
        vsquare(x=e,y=p,centerx=true);
        vty(p/3) bloqueur(ha, la);
        vty(2*p/3) bloqueur(ha, la);
        
    }

    module fixation() {
        vsquare(x=h,y=e,center=true);
        vtx(h/2) vty(-e/2) varc(r=e,a=90);
    }

    module bloqueur(b, l=e) {
        x = b+e/2-l/2;
        vsquare(x=x+VEPSILON,y=-l);
        vtx(x) vty(-l) varc(r=l,a=90);
    }

    fixation();
    support(p);
    vty(p) bloqueur(b);
}

module renfort() {
    vtx(-e/2) vty(e/2)
    vrx(90) vry(90)
    vreinfor([p-e/2,e,h/2-e/2]);
}

module porteur()
{
    difference() {
        linear_extrude(height=l,convexity=4) forme();
        vtz(3*l/4) vtx(h/3) vrx(90) cylinder(h=e+VEPSILON*2,d=3, $fn=20,center=true);
        vtz(l/4) vtx(h/3) vrx(90) cylinder(h=e+VEPSILON*2,d=3, $fn=20,center=true);
    }
    vtz(e/2) renfort();
    vtz(l-e/2) renfort();
}


vtx(l/2)
vrz(-90)
vrx(90)
porteur();
