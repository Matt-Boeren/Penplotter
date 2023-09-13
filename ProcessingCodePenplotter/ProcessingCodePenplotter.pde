//Drawing program Matt Boeren 1ACS02

//Lines
ArrayList<Line> lines;

//Rectangles
ArrayList<Rectangle> rectangles;

//Circles
ArrayList<Circle> circles;

//Ellipse
ArrayList<Ellipse> ellipses;

//CircleArc
ArrayList<CircleArc> circleArcs;

int circleArcMousePresses = 0;

boolean firstMousePress = false;

char command;

float pixToMm = 0.35;

//number input variables
int number = 0;

boolean input = false;
boolean firstEnter = false;

float buffer;

boolean upload = false;

int count = -1;

//serial communication

import processing.serial.*;

Serial myPort;

boolean machineReady = false;

void setup(){
  size(848,700);
  
  //lines
  lines = new ArrayList<Line>();
  
  //rectangles
  rectangles = new ArrayList<Rectangle>();
  
  //circles
  circles = new ArrayList<Circle>();
  
  //ellipses
  ellipses = new ArrayList<Ellipse>();
  
  circleArcs = new ArrayList<CircleArc>();

}

void serialEvent(Serial myPort){
  machineReady = true;
  count += 1;
}

void draw(){
  background(255);
  
  //lines
  if((command == 'l') && (firstMousePress == true)){
    lines.get(lines.size() - 1).drawLine1();
    
    for(int i = 0; i < lines.size() - 1; i++){
      lines.get(i).drawLine2();
    }
  }  
  else{
    for(int i = 0; i < lines.size(); i++){
      lines.get(i).drawLine2();
    }
  }
  
  //rectangles
  if((command == 'r') && (firstMousePress == true)){
    rectangles.get(rectangles.size() - 1).drawRectangle1();
    
    for(int i = 0; i < rectangles.size() - 1; i++){
      rectangles.get(i).drawRectangle2();
  }
  }
  else{
  for(int i = 0; i < rectangles.size(); i++){
    rectangles.get(i).drawRectangle2();
  }
  }
  
  //circles
  if((command == 'c') && (firstMousePress == true)){
    circles.get(circles.size() - 1).drawCircle1();
    
    for(int i = 0; i < circles.size() - 1; i++){
      circles.get(i).drawCircle2();
  }
  }
  else{
  for(int i = 0; i < circles.size(); i++){
    circles.get(i).drawCircle2();
  }
  }
  
  //ellipses
  if((command == 'e') && (firstMousePress == true)){
    ellipses.get(ellipses.size() - 1).drawEllipse1();
    
    for(int i = 0; i < ellipses.size() - 1; i++){
      ellipses.get(i).drawEllipse2();
  }
  }  
  else{
  for(int i = 0; i < ellipses.size(); i++){
    ellipses.get(i).drawEllipse2();
  }
  }
  
  //circleArcs
  
  if((command == 'a') && (circleArcMousePresses == 1)){
    circleArcs.get(circleArcs.size() - 1).drawCircleArc1();
    
    for(int i = 0; i < circleArcs.size() - 1; i++){
      circleArcs.get(i).drawCircleArc3();
  }
  }
  else{
  
  if((command == 'a') && (circleArcMousePresses == 2)){
    circleArcs.get(circleArcs.size() - 1).drawCircleArc2();
    
    for(int i = 0; i < circleArcs.size() - 1; i++){
      circleArcs.get(i).drawCircleArc3();
  }
  }
  else{
    for(int i = 0; i < circleArcs.size(); i++){
      circleArcs.get(i).drawCircleArc3();
  }
  }
  }
  
  // possition of the mouse in millimeters
  
  float mouseXmm = mouseX*pixToMm;
  float mouseYmm = mouseY*pixToMm;
  
  fill(0);
  textSize(15);
  text(command + " X = " + str(round(mouseXmm)) + " mm Y = " + str(round(mouseYmm)) + " mm", mouseX + 5, mouseY - 5);
  
  userInterface();
  
  //upload
  
  if((upload == true) && (machineReady == true)){
      println(upload);
      int circleArcCount = lines.size() + rectangles.size() + circles.size() + ellipses.size();
      int ellipseCount = lines.size() + rectangles.size() + circles.size();
      int circleCount = lines.size() + rectangles.size();
      
      if((count >= circleArcCount) && (count < (circleArcCount + circleArcs.size()))){
        myPort.write(circleArcs.get(count - circleArcCount).sendCircleArc());
      }
      
      if((count >= ellipseCount) && (count < (ellipseCount + ellipses.size()))){
        myPort.write(ellipses.get(count - ellipseCount).sendEllipse());
      }
      
      if((count >= circleCount) && (count < (circleCount + circles.size()))){
        myPort.write(circles.get(count - circleCount).sendCircle());
      }
      
      if((count >= lines.size()) && (count < (lines.size() + rectangles.size()))){
        myPort.write(rectangles.get(count - lines.size()).sendRectangle());
      }
      
      if(count < lines.size()){
        myPort.write(lines.get(count).sendLine());
      }
      
      machineReady = false;
  }
}

