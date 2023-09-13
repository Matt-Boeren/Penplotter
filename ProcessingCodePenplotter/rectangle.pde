class Rectangle{
  PVector corner1, corner2;
  
  void createRectangle1(PVector mousePoint1){
    corner1 = mousePoint1;
  }
  
  void createRectangle2(PVector mousePoint2){
    corner2 = mousePoint2;
  }
  
  void drawRectangle1(){
    noFill();
    rectMode(CORNERS);
    rect(corner1.x, corner1.y, mouseX, mouseY);
  }
  
  void drawRectangle2(){
    noFill();
    rectMode(CORNERS);
    rect(corner1.x, corner1.y, corner2.x, corner2.y);
  }
  
  String sendRectangle(){
    String rectangleInformation = "R " + str(int(corner1.x * pixToMm)) + " " + str(int(corner1.y * pixToMm)) + " " + str(int(corner2.x * pixToMm)) + " " + str(int(corner2.y * pixToMm));
    
    return rectangleInformation;
  }
}
