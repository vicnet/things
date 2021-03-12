include <trafic.scad>

// taille plancher
d_plancher = [161, 246, 1.5];
p_plancher = [0,0,VEPSILON];

module plancher() {
    d = d_plancher;
    p = p_plancher;
    
    delta = 1.5;
    module creux_roue() {
        vtr(p_passage)
        vtr(-delta, 0, -d.z)
        linear_extrude(d.z*3) vsquare_rounded(d_roue+[delta*2,delta*2], r_passage, centery=true);
    }
    module creux_bloc() {
        d = p_passage.y-d_roue.y/2+delta*3;
        vtr(p_bloc)
            vtr(-delta, -delta,-delta)
                vcube([d_bloc.x+delta*3, d, delta*3]);
    }
    module creux_marche() {
        m = d_marche;
        p = p_marche;
        vtr([p.x,p.y,-VEPSILON])
            vcube([m.x+VEPSILON,m.y,d.z+2*VEPSILON]);
    }
    module creux_aeration() {
        e = 0.5+delta;
        r = r_aeration;
        l1 = d_aeration.x+e*2;
        l2 = l1-6;
        h = d_aeration.y+e;
        forme = [ [-l2/2,-delta], [l2/2,-delta], [l1/2,h+delta], [-l1/2,h+delta] ];
        rs = [r,r,1,1];
        p = p_aeration;
        vtr([p.x,p.y+delta,-delta]) vty(-e) linear_extrude(delta*3)
            polygon(vround_path(forme,rs));
    }
    module creux_sol_haut() {
        vtz(-delta) vty(-delta) {
            d = d_sol_haut+[delta*2,0,0];
            p = p_sol_haut;
            yr = 10;
            r1 = 5;
            r2 = 20;
            forme = [ [-d.x/2,0], [-d.x/2,r1], [d.x/2,r1], [d.x/2,0], [d.x/2,d.y-r1], [-d.x/2,d.y-r1] ];
            rs = [0,[r1,r2],[r2,r1],0,0,0];
            base = vround_path(forme,rs);
            h=[0,0,3*delta];
            vtr([p.x,p.y-r1,p.z])
                vextrude_face(base,h);
        }
    }
    vtr(p) difference() {
        vcube(d_plancher, centerx=true);
        creux_roue();
        mirror(VX) creux_roue();
        creux_bloc();
        creux_marche();
        creux_aeration();
        creux_sol_haut();
    }
}

color("Burlywood") plancher();
