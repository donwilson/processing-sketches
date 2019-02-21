	
	class Square {
		public static final int UP = 0;
		public static final int RIGHT = 1;
		public static final int DOWN = 2;
		public static final int LEFT = 3;
		
		int x_left;
		int x_right;
		int y_top;
		int y_bottom;
		int size;
		
		boolean mouse_over = false;
		
		boolean neighbor_up_exists = false;
		Square neighbor_up;
		
		boolean neighbor_right_exists = false;
		Square neighbor_right;
		
		boolean neighbor_down_exists = false;
		Square neighbor_down;
		
		boolean neighbor_left_exists = false;
		Square neighbor_left;
		
		float glow;
		
		color cell_col;
		
		Square(int x_left_, int y_top_, int size_) {
			x_left = x_left_;
			y_top = y_top_;
			size = size_;
			
			x_right = (x_left + size);
			y_bottom = (y_top + size);
			
			cell_col = color(random(0, 255), random(0, 255), random(0, 255));
			
			glow = 0;
		}
		
		void setNeighborUp(Square neighbor_) {
			neighbor_up_exists = true;
			neighbor_up = neighbor_;
		}
		
		void setNeighborRight(Square neighbor_) {
			neighbor_right_exists = true;
			neighbor_right = neighbor_;
		}
		
		void setNeighborDown(Square neighbor_) {
			neighbor_down_exists = true;
			neighbor_down = neighbor_;
		}
		
		void setNeighborLeft(Square neighbor_) {
			neighbor_left_exists = true;
			neighbor_left = neighbor_;
		}
		
		boolean isMouseOver() {
			if((mouseX < x_left) || (mouseY < y_top)) {
				return false;
			}
			
			if((mouseX >= x_right) || (mouseY >= y_bottom)) {
				return false;
			}
			
			return true;
		}
		
		void receiveGlow(float glow_) {
			glow = constrain((glow + glow_), 0, 1);
		}
		
		void glowNeighbors() {
			int num_glows = 0;
			
			if(neighbor_up_exists) {
				num_glows += 1;
			}
			
			if(neighbor_right_exists) {
				num_glows += 1;
			}
			
			if(neighbor_down_exists) {
				num_glows += 1;
			}
			
			if(neighbor_left_exists) {
				num_glows += 1;
			}
			
			float glow_each = (glow / num_glows);
			
			if(glow_each >= 0.01) {
				if(neighbor_up_exists) {
					neighbor_up.receiveGlow(glow_each);
				}
				
				if(neighbor_right_exists) {
					neighbor_right.receiveGlow(glow_each);
				}
				
				if(neighbor_down_exists) {
					neighbor_down.receiveGlow(glow_each);
				}
				
				if(neighbor_left_exists) {
					neighbor_left.receiveGlow(glow_each);
				}
			}
		}
		
		void update() {
			boolean was_mouse_over = mouse_over;
			mouse_over = isMouseOver();
			
			if(mouse_over) {
				glow = 1.0;
				
				glowNeighbors();
			}
		}
		
		void draw() {
			cell_col = color(round( ((float)255 * glow) ));
			
			pushMatrix();
			pushStyle();
			
			noStroke();
			fill(cell_col);
			
			rect(x_left, y_top, size, size);
			
			popStyle();
			popMatrix();
			
			glow = 0;
		}
	}
	