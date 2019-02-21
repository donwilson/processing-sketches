	
	class PixelMultiplier {
		PImage source;
		PImage output;
		
		PixelMultiplier(PImage source_) {
			source = source_.copy();
			
			
		}
		
		void scale(int scale_amount_) {
			if(scale_amount_ <= 1) {
				output = source.copy();
				
				return;
			}
			
			output = createImage((source.width * scale_amount_), (source.height * scale_amount_), RGB);
			
			source.loadPixels();
			
			int source_pxl_amt = source.pixels.length;
			
			for(int y = 0; y < source.height; y++) {
				for(int x = 0; x < source.width; x++) {
					int i = ((source.width * y) + x);
					
					int output_x = (x * scale_amount_);
					int output_y = (y * scale_amount_);
					
					color output_color = source.pixels[ i ];
					
					scalePixel(output_x, output_y, output_color, scale_amount_);
				}
			}
		}
		
		void scalePixel(int x_, int y_, color color_, int scale_amount_) {
			for(int y = y_; y <= (y_ + scale_amount_); y++) {
				for(int x = x_; x <= (x_ + scale_amount_); x++) {
					output.set(x, y, color_);
				}
			}
		}
		
		PImage getImage() {
			return output;
		}
	}
	