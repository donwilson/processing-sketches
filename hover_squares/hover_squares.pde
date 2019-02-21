	
	// DOESNT WORK
	
	int sqsize = 20;
	int sqnumeach;
	
	Square[][] squares;
	
	void setup() {
		size(640, 640);
		
		sqnumeach = floor((width / sqsize));
		
		squares = new Square[ sqnumeach ][ sqnumeach ];
		
		// initialize squares
		for(int y = 0; y < sqnumeach; y++) {
			int offset_y = (y * sqsize);
			
			for(int x = 0; x < sqnumeach; x++) {
				int offset_x = (x * sqsize);
				
				squares[ y ][ x ] = new Square(offset_x, offset_y, sqsize);
			}
		}
		
		// setup neighbors
		for(int y = 0; y < sqnumeach; y++) {
			for(int x = 0; x < sqnumeach; x++) {
				// up
				if(y > 0) {
					squares[ y ][ x ].setNeighborRight(squares[ (y - 1) ][ x ]);
				}
				
				// right
				if(x < (sqnumeach - 1)) {
					squares[ y ][ x ].setNeighborRight(squares[ y ][ (x + 1) ]);
				}
				
				// down
				if(y < (sqnumeach - 1)) {
					squares[ y ][ x ].setNeighborRight(squares[ (y + 1) ][ x ]);
				}
				
				// left
				if(x > 0) {
					squares[ y ][ x ].setNeighborRight(squares[ y ][ (x - 1) ]);
				}
			}
		}
	}
	
	void draw() {
		// update
		for(int y = 0; y < sqnumeach; y++) {
			for(int x = 0; x < sqnumeach; x++) {
				squares[ y ][ x ].update();
			}
		}
		
		// draw
		for(int y = 0; y < sqnumeach; y++) {
			for(int x = 0; x < sqnumeach; x++) {
				squares[ y ][ x ].draw();
			}
		}
	}
	