// P_1_1_2_01.pde
// 
// Generative Gestaltung, ISBN: 978-3-87439-759-9
// First Edition, Hermann Schmidt, Mainz, 2009
// Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
// Copyright 2009 Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
//
// http://www.generative-gestaltung.de
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/**
 * changing the color circle by moving the mouse.
 * 	 
 * MOUSE
 * position x          : saturation
 * position y          : brighness
 * 
 * KEYS
 * 1-5                 : number of segments
 * s                   : save png
 * p                   : save pdf
 */

import processing.pdf.*;
import java.util.Calendar;

boolean savePDF = false;

int segmentCount = 360;
int radius = 300;
//new
float a;
float theta =random(0, 6.289);

int x;
int y;
float ease = 0.05;
int tolerance;
float redFactor;  
int opacity = 150;  
int sizeStroke = 10;

void setup(){
  size(800, 800);
  background(255);
  smooth();
  noCursor();
  tolerance = 50;
  redFactor = 0.02;
}

void draw(){
  background(255);
  for (int i = 50; i < (width-25); i += 25) {
    for (int j = 50; j < (height-25); j += 25) {
      stroke(map(i, 0, 500, 0, 255), map(j, 0, 500, 0, 255), 125, opacity);
      lineRot(i, j);
    }
  }

  line(random(0, 400), random(0, 400), 400, 400);
  stroke(random(255), 0, 0, random(255));
  line(random(400, 800), random(0, 400), 400, 400);
  stroke(0, random(255), 0, random(255));
  line(random(0, 400), random(400, 800), 400, 400);
  stroke(0, 0, random(255), random(255));
  line(random(400, 800), random(400, 800), 400, 400);
  stroke(random(100, 255), 0, random(100, 255), random(255));

  if (savePDF) beginRecord(PDF, timestamp()+".pdf");

  noStroke();
  colorMode(HSB, 360, width, height);
 

  float angleStep = 360/segmentCount;

  beginShape(TRIANGLE_FAN);
  vertex(width/2, height/2);
  for (float angle=0; angle<=360; angle+=angleStep){
    float vx = width/2 + cos(radians(angle))*radius;
    float vy = height/2 + sin(radians(angle))*radius;
    vertex(vx, vy);
    fill(angle, mouseX, mouseY);
    stroke(255);
    strokeWeight(0.05);
  }
  endShape();
  //new
  translate(width/2, height/2);
  noFill();
 
   stroke(255);
   strokeWeight(2);
  theta=theta+0.003;///(2*pi)
   branch(130);
  rotate(PI/2);
  branch(130);
  rotate(PI/2);
  branch(130);
  rotate(PI/2);
  branch(130);
  rotate(PI/2);


  if (savePDF) {
    savePDF = false;
    endRecord();
  }
}

 void lineRot(int xPos, int yPos) {
    strokeWeight(3);
    pushMatrix();
    translate(xPos, yPos);
    float angle = atan2(mouseY-yPos, mouseX-xPos);
    float mouseDist = dist(mouseX, mouseY, xPos, yPos);
  //line below is test
    rotate(angle-PI);
    if (dist(mouseX, mouseY, xPos, yPos) < tolerance) {
    //rotate(angle);
      line(0, 0, mouseDist, 0);
    }
    else {
    //rotate(angle-PI);
      line(0, 0, tolerance/(mouseDist*redFactor), 0);
    }
    popMatrix();
   }

void keyReleased(){
  if (key=='s' || key=='S') saveFrame(timestamp()+"_##.png");
  if (key=='p' || key=='P') savePDF = true;

  switch(key){
  case '1':
    segmentCount = 360;
    break;
  case '2':
    segmentCount = 45;
    break;
  case '3':
    segmentCount = 24;
    break;
  case '4':
    segmentCount = 12;
    break;
  case '5':
    segmentCount = 6;
    break;
  }
}

void branch(float h) {
  h *= 0.7;
  if (h > 3) {
    pushMatrix();   
    rotate(theta);  
    line(0, 0, 0, -h); 
    translate(0, -h);
    branch(h);    
    popMatrix();   
    pushMatrix();
    rotate(-theta);
    line(0, 0, 0, -h);
    translate(0, -h);
    branch(h);
    popMatrix();
  }
}


// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}








