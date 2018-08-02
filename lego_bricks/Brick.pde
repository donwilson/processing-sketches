class Brick {
	float x;
	float y;
	float z;
	float sc = 5;   // scale amount (px) for drawing
	
	Brick(float x_, float y_, float z_) {
		x = x_;
		y = y_;
		z = z_;
	}
	
	float calcScale(float amt) {
		return (1.6 * amt * sc);
	}
	
	void update() {
		
	}
	
	void render() {
		pushMatrix();
		pushStyle();
		
		translate(x, y, z);
		
		fill(0, 0, 255);
		noStroke();
		//stroke(255);
		
		render_long_sides();
		render_short_sides();
		render_top();
		
		popStyle();
		popMatrix();
	}
	
	
	void render_long_sides() {
		// front long wall
		pushMatrix();
		translate(0, 0, calcScale(0 + (15.8 / 2) - (1.2 / 2)));
		
		box(
			calcScale(31.8),
			calcScale(9.6),
			calcScale(1.2)
		);
		
		popMatrix();
		
		// back long wall
		pushMatrix();
		translate(0, 0, calcScale(0 - (15.8 / 2) + (1.2 / 2)));
		
		box(
			calcScale(31.8),
			calcScale(9.6),
			calcScale(1.2)
		);
		
		popMatrix();
	}
	
	void render_short_sides() {
		// front short wall
		pushMatrix();
		translate(calcScale(0 + (31.8 / 2) - (1.2 / 2)), 0, 0);
		
		box(
			calcScale(1.2),
			calcScale(9.6),
			calcScale(15.8)
		);
		
		popMatrix();
		
		// back short wall
		pushMatrix();
		translate(calcScale(0 - (31.8 / 2) + (1.2 / 2)), 0, 0);
		
		box(
			calcScale(1.2),
			calcScale(9.6),
			calcScale(15.8)
		);
		
		popMatrix();
	}
	
	void render_top() {
		pushMatrix();
		
		translate(0, calcScale(0 - (9.6 / 2) + (1.2 / 2)), 0);
		
		box(
			calcScale(31.8),
			calcScale(1.2),
			calcScale(15.8)
		);
		
		popMatrix();
	}
	
	void render_nubs() {
		pushMatrix();
		
		translate(0, calcScale(0 + (9.6 / 2)), 0);
		
		beginShape();
		
		
		
		endShape();
		
		popMatrix();
	}
}