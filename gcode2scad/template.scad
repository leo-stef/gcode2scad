
first_layer_height = .2;
 
first_layer_width = .4;

layer_height = .3;

layer_width = .4;

module semi_circle_first_layer() {
     difference() {
      translate([0,.05,0]) circle(d=first_layer_height,$fn=20);
      translate([first_layer_height,.05,0]) square(first_layer_height*2, center=true);
    }   
}
module semi_circle() {
     difference() {
      translate([0,0,0]) circle(d=layer_height,$fn=20);
      translate([layer_height,0,0]) square(layer_height*2, center=true);
    }   
}

 module hull_polyline3d_first_layer(points) {
    leng = len(points);
     
     module extr_unit() {  
         
            rotate_extrude(convexity = 2, $fn = 10)
            translate([-.10, 0, 0])
            semi_circle_first_layer($fn = 10);
            
        }
         
    module hull_line3d(index) {
        point1 = points[index - 1];
        point2 = points[index];

        hull() {
            translate(point1) 
                extr_unit();               
            translate(point2) 
                extr_unit();               
        }              
    }
    
    module polyline3d_inner(index) {
        if(index < leng) {
            hull_line3d(index);
            polyline3d_inner(index + 1);
        }
    }
    polyline3d_inner(1);
}

module hull_polyline3d(points) {
    leng = len(points);
     
    module extr_unit() {  
         
            rotate_extrude(convexity = 2, $fn = 20)
            translate([-.05, 0, 0])
            semi_circle($fn = 20);
            
        }
         
    module hull_line3d(index) {
        point1 = points[index - 1];
        point2 = points[index];

        hull() {
            translate(point1) 
                extr_unit();               
            translate(point2) 
                extr_unit();               
        }             
    }
    
    module polyline3d_inner(index) {
        if(index < leng) {
            hull_line3d(index);
            polyline3d_inner(index + 1);
        }
    }
    polyline3d_inner(1);
}

echo(LAYER_HEIGHT=layer_height,LAYER_WIDTH=layer_width); 
