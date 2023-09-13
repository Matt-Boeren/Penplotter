class Ellipse {
  PVector midPoint;
  float Width, Height;
  
  void createEllipse1(PVector mousePoint1){
    midPoint = mousePoint1;
  }
  
  void createEllipse2(PVector mousePoint2){
    Width = abs(mousePoint2.x - midPoint.x)*2;
    Height = abs(mousePoint2.y - midPoint.y)*2;
  }
  
  void drawEllipse1(){
    float Width1 = abs(mouseX - midPoint.x)*2;
    float Height1 = abs(mouseY - midPoint.y)*2;
    noFill();
    ellipse(midPoint.x, midPoint.y, Width1, Height1);
  }
  
  void drawEllipse2(){
    noFill();
    ellipse(midPoint.x, midPoint.y, Width, Height);
  }
  
  String sendEllipse(){
    String ellipseInformation = "E " + str(int(midPoint.x * pixToMm)) + " " + str(int(midPoint.y * pixToMm)) + " " + str(int(Width * pixToMm)) + " " + str(int(Height * pixToMm));
    
    return ellipseInformation;
  }
  
}
