import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;

int blur_size = 10;

void setup() {
	size(640, 480);
	video = new Capture(this, 640/2, 480/2);
	opencv = new OpenCV(this, 640/2, 480/2);
	opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
	
	video.start();
}

void blurBlock(int bbx, int bby) {
	int tally_r = 0;
	int tally_g = 0;
	int tally_b = 0;
	int num_p = 0;
	
	// scale
	bbx *= 2;
	bby *= 2;
	
	int sx = constrain(bbx, 0, (width - 1));
	int ex = constrain((bbx + (blur_size * 2)), 0, (width - 1));
	int sy = constrain(bby, 0, (height - 1));
	int ey = constrain((bby + (blur_size * 2)), 0, (height - 1));
	
	for(int py = sy; py < ey; py++) {
		for(int px = sx; px < ex; px++) {
			int pindex = (px + (width * py));
			int pcol = pixels[ pindex ];
			
			tally_r += red(pcol);
			tally_g += green(pcol);
			tally_b += blue(pcol);
			
			num_p++;
		}
	}
	
	int avg_r = constrain(round( (tally_r / num_p) ), 0, 255);
	int avg_g = constrain(round( (tally_g / num_p) ), 0, 255);
	int avg_b = constrain(round( (tally_b / num_p) ), 0, 255);
	
	for(int py = sy; py < ey; py++) {
		for(int px = sx; px < ex; px++) {
			int pindex = (px + (width * py));
			pixels[ pindex ] = color(avg_r, avg_g, avg_b);
		}
	}
}

void draw() {
	scale(2);
	opencv.loadImage(video);

	image(video, 0, 0 );
	
	// blur face(s) if possible
	
	noFill();
	stroke(0, 255, 0);
	strokeWeight(3);
	
	Rectangle[] faces = opencv.detect();
	
	if(faces.length > 0) {
		loadPixels();
		
		for(int i = 0; i < faces.length; i++) {
			int x = faces[ i ].x;
			int y = faces[ i ].y;
			int w = faces[ i ].width;
			int h = faces[ i ].height;
			
			float num_blocks_w_raw = (w / blur_size);
			float num_blocks_h_raw = (h / blur_size);
			
			int offset_w = round( ((num_blocks_w_raw % blur_size) / 2) );
			int offset_h = round( ((num_blocks_h_raw % blur_size) / 2) );
			
			int num_blocks_w = floor( num_blocks_w_raw );
			int num_blocks_h = floor( num_blocks_h_raw );
			
			int sby = constrain(y, 0, height-1);
			int sbx = constrain(x, 0, width-1);
			
			for(int by = sby; by < (sby + h); by += blur_size) {
				for(int bx = sbx; bx < (x + w); bx += blur_size) {
					blurBlock(bx, by);
				}
			}
		}
		
		updatePixels();
	}
}

void captureEvent(Capture c) {
	c.read();
}
