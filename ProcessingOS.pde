  //Basic Window setup; W=WINDOW, F=FROM, T=TO
  //M=Menu, D=Divider, C= Circle, P=Position, R=Radius, SP=Space, S=Size
  int W_FX = 100;
  int W_FY = 100;
  int W_TY = 400;
  int W_TX = 400;
  int W_TPX = W_FX+W_TX; //right border of Window
  int WM_SP = 10;
  int WC_R = 25;
  int WB_S = 50;
  int WD_P = W_FY+pWM(WC_R,2); //From top border of window: Space, then circle, then Space.

void setup(){
  //init screen
  size(800, 600);
  //fullScreen();
  background(204);
  
  //Make always visible menu bar..
  //Make a coordinate grid here in another color..
  
  
  noFill();
  //We don't have a finger on the screen at the beginning (middle of window menu):
  mouseX=W_TPX/2+W_FX/2;
  mouseY=(WD_P-W_FY)/2+W_FY;
  point(mouseX, mouseY); //Maybe make a cross?
  println(mouseX,mouseY);
  createWindow(mouseX,mouseY); //Create Window relative to mouse position
}
void draw(){
  
  //line(mouseX, mouseY, pmouseX, pmouseY);
  
  stroke(204);
  noFill();
  createWindow(pmouseX,pmouseY);
  stroke(0);
  createWindow(mouseX,mouseY);
  
  
  //Close Circle touched
  if(sq(pmouseX - (W_TPX-pWM(WC_R,1))) + sq(pmouseY - (W_FY+pWM(WC_R,1))) < WC_R*WC_R)
  {  
    println(pmouseX,pmouseY);
    stroke(255);
    noFill();
    createWindow(pmouseX,pmouseY);
  }
  
}

//Define position in Window Menu
int pWM(int element, int num){
  return num*(element+WM_SP);
}

void createWindow(int X, int Y)
{
  rect(X-W_FX*2, Y-(WD_P-W_FY)/2, X+W_FX, Y+W_TY-(WD_P-W_FY)/2); //Window
  line(X-W_FX*2, Y+(WD_P-W_FY)/2, X+W_FX*2, Y+(WD_P-W_FY)/2); //Divider between menu bar and window content
  ellipseMode(RADIUS);
  ellipse(W_TPX-pWM(WC_R,1), W_FY+pWM(WC_R,1), WC_R, WC_R); //Close button
}
