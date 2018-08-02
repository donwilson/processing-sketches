int num_dots = 30;

Dot[] dots;

void push() {
  pushMatrix();
  pushStyle();
}

void pop() {
  popStyle();
  popMatrix();
}

void setup() {
  size(600, 600);
  
  dots = new Dot[ num_dots ];
  
  for(int i = 0; i < num_dots; i++) {
    dots[ i ] = new Dot(random(width), random(height));
  }
}

void draw() {
  background(0);
  
  for(Dot d : dots) {
    d.display();
  }
}
