class MS {
  int res;
  float[][] pointsF;
  int[][] pointsI;
  float theta;
  float xOffset, yOffset;
  float tick;
  float threshold;


  MS(int res_) {
    res = res_;
    pointsF = new float[1 + width/res][1 + height/res];
    pointsI = new int[1 + width/res][1 + height/res];
    theta = 0;
    xOffset = .05;
    yOffset = .05;
    tick = .01;
    threshold = 0;
  }

  void sample() {
    //threshold = map(mouseX, 0, width, 0, 255);
    threshold = 55 + 55 * sin(theta);
    for (int i = 0; i <  width/res; i++) {
      for (int j = 0; j <  height/res; j++) {
        //points[i][j] = noise(i * xOffset, j * yOffset, theta);
        if (brightness(pixels[i * res + j * width * res]) > threshold) {
          pointsI[i][j] = 1;
        } else {
          pointsI[i][j] = 0;
        }
        pointsF[i][j] = brightness(pixels[i * res + j * width * res]);
      }
    }

    theta += tick;
  }

  void display() {
    stroke(255);
    strokeWeight(1);
    
    for (int i = 0; i < width/res; i++) {
      for (int j = 0; j < height/res; j++) {
        //point(i * res, j * res);
        int index = int(pointsI[i][j] * 8 + pointsI[i+1][j] * 4 + pointsI[i+1][j+1] * 2 + pointsI[i][j+1]);
        march(index, i * res, j * res);
      }
    }
  }
  
  void run() {
    this.sample();
    this.display();
  }

  void march(int instruction_, float xPos_, float yPos_) {
    PVector a = new PVector(xPos_ + res/2, yPos_);
    PVector b = new PVector(xPos_ + res, yPos_ + res/2);
    PVector c = new PVector(xPos_ + res/2, yPos_ + res);
    PVector d = new PVector(xPos_, yPos_ + res/2);

    switch(instruction_) {
    case 0:
      break;
    case 1:
      line(c.x, c.y, d.x, d.y);
      break;
    case 2:
      line(b.x, b.y, c.x, c.y);
      break;
    case 3:
      line(b.x, b.y, d.x, d.y);
      break;
    case 4:
      line(a.x, a.y, b.x, b.y);
      break;
    case 5:
      line(a.x, a.y, d.x, d.y);
      line(b.x, b.y, c.x, c.y);
      break;
    case 6:
      line(a.x, a.y, c.x, c.y);
      break;
    case 7:
      line(a.x, a.y, d.x, d.y);
      break;
    case 8:
      line(a.x, a.y, d.x, d.y);
      break;
    case 9:
      line(a.x, a.y, c.x, c.y);
      break;
    case 10:
      line(a.x, a.y, b.x, b.y);
      line(c.x, c.y, d.x, d.y);
      break;
    case 11:
      line(a.x, a.y, b.x, b.y);
      break;
    case 12:
      line(b.x, b.y, d.x, d.y);
      break;
    case 13:
      line(b.x, b.y, c.x, c.y);
      break;
    case 14:
      line(c.x, c.y, d.x, d.y);
      break;
    case 15:
      break;
    }
  }
}
