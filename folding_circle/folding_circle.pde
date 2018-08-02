

void setup() {
	size(640, 640);
	
}

void draw() {
	background(0);
	
	translate((width / 2), (height / 2));
	
	//fill(color(255, 0, 0));
	//noStroke();
	stroke(color(255, 0, 0));
	strokeWeight(8);
	noFill();
	arc(0, 0, 64, 64, radians(-90), radians(180));
}