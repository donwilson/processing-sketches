import java.util.Arrays;
import java.util.Comparator;

PImage img;
float[] brightnesses = new float[204800];   // 640*320

int whichImage = 0;
String[] images = new String[3];

void setup() {
	images[0] = "n64.jpg";
	images[1] = "gc.jpg";
	images[2] = "switch.jpg";
	
	size(640, 640);
}

void draw() {
	updateDraw();
	
	noLoop();
}

void mousePressed() {
	if(whichImage >= (images.length - 1)) {
		whichImage = 0;
	} else {
		whichImage++;
	}
	
	loop();
}


void updateDraw() {
	img = loadImage( images[ whichImage ] );
	
	background(color(30, 30, 30));
	
	image(img, 0, 0);
	
	PImage px_img = createImage(640, 320, HSB);
	
	img.loadPixels();
	px_img.loadPixels();
	
	for(int i = 0; i < 204800; i++) {
		// down then right
		int x = floor( (i / 320) );
		int y = (i % 320);
		
		color src_color = img.pixels[ i ];
		
		//px_img.pixels[i] = color(brightness(src_color));
		brightnesses[i] = brightness(src_color);
	}
	
	Arrays.sort(brightnesses, new Comparator<Integer>() {
		public int compare(Integer idx1, Integer idx2) {
			return Integer.compare(int(brightness(idx1)), int(brightness(idx2)));
		}
	});
	
	/*sort(brightnesses);
	
	for(int i = 0; i < 204800; i++) {
		px_img.pixels[ i ] = color(brightnesses[ i ] * 255);
	}*/
	
	px_img.updatePixels();
	
	image(px_img, 0, 320);
}