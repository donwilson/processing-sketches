int wid = 256;
int hei = 224;

String filename = "256x224.png";

PImage img;

// float centerOffX(int width_) {
// 	return ((width * 0.5) - (width_ * 0.5));
// }

// float centerOffY(int height_) {
// 	return ((height * 0.5) - (height_ * 0.5));
// }

void push() {
	pushMatrix();
	pushStyle();
}

void pop() {
	popStyle();
	popMatrix();
}

void draw_debugBorders() {
	push();
	
	stroke(color(255, 0, 0));
	
	int line_size = 1;
	
	for(int i = 1; i <= line_size; i++) {
		float top_y = ((height * 0.5) - (1080 * 0.5) - i);
		float bottom_y = (top_y + 1080 + i);
		
		float left_x = ((width * 0.5) - (1920 * 0.5) - i);
		float right_x = (left_x + 1920 + i);
		
		// top
		line(
			left_x,
			top_y,
			right_x,
			top_y
		);
		
		// right
		line(
			right_x,
			top_y,
			right_x,
			bottom_y
		);
		
		// bottom
		line(
			left_x,
			bottom_y,
			right_x,
			bottom_y
		);
		
		// left
		line(
			left_x,
			top_y,
			left_x,
			bottom_y
		);
	}
	
	pop();
}

void draw_pixelMultiplied(int scale_) {
	if(scale_ < 1) {
		scale_ = 1;
	}
	
	PixelMultiplier pixel_multiplier = new PixelMultiplier(img);
	pixel_multiplier.scale(scale_);
	
	PImage scaled_image = pixel_multiplier.getImage();
	
	push();
	
	imageMode(CENTER);
	image(scaled_image, (width * 0.5), (height * 0.5));
	
	pop();
}

void draw_containedStretch(int width_, int height_) {
	ContainScaler contained_scaler = new ContainScaler(img);
	contained_scaler.scale(width_, height_);
	
	PImage scaled_image = contained_scaler.getImage();
	
	push();
	
	imageMode(CENTER);
	image(scaled_image, (width * 0.5), (height * 0.5));
	
	pop();
}

void setup() {
	fullScreen();
	//size(256, 224);
	
	img = loadImage(filename);
	
	
	// draw
	background(0);
	
	// 1x
	//image(img, centerOffX(img.width), centerOffY(img.height));
	
	// 4x
	//draw_pixelMultiplied(4);
	
	// contained scale
	draw_containedStretch(1920, 1080);
	
	draw_debugBorders();
}

// needed for escape key to work
void draw() {
	
}

