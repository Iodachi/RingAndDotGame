class Ring {
  float radius = 40;
  Color col;

  Ring(Color c) {
    this.col = c;
  }

  Color getColor() {
    return this.col;
  }

  void drawRing(float x, float y) {
    fill(this.col.getColor());
    ellipse(x, y, radius, radius);
    fill(230); 
    ellipse(x, y, 25, 25); //make it hollow by drawing the inner circle with board color
  }
}