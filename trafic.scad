include <vcad/vcad.scad>
include <vcad/colors.scad>
include <vcad/transform.scad>
include <vcad/figures.scad>
include <vcad/shapes.scad>
include <vcad/path.scad>
include <vcad/extrude.scad>

// taille plancher
d_sol = [161, 300, -1];
// taille et position passage de roues
d_roue = [18, 77, 29];
p_passage = [d_sol.x/2-d_roue.x, 78.5];
r_passage = 5; 
// bloc plastique arrière
d_bloc = [19, 60, 63];
p_bloc = [d_sol.x/2-d_bloc.x, 0];
// marche-pied
d_marche = [20,68,10];
p_marche = [d_sol.x/2-d_marche.x, 160, -d_marche.z];
// aeration au sol
d_aeration = [45,27,5];
p_aeration = [0,219,0];
r_aeration = 4;  // courbure de la forme
// partie haute du sol
d_sol_haut = [161,d_sol.y-246,11];
p_sol_haut = [0,246,0];
// portes arrières
d_porteg = [73,11,129];
p_porteg = [-3,-d_porteg.y,0];
d_ported = [66,11,129];
p_ported = [3,-d_porteg.y,0];
// fenetre et paroi arrière
dfenetre_arriere=[8,100,127+d_marche.z];
pfenetre_arriere=[-d_sol.x/2-dfenetre_arriere.x,12,-d_marche.z];
// fenetre et paroi avant
dfenetre_avant=[8,118,127+d_marche.z];
pfenetre_avant=[-d_sol.x/2-dfenetre_avant.x,pfenetre_arriere.y+dfenetre_arriere.y,-d_marche.z];
// sièges
d_siege = [50,60,114];
p_siege = [15,p_sol_haut.y+20,d_sol_haut.z];
// renflement milieu
dmilieu_bas=[4,27,67];
dmilieu_haut=[3,10,127-dmilieu_bas.z];
pmilieu=[-d_sol.x/2,pfenetre_arriere.y+dfenetre_arriere.y,0];
// coins arrières
d_coin=[14,12,127];
p_coin=[-d_sol.x/2,0,0];

lateral_ouvert = false;


/* Modèle de van */

module passage() {
    //vcube(d_roue,centery=true);

    // taille arrondi
    a = r_passage;
    // taille restante
    d = d_roue.y - d_roue.z*2;
    
    module plat() {
        vcube([d_roue.x, d+VEPSILON, d_roue.z-a], centery=true);
        vtx(a)
          vcube([d_roue.x-a, d, d_roue.z], centery=true);
        vtz(d_roue.z-a) vtx(a)
          vrx(-90)
            vcyl(d, a, center=true);
    }
    
    module arrondi() {
        intersection() {
            vcube([d_roue.x, d_roue.z, d_roue.z]);
            vry(90) vtz(a) {
                vrx(180) vtore_cap(d_roue.z, a);
                vtz(-VEPSILON) vcyl(d_roue.x-a+VEPSILON, d_roue.z);
            }
        }
    }

    module arrondis() {
        vty(d/2) arrondi();
        vty(-d/2) mirror(VY) arrondi();
    }
 
    plat();
    arrondis();
}

module passage_droit() {
    vtr(p_passage)
        passage();
}
module passage_gauche() {
    mirror(VX)
        vtr(p_passage)
            passage();
}

module passages() {
    passage_droit();
    passage_gauche();
}

module bloc() {
    module plein() {
        intersection() {
            vcube(d_bloc);
            union() {
                h = d_bloc.z-d_roue.z;
                vty(2.2) vtz(12)
                    vrx(15) vcube(d_bloc);
                // bas
                vcube([d_bloc.x, d_bloc.y, d_roue.z-1]);
                // h_plateau
                h_plateau = 4.5;
                vtz(d_bloc.z-h_plateau)
                vcube([d_bloc.x, d_bloc.y, h_plateau]);
            }
        }
    }
    module creux() {
        a = r_passage;
        d = d_roue.y - d_roue.z*2;
        delta = 1;
        vtr(-delta, -d/2-delta, delta) vry(90) vty(p_passage.y) vtz(a) {
            vrx(180) vtore_cap(d_roue.z, a);
            vtz(-VEPSILON) vcyl(d_roue.x-a+delta*2, d_roue.z);
        }
    }
    vtr(p_bloc)
        difference() {
            plein();
            creux();
        }
}

