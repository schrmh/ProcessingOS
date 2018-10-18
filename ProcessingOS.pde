import java.util.ListIterator;  
  
  //Basic Window setup; W=WINDOW, F=FROM, T=TO
  //M=Menu, D=Divider, C=Circle, B=Button, P=Position, R=Radius, SP=Space, S=Size
  int W_FX = 100;
  int W_FY = 100;
  int W_TY = 400;
  int W_TX = 400;
  int W_TPX = W_FX+W_TX; //right border of Window
  int WM_SP = 10;
  int WC_R = 25;
  int WB_S = 50;
  int WD_P = W_FY+pWM(WC_R,2); //From top border of window: Space, then circle, then Space.
  
  int i=0; //Windows index
  ArrayList<Integer> dragX = new ArrayList<Integer>();
  ArrayList<Integer> dragY = new ArrayList<Integer>();
  
  boolean oncreate=false; //Prevent that thousands of Windows get drawed while on create

void setup(){
  //init screen
  size(800, 600);
  //fullScreen();
  background(204);
  
  //Make always visible menu bar..
  //Make a coordinate grid here in another color..
  
  strokeWeight(1);
  noFill();
  //We don't have a finger on the screen at the beginning (middle of window menu):
  mouseX=W_TPX/2+W_FX/2;
  mouseY=(WD_P-W_FY)/2+W_FY;
  
  dragX.add(mouseX);
  dragY.add(mouseY);
  
  createWindow(mouseX,mouseY, i); //Create Window relative to mouse position
  
}
void draw(){
  
  //Redaw existing screen elements if mouse gets moved
  if(pmouseY!=mouseY || pmouseX!=mouseX)
  {
    strokeWeight(1);
    drawMenuBar();
    if(dragX.get(i)>-1 &&dragY.get(i)>-1)createWindow(dragX.get(i),dragY.get(i), i);
  }
  
  //Mouse cursor
  strokeWeight(1);
  stroke(0);
  ellipseMode(RADIUS);
  ellipse(mouseX, mouseY, WM_SP, WM_SP);
  strokeWeight(3);
  stroke(204);
  ellipse(pmouseX, pmouseY, WM_SP, WM_SP);
  

  //Window create button touched
  if(pmouseX<pWM(W_FX,1) && pmouseX >WM_SP && pmouseY<pWM(WB_S,1) && pmouseY>WM_SP)
  { 
    
    if (oncreate==false) 
    {
      oncreate=true;
      i++;
      dragX.add(-1);
      dragY.add(-1);
      createWindow(pmouseX,pmouseY, i); 
    }
    else oncreate=true;    
  }
  else oncreate=false;

  ListIterator<Integer> X = dragX.listIterator();
  ListIterator<Integer> Y = dragY.listIterator();
  int c=-1;
  //Window drag area touched
  while(X.hasNext())
  {
    int xp = X.next();
    if(mouseX<xp+50 && mouseX >xp-50)
    { 
      while(Y.hasNext())
      {
        c++;
        int yp = Y.next();
        if(mouseY<yp+50 && mouseY>yp-50)
        {
          stroke(204);
          noFill();
          strokeWeight(3);
          createWindow(xp,yp, i);
          stroke(0);
          strokeWeight(1);
          createWindow(mouseX,mouseY, c);
        }
      }
    }
  }
  
  
  //Close Circle touched
  if(sq(pmouseX - (dragX.get(i)+W_FX+WC_R+pWM(WC_R,1))) + sq(pmouseY - (dragY.get(i)+(WD_P-W_FY)/2-pWM(WC_R,1))) < WC_R*WC_R)
  {  
    println(pmouseX,pmouseY);
    stroke(204);
    noFill();
    createWindow(dragX.get(i),dragY.get(i), i);
    dragX.set(i,-1);
    dragY.set(i,-1);
  }
  
}

//Define position in Window Menu
int pWM(int element, int num){
  return num*(element+WM_SP);
}

void createWindow(int X, int Y, int index)
{
  println("Total number of windows:"+dragX.size());
  //Cross for dragging:
  dragX.set(index,X);
  dragY.set(index,Y);
  line(X-WM_SP,Y,X+WM_SP,Y);
  line(X,Y-WM_SP,X,Y+WM_SP);
  
  rect(X-W_FX*2, Y-(WD_P-W_FY)/2, W_TX, W_TY); //Window
  line(X-W_FX*2, Y+(WD_P-W_FY)/2, X+W_FX*2, Y+(WD_P-W_FY)/2); //Divider between menu bar and window content
  ellipseMode(RADIUS);
  ellipse(X+W_FX+WC_R+pWM(WC_R,1), Y+(WD_P-W_FY)/2-pWM(WC_R,1), WC_R, WC_R); //Close button
}

void drawMenuBar()
{
  stroke(0);
  line(0,pWM(WB_S/2,2),width,pWM(WB_S/2,2));
  rect(WM_SP,WM_SP,W_FX,WB_S);
}
