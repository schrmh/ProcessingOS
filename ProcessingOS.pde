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
  //We don't have a finger on the screen at the beginning
  mouseX=W_TPX/2;
  //mouseY=;
  createWindow(); //Create Window relative to mouse position
}
void draw(){
  
  line(mouseX, mouseY, pmouseX, pmouseY);
  
  
  //Close Circle touched
  if(sq(mouseX - (W_TPX-pWM(WC_R,1))) + sq(mouseY - (W_FY+pWM(WC_R,1))) < WC_R*WC_R)
  {  
    println(mouseX,mouseY);
    stroke(255);
    noFill();
    createWindow();
  }
  
}

//Define position in Window Menu
int pWM(int element, int num){
  //Ignore (tenary operator was removed): 
  //Would love to be able to use the bool as a operator replacement 
  return num*(element+WM_SP);
}

void createWindow()
{
  rect(W_FX, W_FY, W_TX, W_TY); //Window
  line(W_FX, WD_P, W_TPX, WD_P); //Divider between menu bar and window content
  //ellipseMode(CORNER);
  //ellipse(W_TPX-WC_R*2-WM_SP, W_FY+WM_SP, WC_R*2, WC_R*2); //Close button
  ellipseMode(RADIUS);
  //ellipse(W_TPX-WC_R-WM_SP, W_FY+pWM(WC_R,true,1), WC_R, WC_R); //Close button
  ellipse(W_TPX-pWM(WC_R,1), W_FY+pWM(WC_R,1), WC_R, WC_R); //Close button
}