module marche() {
    m = d_marche; // raccourcis
    module creux() {
        r1 = 9; // rayon 1ere courbe gauche
        r2 = 20; // rayon 2eme courbe droite
        e = 3; // epaisseur de la marche
        bord = [ [0,m.z], [0,0], [m.y,0], [m.y,m.z] ];
        rs_bord = [ 0   , r1   , [r2,m.z]     , 0 ];
        ext = [
              [m.y+e, m.z]
            , [m.y+e, -e]
            , [-e, -e]
            , [-e,m.z]
        ];
        rs_ext = [0,0,0,0];
        rs = concat(rs_bord, rs_ext);
        forme = concat(bord,ext);
        vrz(90) vrx(90)
            linear_extrude(m.x)
                polygon(vround_path(forme,rs));
        // fond
        vcube([-e,m.y,m.z]);
    }
    module rebord() {
        l1 = 30; // largeur bord gauche
        h1 = 9; // hauteur bord gauche
        r1 = 5; // rayon bord gauche
        l2 = 12.5; // largeur partie droite
        h2 = 5.5; // hauteur partie haute
        r2 = 5.5; // rayon partie haute
        bord = [ [m.x,m.y+10], [m.x,m.y], [0,m.y], [0,0], [m.x,0], [m.x,-l1] ];
        ext = [ [m.x-h1,-l1], [m.x-h1,-h2], [-h2,-h2], [-h2,m.y+r2+l2] ];
        forme = concat(bord,ext);
        rs_bord = [ for (i=vindexes(bord)) 0 ];
        rs_ext = [ r1, r1, r2, r2];
        rs = concat(rs_bord, rs_ext);
        linear_extrude(1) polygon(vround_path(forme,rs));
    }
    vtr(p_marche) {
        creux();
        vtz(m.z) rebord();
    }
}

module sol() {
    module creux_marche() {
        m = d_marche;
        vtz(m.z-1) vtr(p_marche) vcube([m.x+1,m.y,3],centerz=true);
    }

    difference() {
        vcube(d_sol, centerx=true);
        creux_marche();
    }
}

module aeration()
{
    module base(e=0) {
        r = r_aeration;
        l1 = d_aeration.x+e*2;
        l2 = l1-6;
        h = d_aeration.y+e;
        forme = [ [-l2/2,0], [l2/2,0], [l1/2,h-e], [-l1/2,h-e] ];
        rs = [r,r,1,1];
        vty(-e) linear_extrude(VEPSILON)
            polygon(vround_path(forme,rs));
    }
    module rebord() {
        h = 0.5;
        hull() {
            base(h);
            vtz(h) base(h);
        }
    }
    module bloc() {
        hull() {
            base();
            vtz(4) vrx(2) base(-4);
        }
    }
    vtr(p_aeration) {
        rebord();
        bloc();
    }
}

module sol_haut() {
    d = d_sol_haut;
    p = p_sol_haut;
    yr = 10;
    r1 = 5;
    r2 = 20;
    function base() =
        let(forme = [ [-d.x/2,0], [-d.x/2,r1], [d.x/2,r1], [d.x/2,0], [d.x/2,d.y-r1], [-d.x/2,d.y-r1] ])
        let(rs = [0,[r1,r2],[r2,r1],0,0,0])
        vround_path(forme,rs);
    module sol_haut_base() {
        function base() =
            let(forme = [ [-d.x/2,0], [-d.x/2,r1], [d.x/2,r1], [d.x/2,0], [d.x/2,d.y-r1], [-d.x/2,d.y-r1] ])
            let(rs = [0,[r1,r2],[r2,r1],0,0,0])
            vround_path(forme,rs);
        h = [0,yr,d.z];
        vtr([p.x,p.y-r1,p.z])
            vextrude_face(base(),h);
    }
    sol_haut_base();
    vtr([p.x,p.y-r1,p.z]) {
        vty(yr+r1) vcube([d.x,d.y-yr,d.z],centerx=true);
    }
}

