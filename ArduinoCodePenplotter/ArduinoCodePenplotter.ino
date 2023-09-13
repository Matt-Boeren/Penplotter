   //code penplotter matt boeren 6IW


//pins x axis + micros for the steps
#define pulseX 2
#define dirX 5
unsigned long Xmicros; 

//pins y axis + micros for the steps
#define pulseY 3
#define dirY 6
unsigned long Ymicros;

//enable pin
#define enablePin 8

//limitswitches
#define limitX 9
#define limitY 10

//speeds in mm/s
#define moveSpeed 15
#define drawSpeed 5
#define homeSpeed 10

//steps/mm for the axis
#define Xstepsmm 100
#define Ystepsmm 80

//locations 
float X;
float Y;

//z axis
#include <Servo.h>
Servo Zaxis;
int angle = 100;

void setup() {
  
  pinMode(pulseX, OUTPUT);
  pinMode(dirX, OUTPUT);
  
  pinMode(enablePin, OUTPUT);

  pinMode(limitX, INPUT_PULLUP);
  pinMode(limitY, INPUT_PULLUP);

  digitalWrite(enablePin, HIGH);
  digitalWrite(pulseX, LOW);
  digitalWrite(dirX, LOW);

  digitalWrite(pulseY, LOW);
  digitalWrite(dirY, LOW);

  Zaxis.attach(11);
  Zaxis.write(0);

  Serial.begin(9600);

  Home();
  
}

void loop() {

  Serial.println("1");
  while(Serial.available() == 0);

  char com = Serial.read();

  if(com == 'H'){

    Home();
  }

  if(com == 'L'){

    int datal[4];

    for(int i=0; i < 4; i++){
      
      datal[i] = Serial.parseInt();
       
    }
    
    line(datal[0], datal[1], datal[2], datal[3]);
    
  }

  if(com == 'R'){

    int datar[4];

    for(int i=0; i < 4; i++){
      
      datar[i] = Serial.parseInt();
       
    }
    
    rect(datar[0], datar[1], datar[2], datar[3]);
    
  }


  if(com == 'C'){

    int datac[3];

    for(int i=0; i < 3; i++){
      
      datac[i] = Serial.parseInt();
       
    }
    
    circle(datac[0], datac[1], datac[2]);

  }

  if(com == 'E'){
    
    int datae[4];

    for(int i=0; i < 4; i++){
      
      datae[i] = Serial.parseInt();
       
    }
     
    ellips(datae[0], datae[1], datae[2], datae[3]);
    
  }

  if(com == 'A'){

    float dataA[5];

    for(int i=0; i < 5; i++){
      
      dataA[i] = Serial.parseFloat();
       
    }
    circleArc(dataA[0], dataA[1], dataA[2], dataA[3], dataA[4]); 
  }

  if(com == '+'){
    angle += 5;
    
    Zaxis.write(angle);
    delay(1000);
    Zaxis.write(0);
  }

  if(com == '-'){
    angle -= 5;
    
    Zaxis.write(angle);
    delay(1000);
    Zaxis.write(0);
  }

}

//Home()
//moveTo(mX,mY,Speed)
//line(X1,Y1,X2,Y2)
//rect(X1,Y1,X2,Y2)
//circle(midX,midY,R)
//ellips(midX,midY,distX,distY)
//circleArc(midX,midY, R, Sangle, Eangle)


void Home(){

  digitalWrite(enablePin, LOW);

  //calculate time
  int timeX = 1000000/(homeSpeed*Xstepsmm);
  int timeY = 1000000/(homeSpeed*Ystepsmm);

  
  //direction
  digitalWrite(dirX, LOW);
  digitalWrite(dirY, HIGH);

  Xmicros = micros();
  Ymicros = micros();

  //move the motors until they hit the limit swithch
  while((digitalRead(limitX) == 1) || (digitalRead(limitY) == 1)){
    
    if(digitalRead(limitX) == 1){
      if((micros() - Xmicros) >= timeX){
        digitalWrite(pulseX, HIGH);
        
        Xmicros = micros();
      }
    }
    digitalWrite(pulseX, LOW);

    if(digitalRead(limitY) == 1){
      if((micros() - Ymicros) >= timeY){
        digitalWrite(pulseY, HIGH);
        Ymicros = micros();
      }
    }
    digitalWrite(pulseY, LOW);
  }
  digitalWrite(enablePin, HIGH);
  
  X = 0;
  Y = 0;


}


