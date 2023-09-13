class CircleArc{
  PVector midPoint;
  float startAngle, endAngle, radius;
  
  void createCircleArc1(PVector mousePoint1){
    midPoint = mousePoint1;
  }
  
  void createCircleArc2(PVector mousePoint2){
    radius = dist(midPoint.x, midPoint.y, mousePoint2.x, mousePoint2.y);

  if(mousePoint2.x < midPoint.x){
    startAngle = PI + asin((midPoint.y - mousePoint2.y)/radius);
  }
  
  else{
  
  if(mousePoint2.y > midPoint.y){
    startAngle = -asin((midPoint.y - mousePoint2.y)/radius);
  }
  
  if(mousePoint2.y <= midPoint.y){
    startAngle = TWO_PI - asin((midPoint.y - mousePoint2.y)/radius);
  }
  
  }
  }
  void createCircleArc3(PVector mousePoint3){
  
  if(mousePoint3.x < midPoint.x){
    endAngle = PI + asin((midPoint.y - mousePoint3.y)/radius);
  }
  
  else{
  
  if(mousePoint3.y > midPoint.y){
    endAngle = -asin((midPoint.y - mousePoint3.y)/radius);
  }
  
  if(mousePoint3.y <= midPoint.y){
    endAngle = TWO_PI - asin((midPoint.y - mousePoint3.y)/radius);
  }
  
  }
  
  }
  
  void drawCircleArc1(){
    noFill();
    line(midPoint.x, midPoint.y, mouseX, mouseY);
  }
  
  void drawCircleArc2(){
    
    float tempEndAngle = 0;
    
    if(mouseX < midPoint.x){
      tempEndAngle = PI + asin((midPoint.y - mouseY)/radius);
    }
  
    else{
  
    if(mouseY > midPoint.y){
      tempEndAngle = -asin((midPoint.y - mouseY)/radius);
    }
  
    if(mouseY <= midPoint.y){
      tempEndAngle = TWO_PI - asin((midPoint.y - mouseY)/radius);
    }
  
    }
    
    noFill();
    
    if(startAngle <= tempEndAngle){
      arc(midPoint.x, midPoint.y, radius*2, radius*2, startAngle, tempEndAngle);
    }
    
    else{
      arc(midPoint.x, midPoint.y, radius*2, radius*2, startAngle - TWO_PI, tempEndAngle);
    }
    
  }
  
  void drawCircleArc3(){
    noFill();
    
    if(startAngle <= endAngle){
      arc(midPoint.x, midPoint.y, radius*2, radius*2, startAngle, endAngle);
    }
    
    else{
      arc(midPoint.x, midPoint.y, radius*2, radius*2, startAngle - TWO_PI, endAngle);
    }
  }
  
  String sendCircleArc(){
    String circleArcInformation = "A " + str(int(midPoint.x * pixToMm)) + " " + str(int(midPoint.y * pixToMm)) + " " + str(int(radius * pixToMm)) + " " + str(startAngle/PI) + " " + str(endAngle/PI);
    
    return circleArcInformation;
  }
}
