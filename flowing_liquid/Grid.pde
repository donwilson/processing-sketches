class Grid {
	int w;
	int h;
	
	GridCell[][] cells;
	
	Grid(int w_, int h_) {
		w = w_;
		h = h_;
		
		// create cells
		cells = new GridCell[ h ][ w ];
		
		for(int y = 0; y < h; y++) {
			for(int x = 0; x < w; x++) {
				cells[ y ][ x ] = new GridCell(x, y, GridCellType.AIR, this);
				
				if((y == 0) || (y == (h - 1)) || (x == 0) || (x == (w - 1))) {
					cells[ y ][ x ].setType(GridCellType.SOLID);
				}
			}
		}
		
		// set cell neighbors
		for(int y = 1; y < (h - 1); y++) {
			for(int x = 1; x < (w - 1); x++) {
				// top
				cells[ y ][ x ].neighbor_top = cells[ (y - 1) ][ x ];
				
				// bottom
				cells[ y ][ x ].neighbor_bottom = cells[ (y + 1) ][ x ];
				
				// left
				cells[ y ][ x ].neighbor_left = cells[ y ][ (x - 1) ];
				
				// right
				cells[ y ][ x ].neighbor_right = cells[ y ][ (x + 1) ];
			}
		}
		
		// add in some initial liquid
		for(int y = (h - 10); y < h; y++) {
			for(int x = 13; x <= 15; x++) {
				cells[ y ][ x ].takeInLiquid(10);
			}
		}
	}
	
	void update() {
		for(int y = 0; y < h; y++) {
			for(int x = 0; x < w; x++) {
				cells[ y ][ x ].update();
			}
		}
	}
	
	void draw() {
		for(int y = 0; y < h; y++) {
			for(int x = 0; x < w; x++) {
				cells[ y ][ x ].draw();
			}
		}
	}
}