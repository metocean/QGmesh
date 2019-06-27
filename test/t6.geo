// Let's use the geometry from the first tutorial as a basis for this one
Include "t1.geo";

// Delete the left line and replace it with 3 new ones
Delete{ Surface{1}; Curve{4}; }

p1 = newp; Point(p1) = {-0.05, 0.05, 0, lc};
p2 = newp; Point(p2) = {-0.05, 0.1, 0, lc};

l1 = newl; Line(l1) = {1, p1};
l2 = newl; Line(l2) = {p1, p2};
l3 = newl; Line(l3) = {p2, 4};

// Create surface
Curve Loop(2) = {2, -1, l1, l2, l3, -3};
Plane Surface(1) = {-2};

// Put 20 points with a refinement toward the extremities on curve 2
Transfinite Curve{2} = 20 Using Bump 0.05;

// Put 20 points total on combination of curves l1, l2 and l3 (beware that the
// points p1 and p2 are shared by the curves, so we do not create 6 + 6 + 10 =
// 22 points, but 20!)
Transfinite Curve{l1} = 6;
Transfinite Curve{l2} = 6 Using Bump 0.001;
Transfinite Curve{l3} = 10;

// Put 30 points following a geometric progression on curve 1 (reversed) and on
// curve 3
Transfinite Curve{-1,3} = 30 Using Progression 1.2;

// Define the Surface as transfinite, by specifying the four corners of the
// transfinite interpolation
Transfinite Surface{1} = {1,2,3,4};

// (Note that the list on the right hand side refers to points, not curves. When
// the surface has only 3 or 4 points on its boundary the list can be
// omitted. The way triangles are generated can be controlled by appending
// "Left", "Right" or "Alternate" after the list.)

// Recombine the triangles into quads
Recombine Surface{1};

// Apply an elliptic smoother to the grid
Mesh.Smoothing = 100;

Physical Surface(1) = 1;
