float lego_scale = 1.6;   // 1.6mm

Brick brick;

void setup() {
	size(640, 640, P3D);
	
	brick = new Brick(0, 0, 0);
}

void draw() {
	background(0);
	
	//directionalLight(204, 204, 204, 1, 1, 1);
	
	translate((width / 2), (height / 2));
	rotateX(radians(-30));
	rotateY(QUARTER_PI);
	
	brick.update();
	brick.render();
	
	
}