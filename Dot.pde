class Dot {
  float radius = 25;
  Color col;

  Dot(Color c) {
    this.col = c;
  }

  Color getColor() {
    return this.col;
  }

  void drawDot(float x, float y) {
    fill(this.col.getColor());
    ellipse(x, y, radius, radius);
  }
}