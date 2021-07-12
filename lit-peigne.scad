include <vcad/vcad.scad>
include <vcad/colors.scad>
include <vcad/transform.scad>
include <vcad/shapes.scad>
include <vcad/path.scad>

// % fermeture
ferme = 0; // [0:10:100]

/* dimensions générales */
// hauteur total lit
h = 44;
// largeur/profondeur lit
p = 120;
// longueur lit
l = 180;
// hauteur coussins
hc = 10;
// largeur latte
l_latte=8;
// espacement lattes
esp_latte = l_latte*2.25;

/* dimensions techniques */
// section tasseau
e = 4.4;
d = p/2-2*e; // déplacement peigne
pf = 3*e+d; // profondeur cadre fixe
hp = h-hc-2*e; // hauteur des pieds

module cadre(fixe=true) {
    module lattes() {
        module latte() {
            r= pf*4;
            intersection() {
                vtr([0,pf/2,-r+hp+2*e+3]) vry(90) vtube(l_latte,r,1,$fn=100);
                vcube([l,pf,h], centerx=true);
            }
        }
        ll = l_latte;
        for (x = [-l/2:esp_latte:l/2-ll/2]) {
            vtx(x) latte();
        }
    }
    module traverse() {
        vcube([l,e,e], centerx=true);
    }
    color("Burlywood") {
        vtz(hp+e) {
            traverse();
            vty(pf-e) traverse();
        }
    }
    vtx(fixe ? 0:esp_latte/2) lattes();
}

// cadre fixe
module cadre_fixe() {
    module pied(centerx) {
        vcube([e,e,hp],centerx=centerx);
    }
    module traverse_cote(centerx) {
        vcube([e,pf,e],centerx=centerx);
    }
    module cote(centerx) {
        pied(centerx);
        vty(pf-e) pied(centerx);
        vtz(hp) traverse_cote(centerx);
    }

    color("Burlywood") {
        vtx(-l/2) cote();
        vtx(l/2-e) cote();
        cote(centerx=true);
    }
    cadre(true);
}

module cadre_mobile() {
    module pied(centerx) {
        vcube([e,e,hp+e],centerx=centerx);
    }
   vty(-e) {
        cadre(false);
        color("Burlywood") {
            pied(centerx=true);
            vtx(-l/2) pied();
            vtx(l/2-e) pied();
        }
   }
}

cadre_fixe();
vty(-d*ferme/100)
    cadre_mobile();

include <vcad/duplicate.scad>
module matelas() {
    function face(x, a=90) =
        let(r=2)
        let(h=hc/2-r+r*sin(a), l=p/4-r+r*sin(a))
        let(x=x+r*cos(a))
        let(forme = [ [x,-l,-h], [x,-l,h], [x,l,h], [x,l,-h] ])
        let(rs = [for(i=[0:4]) r])
        vround_path(forme,rs,$fn=6);
    //polygon(base);
    //vduplicate_simple(face()) sphere();
    faces = concat([ face(-50) ]
                 , [ for(a=[90:-15:0]) face(0,a) ]);
    vpoly_faces(faces);
}
vwhite() matelas();
