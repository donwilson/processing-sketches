Grid grid;

void setup() {
	size(640, 640);
	
	grid = new Grid(64, 64);
}

void draw() {
	background(255);
	
	grid.update();
	grid.draw();
	
	println(frameRate);
}