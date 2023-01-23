//
//  Hexagonal grid generator
//  Joris Bots - August 2020
//

/* [Global] */
// length of a hexagon side 
s = 6;   //[1:20] 
// distance between hexagons (grid width )
d = 2;   //[0.5:10] 
// number of hexagons in x direction (even numbers only!)
x = 20;  //[2:100]
// number of hexagons in y direction (even numbers only!)
y = 30;  //[2:100]
// height of the grid plate
h = 5;   //[1:10]

difference(){
translate([-s-(hexvspace()), -(hexheight()/2)-hexhspace(),0])
    cube([hexhspace()+x*hexhdist()+s/2,                          
          (hexvspace()+hexheight()/2)+hexvspace()/2+((hexheight() + hexvspace() ) * y/2),h]);
    

    for (j = [1:2:y]){
        for (i = [1:2:x]){
            translate([(s+(s/2)+hexhspace())*(i-1),(hexheight()/2+d/2)*j])hex(s);
            translate([(s+(s/2)+hexhspace())*i,(hexheight()/2+d/2)*(j-1)])hex(s);
        }
    }
}

module hex(l){
    $fn = 6;
    linear_extrude(h)circle(l);
}

function hexheight() = sqrt(3)*(s);       // vertical height of a hex
function hexvspace() = d;                 // vertical space between two hex
function hexhspace() = sqrt(3)*d/2;       // horizontal space between two hex
function hexhdist()  = 1.5*s+hexhspace(); // horizontal distance between two hex centres
