rear_width = 23;
large_side_depth = 23;
narrow_side_depth = 14.5;
front_width = 10.5;

// heigh of feet 2 for test, 20 for 3/4 in. [2, 20]
height = 2;

linear_extrude(height = height) {
    polygon(points = [[0, 0], [0, rear_width], [large_side_depth, rear_width], [large_side_depth, 0], [large_side_depth, front_width], [narrow_side_depth, 0]]);
}