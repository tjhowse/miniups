batt_holder_xy = 21.5;
batt_holder_z = 78;
bms_x = 5;
wt = 2;
$fn = 24;
screw_hole_r = 2;
wire_hole_r = 2;

module holder() {
    cube([batt_holder_xy, batt_holder_xy, batt_holder_z]);
}
module bms() {
    cube([batt_holder_xy, bms_x, batt_holder_z]);
}
module holders() {
    holder();
    translate([0,-bms_x,0]) bms();
    translate([batt_holder_xy,0,0]) holder();
    translate([-batt_holder_xy,0,0]) holder();
    translate([0, batt_holder_xy,0]) holder();

}

module case_whole () {
    difference () {
        minkowski() {
            holders();
            sphere(r=wt);
        }
        holders();
    }
}

post_xy = wt;

module align_post() {
    cube([post_xy,post_xy,wt]);
}

module lid() {
    difference () {
        case_whole();
        translate([0,0,51]) cube([100,100,100], center=true);
        translate([batt_holder_xy/2,batt_holder_xy/2,-50]) cylinder(r=screw_hole_r,h=100);
        translate([batt_holder_xy/2,-bms_x/2,-50]) cylinder(r=wire_hole_r,h=100);
    }
    translate([-batt_holder_xy,0,0]) align_post();
    translate([-batt_holder_xy,batt_holder_xy-post_xy,0]) align_post();
    translate([batt_holder_xy*2-post_xy,0,0]) align_post();
    translate([batt_holder_xy*2-post_xy,batt_holder_xy-post_xy,0]) align_post();
    translate([0,batt_holder_xy*2-wt,0]) align_post();
    translate([batt_holder_xy-wt,batt_holder_xy*2-wt,0]) align_post();
    translate([0,-bms_x,0]) align_post();
    translate([batt_holder_xy-wt,-bms_x,0]) align_post();
}

module case () {
    difference () {
        case_whole();
        translate([0,0,-50]) cube([100,100,100], center=true);
    }
}


rotate([180,0,0]) case();
// lid();
