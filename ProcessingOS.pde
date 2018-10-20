  int W_FX = 100;
  int W_FY = 100;
  int W_TY = 400;
  int W_TX = 400;
  int W_TPX = W_FX+W_TX; //right border of Window
  int WM_SP = 10;
  int WC_R = 25;
  int WB_S = 50;
  int WD_P = W_FY+pWM(WC_R,2); //From top border of window: Space, then circle, then Space.
  
  int X=250,Y=100;

// A Window object
Window w1;

void setup() {
  size(800, 600);
  w1 = new Window();
}

void draw() {
  background(204);
  translate(50, 15);
  w1.display();
 // w1.move();
}

//Define position in Window Menu
int pWM(int element, int num){
  return num*(element+WM_SP);
}
