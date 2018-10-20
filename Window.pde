class Window {
  PShape window, border, dragpoint, divider, close;
  
  Window() {
    // Create the shape group
    window = createShape(GROUP);
    
    border = createShape(RECT,X-W_FX*2, Y-(WD_P-W_FY)/2, W_TX, W_TY); //Window
    divider = createShape(LINE, X-W_FX*2, Y+(WD_P-W_FY)/2, X+W_FX*2, Y+(WD_P-W_FY)/2); //Divider between menu bar and window content
    ellipseMode(RADIUS);
    close = createShape(ELLIPSE, X+W_FX+WC_R+pWM(WC_R,1), Y+(WD_P-W_FY)/2-pWM(WC_R,1), WC_R, WC_R); //Close button
    dragpoint = createShape();
    
    dragpoint.beginShape(LINES);
    dragpoint.vertex(X-WM_SP,Y);
    dragpoint.vertex(X+WM_SP,Y);
    
    dragpoint.vertex(X,Y-WM_SP);
    dragpoint.vertex(X,Y+WM_SP);
    dragpoint.endShape();
  
    // Add the "child" shapes to the parent group
    window.addChild(border); //vertex for splitting feature and better coordinates than rect?
    window.addChild(dragpoint);
    window.addChild(divider); //Maybe replace with rect or vertex since it may be easier to fill?
    window.addChild(close);
  }

  void display() {
    // Locating and drawing the shape
    //pushMatrix();
    //translate(x, y);
    shape(window); // Draw the group
    //popMatrix();
  }
}
