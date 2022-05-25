module test_square(stiffness) {
    cube([25, 25, stiffness]);
}

for (i = [
        [0.2, [-35, -35, 0]], [0.4, [0, -35, 0]], [0.6, [35, -35, 0]],
        [0.8, [-35,   0, 0]], [1.0, [0,   0, 0]], [1.2, [35,   0, 0]],
        [1.4, [-35,  35, 0]], [1.6, [0,  35, 0]], [1.8, [35,  35, 0]],
    ]) {
    stiffness = i[0];
    offset = i[1];
    translate(offset) test_square(stiffness = stiffness);
}