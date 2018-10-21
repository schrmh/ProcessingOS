import java.util.ArrayList;
ArrayList myQueries;
PShape window, border, dragpoint, divider, close, content;

abstractSearchObject queryBeingDragged;


int dragX;
int dragY;
 
void setup()
{
  queryBeingDragged = null;
  myQueries = new ArrayList();
  size(800, 500);
  
  Hit h1 = new Hit(random(width)/1.5,random(height)/1.5,(int)random(width/10,width/6),(int)random(height/32,height/16));
  Hit h2 = new Hit(random(width)/1.5,random(height)/1.5,(int)random(width/10,width/6),(int)random(height/32,height/16));
  myQueries.add(h1 );
  myQueries.add(h2 );
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
    evaluateQuerySelectionClose(myQuery1); //close button. Does kind of myQueries.remove(myQuery1);
    evaluateQuerySelection(myQuery1); //title bar
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
    println("Title bar");
  }
}

void evaluateQuerySelectionClose(abstractSearchObject close){ 
  if (close.inQueryClose(mouseX, mouseY) & queryBeingDragged==null){ 
    myQueries.remove(close); //remove Window from ArrayList
    println("Close button");
  }
}


// This is how to use inheritance.  Use interface instead if you want even more flexibility.
abstract class abstractSearchObject{
  float qx;
  float qy;
  int dQy;
  int dQx;
  int cRad=25; //WC_R
  //Y-Multiplicator:
  int yma=5;
  int ymb=4;
 
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
    content = createShape(RECT,qx,qy+dQy*yma,dQx,dQy*ymb); //Window content
    //border = createShape(RECT,qx,qy,dQx,dQy*4); //Window //maybe freeze window mode, lol
    divider = createShape(RECT, qx,qy,dQx,dQy); //title bar above window content
    ellipseMode(RADIUS);
    close = createShape(ELLIPSE, qx+dQx,qy, cRad,cRad); //Close button
    dragpoint = createShape();
    
    // Add the "child" shapes to the parent group
    window.addChild(content); //vertex for splitting feature and better coordinates than rect?
    //window.addChild(dragpoint); //may be dead now
    window.addChild(divider); //replace with vertex?
    window.addChild(close);
    
    stroke(0);
    shape(window);
  }
  
  boolean inQuery(int x, int y){ //Mouse clicked on title bar?
    /*print(x + " " + y);
    println(" is on title bar?");
    println("> x: "+ (int)(qx-dQx)+ " y: " + (int)(qy-dQy));
    println("< x: "+ (int)(qx+dQx)+ " y: " + (int)(qy+dQy));*/
    if((x > qx-dQx) & x < (qx+dQx)){
      if((y > qy-dQy)  & y < (qy+dQy)){
        //println(" YES");
        return true;
      }
    }
    //println(" NO");
    return false;
  }
  
  boolean inQueryClose(int x, int y){ //Mouse clicked on close button?
    //println(x + " " + y);
    //println((int)qx+dQx + " " + (int)qy);
    //print(" is on close?");
    if(sq(x - (qx+dQx)) + sq(y - qy) < cRad*cRad) //TODO: change 25 to circle close button size or replace with vertex, lol
    {
        //println(" YES");
        return true;
    }
    //qx+dQx,qy,25,25
    //println(" NO");
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
