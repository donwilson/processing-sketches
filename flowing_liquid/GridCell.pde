class GridCell {
	int x;
	int y;
	int type;
	int w = 10;
	int h = 10;
	
	int liquid_level = 0;   // 0-10 where 10 is full of liquid
	
	// references
	Grid grid;
	GridCell neighbor_top;
	GridCell neighbor_bottom;
	GridCell neighbor_left;
	GridCell neighbor_right;
	
	GridCell(int x_, int y_, int type_, Grid grid_) {
		x = x_;
		y = y_;
		type = type_;
		
		grid = grid_;
	}
	
	void setType(int type_) {
		type = type_;
	}
	
	// accept liquid, return liquid amount not retainable (over limit or if type cant take in liquid)
	// add_amt = amount similar to liquid_level (0-10 or more)
	int takeInLiquid(int add_amt) {
		if(type == GridCellType.SOLID) {
			return add_amt;
		}
		
		//add_amt = constrain(add_amt, 0, 10);
		
		liquid_level += add_amt;
		
		if(liquid_level > 10) {
			return (liquid_level - 10);
		}
		
		return 0;
	}
	
	void update() {
		if(type == GridCellType.SOLID) {
			return;
		}
		
		
	}
	
	void draw() {
		pushMatrix();
		pushStyle();
		
		translate((x * w), (y * h));
		
		if(type == GridCellType.SOLID) {
			fill(0);
			noStroke();
			rect(0, 0, w, h);
		} else if(type == GridCellType.AIR) {
			if(liquid_level > 0) {
				fill(color(0, 0, 255));
				noStroke();
				
				int sized_height = (h - (round(map(liquid_level, 0, 10, 0, h))));
				
				rect(
					0,
					sized_height,
					w,
					(h - sized_height)
				);
			}
		}
		
		popStyle();
		popMatrix();
	}
}