// P_2_0_03.pde
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
 * drawing with a changing shape by draging the mouse.
 * 	 
 * MOUSE
 * position x          : length
 * position y          : thickness and number of lines
 * drag                : draw
 * 
 * KEYS
 * 1-3                 : stroke color
 * del, backspace      : erase
 * s                   : save png
 * r                   : start pdf record
 * e                   : end pdf record
 */
 
import processing.pdf.*;
import java.util.Calendar;

boolean recordPDF = false;

color strokeColor = color(0, 10);

int i=0;
void setup(){
  size(720, 720);
  colorMode(HSB, 360, 150, 100, 100);
  smooth();
  noFill();
  background(360);
  
  float radius = width/3;
  float diameter = radius*2;
 
  float centerX = width/1.6;
  float centerY = height/1.6;
 
  float sqr1s = diameter/sqrt(2);
  float sqr2s = sqr1s/2;
  float sqr3s = radius;
 
  fill(100,70,355);
  float per1S = radius/(5f/3);
 
  pushMatrix();
  translate(centerX, centerY);
 
  pushMatrix();
  for (int i=0; i<8; i++) {
    rotate(i*radians(45));
 
    pushMatrix();
    translate(sqr1s/2, 0);
 
    ellipse(0, 0, per1S, per1S);
    popMatrix();
  }
  popMatrix();
 
  fill(340,270,110);
  float per2S = per1S/1.5;
 
  pushMatrix();
  rotate(radians(22.5));
 
  for (int i=0; i<8; i++) {
    rotate(i*radians(45));
 
    pushMatrix();
    translate(sqr3s/2, 0);
 
    ellipse(0, 0, per2S, per2S);
 
    popMatrix();
  }
  popMatrix();
 
  fill(60, 33, 98);
  float per3S = per1S/2;
   
  pushMatrix();
  for (int i=0; i<8; i++) {
    rotate(i*radians(45));
 
    pushMatrix();
    translate(sqr2s/2, 0);
 
    ellipse(0, 0, per3S, per3S);
    popMatrix();
  }
  popMatrix();
 
  fill(30, 0, 100);
  float per4S = per2S/2;
 
  pushMatrix();
  rotate(radians(22.5));
 
  for (int i=0; i<8; i++) {
    rotate(i*radians(45));
 
    pushMatrix();
    translate(sqr2s/3, 0);
 
    ellipse(0, 0, per4S, per4S);
    popMatrix();
  }
  popMatrix();
 
  float dotSize = radius/5;
 
  fill(45, 70, 50);
 
  ellipse(0, 0, dotSize, dotSize);
 
  popMatrix();
 
 
}


void draw(){
  fill(-1<<i%92,125);
 translate(450,450);
 rotate(i++);
 rect(i%333,0,i%33,5+i%10);
  if(mousePressed){
    pushMatrix();
    translate(width/2,height/2);

    int circleResolution = (int)map(mouseY+100,0,height,2, 10);
    int radius = mouseX-width/2;
    float angle = TWO_PI/circleResolution;

    strokeWeight(2);
    stroke(strokeColor);

    beginShape();
    for (int i=0; i<=circleResolution; i++){
      float x = 0 + cos(angle*i) * radius;
      float y = 0 + sin(angle*i) * radius;
      vertex(x, y);
    }
    endShape();
    
    popMatrix();
  }
}

void keyReleased(){
  if (key == DELETE || key == BACKSPACE) background(360);
  if (key=='s' || key=='S') saveFrame(timestamp()+"_##.png");

  switch(key){
  case '1':
    strokeColor = color(0, 10);
    break;
  case '2':
    strokeColor = color(192, 100, 64, 10);
    break;
  case '3':
    strokeColor = color(52, 100, 71, 10);
    break;
  }

  // ------ pdf export ------
  // press 'r' to start pdf recording and 'e' to stop it
  // ONLY by pressing 'e' the pdf is saved to disk!
  if (key =='r' || key =='R') {
    if (recordPDF == false) {
      beginRecord(PDF, timestamp()+".pdf");
      println("recording started");
      recordPDF = true;
      colorMode(HSB, 360, 100, 100, 100);
      smooth();
      noFill();
      background(360);
    }
  } 
  else if (key == 'e' || key =='E') {
    if (recordPDF) {
      println("recording stopped");
      endRecord();
      recordPDF = false;
      background(360); 
    }
  }  
}

// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}

