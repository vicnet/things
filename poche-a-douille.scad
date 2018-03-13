/**
 * Poche à douille.
 * TODO ajouter la partie coté poche (+anneau de vissage)
 * TODO utiliser une image pour la forme à extraire...
 */

include <vcad/constants.scad>
use <vcad/shapes.scad>
use <vcad/transform.scad>
use <vcad/duplicate.scad>

// base: rayon exterieur
rext = 24/2;
// base: rayon intérieur
rint = 17/2;
// base: hauteur
hbase = 1.4;
// epaisseur des parois
e = 1.6;
// cone (partie haute): rayon extérieur
r = 18/2;
// cone: hauteur totale
h = 26;

// cone = base + tube
module cone() {
    dbase = rext-rint;
    vtube(hbase,rext,dbase);
    vtube(h,r1=rint+e,r2=r,e);
}

// cone de base
//cone();

//------  motifs ----------

// 
module dent() {
    // largeur de la dent vers l'intérieur
    ld = 2.4;
    hd = 1;
    pd = 2;
    // mise en plasce
    vtz(h)
    vtx(-e/2) // décalage vers l'intéieur de l'epaisseur
    difference() {
//    union() {
        // dent avec rebord
        vcube(x=-e/2-ld,y=pd,z=-hd-ld, centery=true);
        // arrondi du rebord
        vtx(-ld-e/2)
        vty(+pd/2+VEPSILON)
        vtz(-ld-hd)
        vrx(90) // rotation
        cylinder(h=pd+VEPSILON*2,r=ld,$fn=30);
    }
}

//vduplicate_rot(n=VZ, $fn=6, r=r)
//    dent();

module renfort(size, e=0, x,y,z, ex, ez) {
    s = vpoint(size, x, y, z);
    ex = vopt(ex,e);
    ez = vopt(ez,e);
    ns = s+[ex,0,ez];
    vtz(-s.z)
    difference() {
        vtx(-ex)
        vcube(ns,centery=true);
//        resize(s)
        scale([1,1,s.z/s.x])
        vtx(s.x)
        vrx(90) // rotation on XZ plane
        cylinder(h=s.y+VEPSILON*2,r=s.x,$fn=30,center=true);
    }
}

renfort([10,1,10],e=1);
//renfort([10,1,15]);
