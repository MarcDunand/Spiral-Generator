import processing.svg.*;

int steps = 2;
float maxRange = 1.15;
float splitPerc = 20;


void curves(int prevX, int prevY, float prevC, int maxX, int maxY) {
  if(abs(prevX-maxX) < 3 && abs(prevY-maxY) < 3) {
    return;
  }
  else {
    int nextX;
    int nextY;
    
    float share = random(0.1, 0.5);
    
    if(maxX > prevX) {
      nextX = (int)(prevX*share+maxX*(1-share));//((int)(random(prevX, maxX)/steps))*steps;
    }
    else if (maxX < prevX) {
      nextX = (int)(prevX*share+maxX*(1-share));//((int)(random(maxX, prevX)/steps))*steps;
    }
    else {
      nextX = maxX;
    }
    
    if(maxY > prevY) {
      nextY = (int)(prevY*share+maxY*(1-share));//((int)(random(prevY, maxY)/steps))*steps;
    }
    else if (maxY < prevY) {
      nextY = (int)(prevY*share+maxY*(1-share));//((int)(random(maxY, prevY)/steps))*steps;
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
          curves((prevX+nextX)/2, prevY + (abs(prevX-nextX))/2, prevC + ((int)random(2))*PI+PI/2, (prevX+nextX)/2, (int)(prevY + (abs(prevX-nextX))*maxRange));
        }
      }
      else {
        if(random(width) < abs(prevX-nextX)*splitPerc) {
          curves((prevX+nextX)/2, prevY - (abs(prevX-nextX))/2, prevC + ((int)random(2))*PI+PI/2, (prevX+nextX)/2, (int)(prevY - abs(prevX-nextX)*maxRange));
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
          curves(prevX - abs(prevY-nextY)/2, (prevY+nextY)/2, prevC + ((int)random(2))*PI+PI/2, (int)(prevX - abs(prevY-nextY)*maxRange), (prevY+nextY)/2);
        }
      }
      else {
        if(random(height) < abs(prevY-nextY)*splitPerc) {
          curves(prevX + abs(prevY-nextY)/2, (prevY+nextY)/2, prevC + ((int)random(2))*PI+PI/2, (int)(prevX + abs(prevY-nextY)*maxRange), (prevY+nextY)/2);
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