module porte_arriere(gauche) {
    d = gauche ? d_porteg : d_ported;
    p = gauche ? p_porteg : p_ported;

    df = [d.x,d.y,59];
    pf = [0,0,60];

    module coin_fenetre(bas=true) {
        // profondeurs porte bas et haut
        y2 = 7;
        y1 = bas ? d.y : y2;
        // grand rayon fenetre
        r = 10;
        // arrondis rebords
        r2 = 2;
        r1 = bas ? 5 : r2;
        // position du centre de rotation
        o = [3+r+r2,y1,4+r+r1];

        function rebord_coin(o, a=0) =
            // retourne une face avec un angle <a>
            let(ma=50)
            let(i=a<ma ? 0 : (a-ma)/(90-ma))
            let(o = a<ma ? o : [o.x,y1+(y2-y1)*i,o.z])
            let(r1 = a<ma ? r1 : r1+(r2-r1)*i)
            let(t=1-tan(a))
            let(p1=[o.x-sin(a)*r,o.z-cos(a)*r])
            let(p2 = t>0 ? [o.x*t,0] : [0,o.z-o.z/tan(a)])
            let(pts = [ [p1.x,o.y,p1.y],[p2.x,o.y,p2.y],[p2.x,0,p2.y],[p1.x,0,p1.y] ])
            let(rs = [r1,0,0,0])
            vround_path(pts,rs,$fn=4);
        // calcule les faces de l'arrondis
        faces = [
              rebord_coin([df.x/2,o.y,o.z])
            , for (a=[0:15:90]) rebord_coin(o, a)
            , rebord_coin([o.x,o.y,df.z/1.5],90)
        ];
        vtr(pf) vpoly_faces(faces);
    }
    
    module coins_fenetre() {
        coin_fenetre(true);
        vtz(p.z+d.z+df.z) mirror(VZ) coin_fenetre(false);
        vtx(df.x) mirror(VX) {
            coin_fenetre(true);
            vtz(p.z+d.z+df.z) mirror(VZ) coin_fenetre(false);
        }
    }
    
    module protection() {
        dp = [d.x-8,1,pf.z-4];
        pp = [4,d.y,3];
        r = 5;
        vtr(pp) {
            pts = [ [0,0,0], [dp.x,0,0], [dp.x,0,dp.z], [0,0,dp.z]];
            rs = vvect(4,r);
            face = vround_path(pts,rs);
            vextrude_face(face,[0,dp.y,0]);
            *vcube(dp);
        }
    }

    vtr(p) {
        color("White") {
            vcube([d.x,d.y,pf.z], centerx=false);
            coins_fenetre();
        }
        color("Gray") {
            protection();
        }
    }
}

module portes_arrieres() {
    porte_arriere(true);
    mirror(VX) porte_arriere(false);
}

function rebord_coin(o, r, r1, b=0, p=V0) =
    // retourne une face avec un angle <a>
    let(a=b%90)
    let(pr=floor(b/90)*90)
    let(t=1-tan(a))
    let(p1=[o.y-sin(a)*r,o.z-cos(a)*r])
    let(p2=t>0 ? [o.y*t,0] : [0,o.z-o.z/tan(a)])
    let(p1r=vrotate2d(pr)*p1)
    let(p2r=vrotate2d(pr)*p2)
    let(pts = [ [o.x,p1r.x,p1r.y],[o.x,p2r.x,p2r.y],[0,p2r.x,p2r.y],[0,p1r.x,p1r.y] ])
    let(rs = [r1,0,0,0])
    vround_path(vadd(pts,p),rs,$fn=4);


    
module fenetre_arriere() {
    d = dfenetre_arriere;
    p = pfenetre_arriere;
    // position rebord
    ds=[d.x,88,52];
    ps=[0,7,74+d_marche.z];
    
