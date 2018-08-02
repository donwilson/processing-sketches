class Dot {
  float x;
  float y;
  
  Dot(float x_, float y_) {
    x = x_;
    y = y_;
  }
  
  void display() {
    push();
    translate(x, y);
    fill(255);
    ellipseMode(CENTER);
    ellipse(0, 0, 2, 2);
    pop();
  }
}
