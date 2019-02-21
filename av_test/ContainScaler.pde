	
	class ContainScaler {
		PImage source;
		PImage output;
		
		ContainScaler(PImage source_) {
			source = source_.copy();
		}
		
		void scale(int width_, int height_) {
			PVector scaled_size = calculateContainedScale(width_, height_);
			
			println("scaled_size=["+ scaled_size.x +","+ scaled_size.y +"]");
			
			output = createImage(floor(scaled_size.x), floor(scaled_size.y), RGB);
			
			for(int y = 0; y < height_; y++) {
				for(int x = 0; x < width_; x++) {
					output.set(x, y, color(255, 255, 255));
				}
			}
		}
		
		PVector calculateContainedScale(int width_, int height_) {
			float scale_x;
			float scale_y;
			
			if(source.height > source.width) {
				// portrait
				scale_x = (source.width * (height_ / source.height));
				scale_y = height_;
				
				if(scale_x > width_) {
					// landscape
					scale_x = width_;
					scale_y = (source.height * (width_ / source.width));
				}
			} else {
				// landscape
				scale_x = width_;
				scale_y = (source.height * (width_ / source.width));
				
				if(scale_y > height_) {
					// landscape
					scale_x = (source.width * (height_ / source.height));
					scale_y = height_;
				}
			}
			
			return new PVector(scale_x, scale_y);
		}
		
		PImage getImage() {
			return output;
		}
	}
	