    module rebord_fenetre() {
        // profondeur
        x1 = ds.x;
        // grand rayon fenetre
        r = 10;
        // arrondis rebords
        r1 = 5;
        // position du centre de rotation
        o = [x1,r+r1,r+r1];

        // calcule les faces de l'arrondis
        dcoin = 25-r;
        faces = [
            rebord_coin(o,r,r1, 90-VEPSILON, [0,0,dcoin]),
            for (a=[270:15:359]) rebord_coin(o,r,r1, a, [0,0,ds.z]),
            for (a=[180:15:269]) rebord_coin(o,r,r1, a, [0,ds.y,ds.z]),
            for (a=[90:15:179]) rebord_coin(o,r,r1, a, [0,ds.y,0]),
            for (a=[0:15:45]) rebord_coin(o,r,r1, a, [0,dcoin,0]), 
            for (a=[45:15:89]) rebord_coin(o,r,r1, a, [0,0,dcoin]),
            rebord_coin(o,r,r1, 90-VEPSILON, [0,0,dcoin]),
        ];
        vtr(ps) vpoly_faces(faces);
    }
    module creux() {
        pts = [[0,0,0],[0,ds.y,0],[0,ds.y,ds.z],[0,0,ds.z]];
        face = vround_cut_path(pts,[15,0,0,0]);
        vtx(-VEPSILON) vtr(ps) vextrude_face(face,(d.x+2*VEPSILON)*VX);
    }
    module protection() {
        dp = [2,d.y,67];
        pp = [d.x,0,d_marche.z];
        vtr(pp) vcube(dp);
    }
    
    vtr(p) {
        vwhite() {
            difference() {
                vcube(d);
                creux();
            }
            rebord_fenetre();
        }
        color("Gray") {
            protection();
        }
    }
}

module fenetres_arrieres() {
    fenetre_arriere();
    mirror(VX) fenetre_arriere();
}

module fenetre_avant() {
    d = dfenetre_avant;
    p = pfenetre_avant;
    // position rebord
    ds=[d.x,107,52];
    ps=[0,7,74+d_marche.z];
    
    module rebord_fenetre() {
        // profondeur
        x1 = ds.x;
        // grand rayon fenetre
        r = 10;
        // arrondis rebords
        r1 = 5;
        // position du centre de rotation
        o = [x1,r+r1,r+r1];

        // calcule les faces de l'arrondis
        dcoin = 25-r;
        faces = [
            rebord_coin(o,r,r1, 90-VEPSILON, [0,0,dcoin]),
            for (a=[270:15:359]) rebord_coin(o,r,r1, a, [0,0,ds.z]),
            for (a=[180:15:269]) rebord_coin(o,r,r1, a, [0,ds.y,ds.z]),
            for (a=[90:15:134]) rebord_coin(o,r,r1, a, [0,ds.y,dcoin]),
            for (a=[135:15:179]) rebord_coin(o,r,r1, a, [0,ds.y-dcoin,0]),
            //for (a=[90:15:179]) rebord_coin(o,r,r1, a, [0,ds.y,0]),
            for (a=[0:15:45]) rebord_coin(o,r,r1, a, [0,dcoin,0]), 
            for (a=[45:15:89]) rebord_coin(o,r,r1, a, [0,0,dcoin]),
            rebord_coin(o,r,r1, 90-VEPSILON, [0,0,dcoin]),
        ];
        vtr(ps) vpoly_faces(faces);
    }
    module creux() {
        pts = [[0,0,0],[0,ds.y,0],[0,ds.y,ds.z],[0,0,ds.z]];
        face = vround_cut_path(pts,[15,25,0,0]);
        vtx(-VEPSILON) vtr(ps) vextrude_face(face,(d.x+2*VEPSILON)*VX);
    }
    
    module protection() {
        dp = [2,d.y,67];
        pp = [d.x,0,d_marche.z];
        vtr(pp) vcube(dp);
    }
    