void moveTo(float mX, float mY, int Speed){

  //determine direction
  
  if((mX - X) > 0){
    digitalWrite(dirX, HIGH); 
  }
  else{
    digitalWrite(dirX, LOW);
  }

  if((mY - Y) > 0){
    digitalWrite(dirY, LOW); 
  }
  else{
    digitalWrite(dirY, HIGH);
  }

  //calculate speed and time
  float Length = sqrt((pow((mX - X),2))+(pow((mY - Y), 2)));

  float speedX = (abs((mX - X))/Length)*Speed;
  float speedY = (abs((mY - Y))/Length)*Speed;
  
  float timeX = 1000000/(speedX*Xstepsmm);
  float timeY = 1000000/(speedY*Ystepsmm);
  
  double stepsX = 0;
  double stepsY = 0;

  //needed steps
  double stepsNeededX = abs((mX - X))*Xstepsmm;
  double stepsNeededY = abs((mY - Y))*Ystepsmm;


  //move the motors
  digitalWrite(enablePin, LOW);

  Xmicros = micros();
  Ymicros = micros();
    
  while((stepsX < stepsNeededX) || (stepsY < stepsNeededY)){

    if(stepsY < stepsNeededY){
      if((micros() - Ymicros) >= timeY){
        
        digitalWrite(pulseY, HIGH);
        stepsY += 1;
        Ymicros = micros();
      }
    }
    digitalWrite(pulseY, LOW);

        if(stepsX < stepsNeededX){
      if((micros() - Xmicros) >= timeX){
        
        digitalWrite(pulseX, HIGH);
        stepsX += 1;
        Xmicros = micros();
        
      }
    }
    digitalWrite(pulseX, LOW);
  }

  digitalWrite(enablePin, HIGH);
  
  X = mX;
  Y = mY;
}


void line(int X1, int Y1, int X2, int Y2){

  moveTo(X1, Y1, moveSpeed);

  Zaxis.write(angle);

  delay(500);
  
  moveTo(X2, Y2, drawSpeed); 

  Zaxis.write(0);
}


void rect(int X1, int Y1, int X2, int Y2){
   
  moveTo(X1, Y1, moveSpeed);

  Zaxis.write(angle);

  delay(500);

  moveTo(X2, Y1, drawSpeed);

  moveTo(X2, Y2, drawSpeed);

  moveTo(X1, Y2, drawSpeed);

  moveTo(X1, Y1, drawSpeed);

  Zaxis.write(0);
  
}

void circle(int midX, int midY, int R){

  moveTo((midX+R), midY, moveSpeed);
  
  Zaxis.write(angle);

  delay(500);
  
  for(int i = 1; i <= 100; i++){
    
    float cX = midX + (cos((TWO_PI*i)/100)*R);
    float cY = midY + (sin((TWO_PI*i)/100)*R);
    
    moveTo(cX,cY,drawSpeed);
  }
  Zaxis.write(0);
}

void ellips(int midX, int midY, int distX, int distY){
  
  moveTo((midX+(distX/2)), midY , moveSpeed);
  
  Zaxis.write(angle);

  delay(500);
  
  for(int i = 1; i <= 100; i++){
    
    float eX = midX + ((cos((TWO_PI*i)/100)*distX)/2);
    float eY = midY + ((sin((TWO_PI*i)/100)*distY)/2);
    
    moveTo(eX,eY,drawSpeed);
  }
  Zaxis.write(0);
}

void circleArc(int midX, int midY, int R, float Sangle, float Eangle){

  moveTo((midX+(R*cos(Sangle*PI))), (midY+(R*sin(Sangle*PI))), moveSpeed);
  
  Zaxis.write(angle);

  delay(500);

  int forSteps = abs((100*(Eangle-Sangle))/2);
  
  for(int i = 1; i <= forSteps; i++){
    
    float cX = midX + (cos((Sangle*PI)+((TWO_PI*i)/100))*R);
    float cY = midY + (sin((Sangle*PI)+((TWO_PI*i)/100))*R);
    
    moveTo(cX,cY,drawSpeed);
  }
  Zaxis.write(0);
}
