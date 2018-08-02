int num_lines = 2;
float aa = 0.0;
float aa_per_frame = (5.0 / 60.0);

void setup() {
	size(600, 600);
}

void draw() {
	background(51);
	float spacing = (float(width) / float(num_lines));
	
	for(int j = 0; j < 4; j++) {
		float x, y;
		
		for(int i = 0; i < num_lines; i++) {
			stroke(map(i, 0, (num_lines - 1), 0, 255));
			
			x = (spacing * i);
			y = (width - x);
			line(x, 0, width, x);
			
			x = (width - (spacing * i));
			y = x;
			line(x, 0, width, x);
		}
		translate(width/2, height/2);
		rotate(radians(-90));
		translate(-width/2, -height/2);
	}
	
	translate(width/2, height/2);
	fill(255);
	text("spacing = "+ spacing, 0, 0);
	text("num_lines = "+ num_lines, 0, 12);
	text("aa = "+ aa, 0, 24);
	
	aa += aa_per_frame;
	
	if(aa > num_lines) {
		num_lines += 1;
	}
}