     vtr(p) {
        vwhite() {
            difference() {
                vcube(d);
                creux();
            }
            rebord_fenetre();
        }
        color("Gray") {
            protection();
        }
    }
}

module porte_lateralle() {
    d = dfenetre_avant;
    v = lateral_ouvert ? [d.x+1,-d.y+10,0] : V0;
    vtr(v)
        mirror(VX) fenetre_avant();
}

module fenetres_avants() {
    fenetre_avant();
    porte_lateralle();
}

module milieu() {
    db = dmilieu_bas;
    dh = dmilieu_haut;
    p = pmilieu;
    
    function face(z=0) =
        let(d=z<=db.z ? db : dh)
        let(pts = [[0,-d.y/2,z],[0,d.y/2,z],[d.x,d.y/2,z],[d.x,-d.y/2,z]])
        vround_path(pts,[0,0,2,2],$fn=6);
    
    vtr(p) {
        vgray() vextrude_face(face(),db.z*VZ);
        faces = [
              face(db.z)
            , face(db.z+15)
            , face(db.z+dh.z)
            ];
        vwhite() vpoly_faces(faces);
    }
}

module milieux() {
    milieu();
    mirror(VX) milieu();
}

module coin() {
    d = d_coin;
    p = p_coin;
    
    pts = [[0,0,0],[0,d.y,0],[d.x,d.y,0],[d.x,0,0]];
    face = vround_path(pts,[0,0,5,0],$fn=4);
    vtr(p) {
        vwhite() vextrude_face(face,d.z*VZ);
    }
}

module coins()
{
    coin();
    mirror(VX) coin();
}

function squareyz(d) =
    [[0,0,0],[0,d.y,0],[0,d.y,d.z],[0,0,d.z]];
function faceyz(d,rs) = 
    let(pts=squareyz(d))
    vround_path(pts,rs);
module vextrudex(d,rs) {
    face = faceyz(d,rs);
    vextrude_face(face,d.x*VX);
}

module siege() {
    d_assise = [50,60,20];
    p_assise = [0,0,19];
    d_dossier = [50,17,53];
    p_dossier = [0,0,p_assise.z+d_assise.z];
    d_appui_tete = [30,12,21];
    p_appui_tete = [(d_siege.x-d_appui_tete.x)/2,0,p_dossier.z+d_dossier.z+2];
    d_accoudoir = [5,40,10];
    p_accoudoir = [-d_accoudoir.x,3,p_dossier.z+d_dossier.z/2.5];
    
    module assise() {
        vextrudex(d_assise,[[15,45],5,10,0]);
    }
    module dossier() {
        d = d_dossier;
        pts = [[0,0,0],[0,d.y,0],[0,d.y-7,d.z],[0,0,d.z]];
        face = vround_path(pts,[0,5,4,5]);
        vextrude_face(face,d.x*VX);
    }
    module appui() {
        d = d_appui_tete;
        pts = [[0,0,0],[0,d.y,0],[0,d.y-8,d.z],[0,0,d.z]];
        face = vround_path(pts,[3,8,2,2]);
        vextrude_face(face,d.x*VX);
    }
    module accoudoir() {
        d = d_accoudoir;
        pts = [[0,0,0],[0,d.y,0],[0,d.y,d.z-5],[0,0,d.z]];
        face = vround_path(pts,[5,2,2,5]);
        vextrude_face(face,d.x*VX);
    }
    
    vtr(p_siege) {
        vtr(p_assise) assise();
        vtr(p_dossier) dossier();
        vtr(p_appui_tete) appui();
        vtr(p_accoudoir) accoudoir();
    }
}

module sieges() {
    color("DimGrey") {
        siege();
        mirror(VX) siege();
    }
}

/* Assemblage */
module trafic() {
    color("White") passages();

    color("Gray") {
        bloc();
        sol();
        sol_haut();
    }
    color("DimGray") {
        marche();
        aeration();
    }
    portes_arrieres();
    fenetres_arrieres();
    fenetres_avants();
    milieux();
    coins();
    sieges();
}

trafic();
