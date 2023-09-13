class Line {
  PVector startPoint, endPoint;
  
  void createLine1(PVector mousePoint1){
    startPoint = mousePoint1;
  }
  
  void createLine2(PVector mousePoint2){
   endPoint = mousePoint2;
 }
 
  void drawLine1(){
   line(startPoint.x, startPoint.y, mouseX, mouseY);
 }
 
  void drawLine2(){
   line(startPoint.x, startPoint.y, endPoint.x, endPoint.y);
  }
  
  String sendLine(){
    String lineInformation = "L " + str(int(startPoint.x * pixToMm)) + " " + str(int(startPoint.y * pixToMm)) + " " + str(int(endPoint.x * pixToMm)) + " " + str(int(endPoint.y * pixToMm));
    
    return lineInformation;
  }
}
