class Circle {
  PVector midPoint;
  float radius;
  
  void createCircle1(PVector mousePoint1){
    midPoint = mousePoint1;
  }
  
  void createCircle2(PVector mousePoint2){
    radius = dist(midPoint.x, midPoint.y, mousePoint2.x, mousePoint2.y);
  }
  
  void drawCircle1(){
    noFill();
    circle(midPoint.x, midPoint.y, 2*dist(midPoint.x, midPoint.y, mouseX, mouseY));
  }
  
  void drawCircle2(){
    noFill();
    circle(midPoint.x, midPoint.y, 2*radius);
  }
  
  String sendCircle(){
    String circleInformation = "C " + str(int(midPoint.x * pixToMm)) + " " + str(int(midPoint.y * pixToMm)) + " " + str(int(radius * pixToMm));
    
    return circleInformation;
  }
}