void keyPressed(){
  
  //lines
  if(key == 'l'){
    command = 'l';
  }
  
  if((command == 'l') && (keyCode == BACKSPACE) && (lines.size() > 0) && (input == false)){
    lines.remove(lines.size() - 1);
  }
  
  //rectangle
  if(key == 'r'){
    command = 'r';
  }
  
  if((command == 'r') && (keyCode == BACKSPACE) &&(rectangles.size() > 0) && (input == false)){
    rectangles.remove(rectangles.size() - 1);
  }
  
  //circle
  if(key == 'c'){
    command = 'c';
  }
  if((command == 'c') && (keyCode == BACKSPACE) && (circles.size() > 0) && (input == false)){
    circles.remove(circles.size() - 1);
  }
  
  //ellipse
  if(key == 'e'){
    command = 'e';
  }
  
  if((command == 'e') && (keyCode == BACKSPACE) && (ellipses.size() > 0) && (input == false)){
    ellipses.remove(ellipses.size() - 1);
  }
  
  //circleArc
  if(key == 'a'){
    command = 'a';
  }

  if((command == 'a') && (keyCode == BACKSPACE) && (circleArcs.size() > 0) && (input == false)){
    circleArcs.remove(circleArcs.size() - 1);
  }
  
//number input
  int intKey = int(key);
  int digit = 0;
  
  if((keyCode == BACKSPACE) && (input == true)){
    number = int(number/10);
    
  }
  
  if((intKey >= 48) && (intKey <= 57)){
    input = true;
    digit = intKey - 48;
    number = number * 10;
    number += digit;

  }
  if((keyCode == ENTER) && (input == true)){
    
    if(firstEnter == false){
      buffer = number;
      buffer = buffer/pixToMm;
      number = 0;
      firstEnter = true;
    }
    else{
      PVector coordinate;
      coordinate = new PVector(buffer, number/pixToMm);
      createFigure(coordinate);
      buffer = 0;
      number = 0;
      input = false;
      firstEnter = false;
    }
  }
  else{
    if(keyCode == ENTER){
      myPort = new Serial (this, "/dev/cu.usbmodem141401", 9600);
  
      myPort.bufferUntil('\n');
      
      upload = true;
      
      println("connection succesfull");
    }
  }
}

void mousePressed(){
  PVector mouse;
  
  mouse = new PVector(mouseX, mouseY);
  
  if(mouse.y < 600){
    createFigure(mouse);
  }
  else{
    if(mouseX < 100){
      command = 'l';
    }
    if((mouseX > 100) && (mouseX < 200)){
      command = 'r';
    }
    if((mouseX > 200) && (mouseX < 300)){
      command = 'c';
    }
    if((mouseX > 300) && (mouseX <400)){
      command = 'e';
    }
    if((mouseX > 400) && (mouseX < 500)){
      command = 'a';
    }
  }
}


void createFigure(PVector mousePoint){
  
  if(upload == false){
  //lines
  if((command == 'l') && (firstMousePress == false)){
    lines.add(new Line());
    lines.get(lines.size() - 1).createLine1(mousePoint);
    firstMousePress = true;
  }
  
  else{
    if((command == 'l') && (firstMousePress == true)){
      lines.get(lines.size() - 1).createLine2(mousePoint);
      firstMousePress = false;
    }
  }
  
  //rectangle
  if((command == 'r') && (firstMousePress == false)){
    rectangles.add(new Rectangle());
    rectangles.get(rectangles.size() - 1).createRectangle1(mousePoint);
    firstMousePress = true;
  }
  
  else{
    if((command == 'r') && (firstMousePress == true)){
      rectangles.get(rectangles.size() - 1).createRectangle2(mousePoint);
      firstMousePress = false;
    }
  }
  
  
  //circle 
  if((command == 'c') && (firstMousePress == false)){
    circles.add(new Circle());
    circles.get(circles.size() - 1).createCircle1(mousePoint);
    firstMousePress = true;
  }
  
  else{
    if((command == 'c') && (firstMousePress == true)){
      circles.get(circles.size() - 1).createCircle2(mousePoint);
      firstMousePress = false;
    }
  }
  
  //ellipse 
  if((command == 'e') && (firstMousePress == false)){
    ellipses.add(new Ellipse());
    ellipses.get(ellipses.size() - 1).createEllipse1(mousePoint);
    firstMousePress = true;
  }
  
  else{
    if((command == 'e') && (firstMousePress == true)){
      ellipses.get(ellipses.size() - 1).createEllipse2(mousePoint);
      firstMousePress = false;
    }
  }
  
  //circleArc
  
  if((command == 'a') && (circleArcMousePresses == 0)){
    circleArcs.add(new CircleArc());
    circleArcs.get(circleArcs.size() - 1).createCircleArc1(mousePoint);
    circleArcMousePresses +=1;
  }
  else{
    if((command == 'a') && (circleArcMousePresses == 1)){
      circleArcs.get(circleArcs.size() - 1).createCircleArc2(mousePoint);
      circleArcMousePresses += 1;
    }
    else{
    if((command == 'a') && (circleArcMousePresses == 2)){
      circleArcs.get(circleArcs.size() - 1).createCircleArc3(mousePoint);
      circleArcMousePresses = 0;
    }
    }
  }
  }
}

void userInterface(){
  line(0, 600,width,600);
  
  line(5,695,95,605);
  textSize(30);
  text('l', 5, 650);
  
  noFill();
  rectMode(CORNERS);
  rect(105, 605, 195,650);
  textSize(30);
  text('r', 145, 675);
  
  noFill();
  circle(250, 650, 90);
  textSize(30);
  text('c', 245, 655);
  
  noFill();
  ellipse(350, 650, 90,60);
  textSize(30);
  text('e', 345, 655);
  
  noFill();
  arc(450,650,90,90,PI/4, (7*PI)/4);
  text('a', 445, 655);
  
  if(firstEnter == false){
    textSize(30);
    text("X = " + str(number), 510, 665);
  }
  else{
    textSize(30);
    text("X = " + str(buffer*pixToMm) + " Y = " + str(number),510,665);
  }
}
