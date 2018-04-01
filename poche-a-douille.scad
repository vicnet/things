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
cone();

//------  motifs ----------

// 
module dent() {
    // largeur de la dent vers l'intérieur
    ld = 2.4;
    hd = 1;
    pd = 2;
    // mise en place
    vrz(180) vtx(e) vtz(-e/2) vreinfor([ld,pd,ld],e=e/2);
}

vtz(h)
  vduplicate_rot(n=VZ, $fn=6, r=r)
    dent();
