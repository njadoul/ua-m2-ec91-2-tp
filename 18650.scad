Cell_Count = 3; // number of batteries
$fn = 100;
battery_diameter = 19; // 18.3
battery_length = 65; // 65.2

module edge(radius, height)
{
	difference()
	{
		translate([radius/2-0.5, radius/2-0.5, 0]) cube([radius+1, radius+1, height], center = true);
		translate([radius, radius, 0]) cylinder(h = height+1, r1 = radius, r2 = radius, center = true);
	}
}

module battery_box(cells)
{
	difference()
	{
		union()
		{
            // battery holder
			translate([0, 0, 12/2]) cube(size=[battery_length+8, battery_diameter*cells, 8], center=true);

            // positive outside edge
			translate([battery_length/2+3, 0, 22/2]) cube(size=[2, battery_diameter*cells, 18], center=true);

            // positive terminal holder
			translate([(battery_length/2+1), 0, 11.5/2+10/2]) cube(size=[2, battery_diameter*cells, 11.5], center=true);

            // negative outside edge
			translate([-(battery_length/2+3), 0, 22/2]) cube(size=[2, battery_diameter*cells, 18], center=true);

            // negative terminal holder
			translate([-(battery_length/2+1), 0, 11.5/2+10/2]) cube(size=[2, battery_diameter*cells, 11.5], center=true);

			// mounting flanges	
			translate([20, cells*battery_diameter/2+4/2, 3/2+2]) cube(size=[7, 4, 3], center=true);
			translate([20, cells*battery_diameter/2+4, 3/2+2]) cylinder(r=7/2, h=3, center=true);
			translate([-20, cells*battery_diameter/2+4/2, 3/2+2]) cube(size=[7, 4, 3], center=true);
			translate([-20, cells*battery_diameter/2+4, 3/2+2]) cylinder(r=7/2, h=3, center=true);
			translate([20, -(cells*battery_diameter/2+4/2), 3/2+2]) cube(size=[7, 4, 3], center=true);
			translate([20, -(cells*battery_diameter/2+4), 3/2+2]) cylinder(r=7/2, h=3, center=true);
			translate([-20, -(cells*battery_diameter/2+4/2), 3/2+2]) cube(size=[7, 4, 3], center=true);
			translate([-20, -(cells*battery_diameter/2+4), 3/2+2]) cylinder(r=7/2, h=3, center=true);
		}
		
		for (i=[0:cells-1])
		{
			// battery cradle
			translate([0, -cells*battery_diameter/2+battery_diameter/2+battery_diameter*i, battery_diameter/2+10/2]) rotate(90, [0, 1, 0]) cylinder(r=battery_diameter/2, h=battery_length, center=true);
			
			// positive plate cutout
			translate([(battery_length+2)/2, -cells*battery_diameter/2+battery_diameter/2+battery_diameter*i, battery_diameter/2+10/2]) cube(size=[1, 5.5, 30], center=true);
			translate([(battery_length+2)/2-0.5, -cells*battery_diameter/2+battery_diameter/2+battery_diameter*i, 16/2+10/2]) cube(size=[2, 9.8, 12], center=true);

            // negative spring cutout
			translate([-((battery_length+2)/2), -cells*battery_diameter/2+battery_diameter/2+battery_diameter*i, battery_diameter/2+10/2]) cube(size=[1, 5.5, 30], center=true);
			translate([-((battery_length+2)/2-0.5), -cells*battery_diameter/2+battery_diameter/2+battery_diameter*i, 16/2+10/2]) cube(size=[2, 9.8, 12], center=true);

			// positive solder flange cutout
			translate([(battery_length/2-1.5), -cells*battery_diameter/2+battery_diameter/2+battery_diameter*i, 3/2]) cube(size=[7, 5.5, 5], center=true);
			translate([(battery_length/2)-4.5, -cells*battery_diameter/2+battery_diameter/2+battery_diameter*i, 3/2]) cylinder(r=5.5/2, h=5, center=true);

            // negative solder flange cutout
			translate([-(battery_length/2-1.5), -cells*battery_diameter/2+battery_diameter/2+battery_diameter*i, 3/2]) cube(size=[7, 5.5, 5], center=true);
			translate([-(battery_length/2)+4.5, -cells*battery_diameter/2+battery_diameter/2+battery_diameter*i, 3/2]) cylinder(r=5.5/2, h=5, center=true);
            
			// positive polarity marking
			translate([20, -cells*battery_diameter/2+battery_diameter/2+battery_diameter*i, 6.5]) cube(size=[6, 2, 4], center=true);
			translate([20, -cells*battery_diameter/2+battery_diameter/2+battery_diameter*i, 6.5]) cube(size=[2, 6, 4], center=true);

			// negative polarity marking
			translate([-20, -cells*battery_diameter/2+battery_diameter/2+battery_diameter*i, 6.5]) cube(size=[6, 2, 4], center=true);
		}
		
		if (cells>=2)
		{
			for (i=[0:cells-2])
			{
				// bottom cut-out for cell connections
				translate([0, -cells*battery_diameter/2+battery_diameter+battery_diameter*i, 2.5/2]) rotate(17, [0, 0, 1]) cube(size=[battery_length, 2, 5.5], center=true);			
			}
		}
		
		// positive bottom cutout for wires
		translate([30/2, -cells*battery_diameter/2+battery_diameter/2+battery_diameter*0, 2.5/2]) cube(size=[30, 2, 5.5], center=true);			
		translate([3/2, -cells*battery_diameter/2+battery_diameter/2+battery_diameter*0+1, 2.5/2]) edge(4, 5.5);
		translate([3/2, -cells*battery_diameter/2+battery_diameter/2+battery_diameter*0-1, 2.5/2]) rotate(-90, [0, 0, 1]) edge(4, 5.5);

		// negative bottom cutout for wires
		translate([-30/2, -cells*battery_diameter/2+battery_diameter/2+battery_diameter*(cells-1), 2.5/2]) cube(size=[30, 2, 5.5], center=true);			
		translate([-3/2, -cells*battery_diameter/2+battery_diameter/2+battery_diameter*(cells-1)+1, 2.5/2]) rotate(90, [0, 0, 1]) edge(4, 5.5);
		translate([-3/2, -cells*battery_diameter/2+battery_diameter/2+battery_diameter*(cells-1)-1, 2.5/2]) rotate(180, [0, 0, 1]) edge(4, 5.5);

		// joining bottom cutout for wires
		translate([0, 0, 2.5/2]) cube(size=[3, cells*battery_diameter+5, 5.5], center=true);
	
		// positive mounting holes
		translate([20, cells*battery_diameter/2+4, 3/2]) cylinder(r=3.3/2, h=10, center=true);
		translate([20, -(cells*battery_diameter/2+4), 3/2]) cylinder(r=3.3/2, h=10, center=true);

        // negative mounting holes
		translate([-20, cells*battery_diameter/2+4, 3/2]) cylinder(r=3.3/2, h=10, center=true);
		translate([-20, -(cells*battery_diameter/2+4), 3/2]) cylinder(r=3.3/2, h=10, center=true);

		// rounded corners on end plates
		translate([0, -cells*battery_diameter/2, 20]) rotate(90, [0, 1, 0]) edge(4, battery_length+12);
        translate([0, cells*battery_diameter/2, 20]) rotate(90, [0, 1, 0]) rotate(-90, [0, 0, 1]) edge(4, battery_length+12);
		translate([0, -cells*battery_diameter/2, 16.5]) rotate(90, [0, 1, 0]) edge(3, battery_length+4);
		translate([0, cells*battery_diameter/2, 16.5]) rotate(90, [0, 1, 0]) rotate(-90, [0, 0, 1]) edge(3, battery_length+4);
	}
}

battery_box(Cell_Count);