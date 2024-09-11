import processing.svg.*;

int steps = 2;
float maxRange = 1.4;
float splitPerc = 10;


void curves(int prevX, int prevY, float prevC, int maxX, int maxY) {
  if(abs(prevX-maxX) < 3 && abs(prevY-maxY) < 3) {
    return;
  }
  else {
    int nextX;
    int nextY;
    
    if(maxX > prevX) {
      nextX = ((int)(random(prevX, maxX)/steps))*steps;
    }
    else if (maxX < prevX) {
      nextX = ((int)(random(maxX, prevX)/steps))*steps;
    }
    else {
      nextX = maxX;
    }
    
    if(maxY > prevY) {
      nextY = ((int)(random(prevY, maxY)/steps))*steps;
    }
    else if (maxY < prevY) {
      nextY = ((int)(random(maxY, prevY)/steps))*steps;
    }
    else {
      nextY = maxY;
    }
    
    
    //horizontal
    if(prevY == maxY) {
      arc((prevX + nextX)/2, (prevY + nextY)/2, abs(prevX - nextX), abs(prevX - nextX), prevC, prevC+PI);
    
      curves(nextX, nextY, prevC + PI, prevX, prevY);
      curves(nextX, nextY, prevC + PI, maxX, maxY);
      if(prevC%(2*PI) < (PI-1) || prevC%(2*PI) > (PI+3)) {
        if(random(width) < abs(prevX-nextX)*splitPerc) {
          //push();
          //stroke(0, 0, 255);
          curves((prevX+nextX)/2, prevY + (abs(prevX-nextX))/2, prevC + ((int)random(2))*PI+PI/2, (prevX+nextX)/2, (int)(prevY + (abs(prevX-nextX))*maxRange));
          //pop();
        }
      }
      else {
        if(random(width) < abs(prevX-nextX)*splitPerc) {
          //push();
          //stroke(255, 200, 0);
          curves((prevX+nextX)/2, prevY - (abs(prevX-nextX))/2, prevC + ((int)random(2))*PI+PI/2, (prevX+nextX)/2, (int)(prevY - abs(prevX-nextX)*maxRange));
          //pop();
        }
      }
    }
    //verticle
    else if(prevX == maxX) {
      arc((prevX + nextX)/2, (prevY + nextY)/2, abs(prevY - nextY), abs(prevY - nextY), prevC, prevC+PI);
      
      curves(nextX, nextY, prevC + PI, prevX, prevY);
      curves(nextX, nextY, prevC + PI, maxX, maxY);
      
      if(prevC%(2*PI) < (PI-1) || prevC%(2*PI) > (PI+3)) {
        if(random(height) < abs(prevY-nextY)*splitPerc) {
          //push();
          //stroke(255, 0, 0);
          curves(prevX - abs(prevY-nextY)/2, (prevY+nextY)/2, prevC + ((int)random(2))*PI+PI/2, (int)(prevX - abs(prevY-nextY)*maxRange), (prevY+nextY)/2);
          //pop();
        }
      }
      else {
        if(random(height) < abs(prevY-nextY)*splitPerc) {
          //push();
          //stroke(0, 255, 0);
          curves(prevX + abs(prevY-nextY)/2, (prevY+nextY)/2, prevC + ((int)random(2))*PI+PI/2, (int)(prevX + abs(prevY-nextY)*maxRange), (prevY+nextY)/2);
          //pop();
        }
      }
    }
    //fuckup
    else{
      print("NOPARITY");
    }
    
    return;
  }
}




void setup () {
  size(1056, 816);
  background(255);
  beginRecord(SVG, "testoutp.svg");
  noFill();  
  
  curves(0, 408, 0, 1056, 408);
  endRecord();
  
}
