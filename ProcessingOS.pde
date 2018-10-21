import java.util.ArrayList;
ArrayList myQueries; //D 
PShape window, border, dragpoint, divider, close, content;

abstractSearchObject queryBeingDragged;


int dragX;
int dragY;
 
void setup()
{
  queryBeingDragged = null;
  myQueries = new ArrayList(); //D 
  size(800, 500);
  
  Hit h1 = new Hit(width/2.0+100,height/5.0+50,100,20);
  myQueries.add(h1 );
}
 
void draw()
{
  background(0);
  
  for(int i = 0; i < myQueries.size(); i++){
    abstractSearchObject myQuery1 = (abstractSearchObject)myQueries.get(i);
    myQuery1.display();
  }
}
 
 
void mousePressed(){
  for(int i = 0; i < myQueries.size(); i++){ 
     // note how I made it generic 
    abstractSearchObject myQuery1 = (abstractSearchObject)myQueries.get(i);
    evaluateQuerySelection(myQuery1);
  }
}

void mouseReleased(){
  queryBeingDragged = null; 
} 
 
void mouseDragged(){
  if( queryBeingDragged != null){
    queryBeingDragged.moveByMouseCoord(mouseX, mouseY);
   }
}  


void evaluateQuerySelection(abstractSearchObject myQuery1){ 
  if (myQuery1.inQuery(mouseX, mouseY) & queryBeingDragged==null){ 
    dragX = (int)myQuery1.qx - mouseX;
    dragY = (int)myQuery1.qy - mouseY;
    queryBeingDragged = myQuery1;
  }
}


// This is how to use inheritance.  Use interface instead if you want even more flexibility.
abstract class abstractSearchObject{
  float qx;
  float qy;
  int dQy;
  int dQx;
 
  abstractSearchObject(float tempQx, float tempQy,int tempdQx, int tempdQy) {
    qx= tempQx; //W_FX
     qy = tempQy; //W_FY
     dQx = tempdQx; //W_TX
     dQy = tempdQy; //W_TY
     
  
  }
 
  void display() {
    // Create the shape group
    window = createShape(GROUP);
    rectMode(RADIUS);
    content = createShape(RECT,qx,qy+dQy*5,dQx,dQy*4); //Window content
    //border = createShape(RECT,qx,qy,dQx,dQy*4); //Window //maybe freeze window mode, lol
    divider = createShape(RECT, qx,qy,dQx,dQy); //title bar above window content
    ellipseMode(RADIUS);
    close = createShape(ELLIPSE, qx+dQx,qy,25,25); //Close button
    dragpoint = createShape();
    
    // Add the "child" shapes to the parent group
    window.addChild(content); //vertex for splitting feature and better coordinates than rect?
    //window.addChild(dragpoint); //may be dead now
    window.addChild(divider); //replace with vertex?
    window.addChild(close);
    
    stroke(0);
    shape(window);
    
    
  }
  
  boolean inQuery(int x, int y){ //Move if mouse dragged on position of title bar element in query
    if((x > qx-dQx) & x < (qx+dQx)){
  if((y > qy-dQy)  & y < (qy+dQy)){
    
    return true;
  }
    }
    return false;
  }
  
  void moveByMouseCoord(int mausX, int mausY){
    this.qx = mausX + dragX;
    this.qy = mausY + dragY;
  }
}

class Hit extends abstractSearchObject{
  
  Hit(float tempQx, float tempQy,int tempdQx, int tempdQy) {
    super(tempQx,  tempQy, tempdQx,  tempdQy);
  }
}
