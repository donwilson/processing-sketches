import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;

int captureFrameN = 0;

void setup() {
	size(320, 240);
	video = new Capture(this, width, height);
	opencv = new OpenCV(this, width, height);
	
	opencv.startBackgroundSubtraction(5, 3, 0.5);
	
	video.start();
}

void draw() {
	if(frameCount < 60) {
		image(video, 0, 0);
		
		return;
	}
	
	if((frameCount % 5) == 0) {
		image(video, 0, 0);
		
		return;
	}
	
	opencv.loadImage(video);
	opencv.updateBackground();
	
	opencv.dilate();
	opencv.erode();
	
	loadPixels();
	video.loadPixels();
	
	for(Contour contour : opencv.findContours()) {
		//contour.draw();
		
		processUpdatedContour(contour);
	}
	
	updatePixels();
	
	println("frame #"+ frameCount);
}

void captureEvent(Capture c) {
	c.read();
}

void processUpdatedContour(Contour con) {
	Rectangle boundingBox = con.getBoundingBox();
	
	for(int y = boundingBox.y; y < (boundingBox.y + boundingBox.height); y++) {
		for(int x = boundingBox.x; x < (boundingBox.x + boundingBox.width); x++) {
			//if(!con.containsPoint(x, y)) {
			//	continue;
			//}
			
			int pindex = (x + (y * width));
			
			pixels[ pindex ] = video.pixels[ pindex ];
		}
	}
	
	//debug:
	// ArrayList<PVector> points = con.getPoints();
	// beginShape();
	//
	// for(PVector pt : points) {
	// 	vertex(pt.x, pt.y);
	// }
	//
	// endShape(CLOSE);
}
