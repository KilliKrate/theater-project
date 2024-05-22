Montagna[][] montagne;
CieloStellato cieloGrande;
PuntoLuminoso s;
Immagine robot;
Particella[] particelle = new Particella[100];
color[] colori;

float t, y, rectHeight;
int scene1 = 480, scene2 = 960, scene3 = 1440, scene4 = 1920;

public void settings() {
  size(1920, 1080, P2D);
}

void setup() {
  frameRate(24);
  
  montagne = new Montagna[4][2];
  
  montagne[0][0] = new Montagna(0, 898, width/2, height, 1.4, 9, 40, color(#000000));
  montagne[0][1] = new Montagna(width/2, height, width, 898, 1.4, 9, 40, color(#000000));
  montagne[1][0] = new Montagna(0, 1007, width/2, 791, 1.2, 9, 60, color(#000000));
  montagne[1][1] = new Montagna(width/2, 791, width, 1007, 1.2, 9, 60, color(#000000));
  montagne[2][0] = new Montagna(0, 820, width/2, 647, 1, 6, 80, color(#000000));
  montagne[2][1] = new Montagna(width/2, 647, width, 820, 1, 6, 80, color(#000000));
  montagne[3][0] = new Montagna(0, 539, width/2, 474, 1, 6, 120, color(#000000));
  montagne[3][1] = new Montagna(width/2, 474, width, 539, 1, 6, 120, color(#000000));
  
  s = new PuntoLuminoso(width/2, height, 50.0, 900.0, 200, 0, color(252, 183, 74), color(255, 132, 0));
  cieloGrande = new CieloStellato(750, 0, 3, 0, 2 * PI);
  cieloGrande.setSpeed(0.002);
  
  for(int i = 0; i < particelle.length; i++){
      particelle[i] = new Particella();
  }
  
  montagne[1][0].generateGrass(5000, 3, 5);
  montagne[1][1].generateGrass(5000, 3, 5);
  
  // Definisco l'istanza di Immagine
  robot = new Immagine(0, 0, 0, "ai.jpg", "ai_mask.png");
  // Carico l'immagine
  robot.load();
  // Rimpicciolisco l'immagine
  robot.reSize(robot.getWidth() / 2, robot.getHeight() / 2);
  // Applico la maschera
  robot.useMask();
}

void draw() {
 
  if (frameCount <= scene1) {
    fill(lerpColor(color(252, 183, 74), color(38, 42, 90), map(frameCount, 0, scene1, 0.7, 1)));
    rect(0, 0, width, height);
    noFill();
    
    s.display();
    t = map(frameCount, 0, scene1, 1, 0);
    y = 1-pow(t, 2.6);
    
    // Sposto l'immagine sull'asse x
    robot.setX(frameCount * 2);
    // Test per vedere la dinamicità della trasparenza
    
    if (frameCount <= scene1 / 4 && frameCount >= scene1 / 8){
      robot.increaseAlpha(0.5);
      robot.setTint();
      robot.display();
    }
    else if(frameCount > scene1 / 4 && frameCount <= scene1 / 2){
      robot.display();
    }
    else if(frameCount > scene1 / 2 && frameCount <= scene1){
      robot.decreaseAlpha(0.5);
      robot.setTint();
      robot.display();
    }
    montagne[0][0].setColour(lerpColor(color(242, 176, 102), color(255, 132, 0), map(frameCount, 0, scene1, 0.5, 0.3)));
    montagne[0][1].setColour(lerpColor(color(242, 176, 102), color(255, 132, 0), map(frameCount, 0, scene1, 0.5, 0.3)));
    
    montagne[1][0].setColour(lerpColor(color(177, 91, 58), color(255, 132, 0), map(frameCount, 0, scene1, 0.5, 0.3)));
    montagne[1][1].setColour(lerpColor(color(177, 91, 58), color(255, 132, 0), map(frameCount, 0, scene1, 0.5, 0.3)));
    
    montagne[1][0].blendGrassGreen(color(255, 132, 0), map(frameCount, 0, scene1, 0.5, 0.3));
    montagne[1][1].blendGrassGreen(color(255, 132, 0), map(frameCount, 0, scene1, 0.5, 0.3));
    
    montagne[2][0].setColour(lerpColor(color(110, 44, 28), color(255, 132, 0), map(frameCount, 0, scene1, 0.5, 0.3)));
    montagne[2][1].setColour(lerpColor(color(110, 44, 28), color(255, 132, 0), map(frameCount, 0, scene1, 0.5, 0.3)));
    montagne[3][0].setColour(lerpColor(color(50, 19, 25), color(255, 132, 0), map(frameCount, 0, scene1, 0.5, 0.3)));
    montagne[3][1].setColour(lerpColor(color(50, 19, 25), color(255, 132, 0), map(frameCount, 0, scene1, 0.5, 0.3)));
    
    montagne[0][0].moveY(map(y, 0, 1, 0, height), Direction.RIGHT); //<>//
    montagne[0][1].moveY(map(y, 0, 1, 0, height), Direction.LEFT);
    
    montagne[0][0].scaleY(y, Direction.RIGHT);
    montagne[0][1].scaleY(y, Direction.LEFT);
    montagne[1][0].scaleY(map(y, 0, 1, 0.5, 1), Direction.UP);
    montagne[1][1].scaleY(map(y, 0, 1, 0.5, 1), Direction.UP);
    montagne[2][0].scaleY(map(y, 0, 1, 0.75, 1), Direction.UP);
    montagne[2][1].scaleY(map(y, 0, 1, 0.75, 1), Direction.UP);
    montagne[3][0].scaleY(map(y, 0, 1, 0.875, 1), Direction.UP);
    montagne[3][1].scaleY(map(y, 0, 1, 0.875, 1), Direction.UP);
    
    for (int i = 3; i >= 0; i--) {
       montagne[i][0].display();
       montagne[i][1].display();
    }
    for(int i = 0; i < particelle.length; i++){
        particelle[i].show();
        particelle[i].update();
    }
    

    rectHeight = map(y, 0, 1, -height, 0);
    s.setY(montagne[3][0].getLastY());
    
    fill(0, 0, 0);
    rect(0, height, width, rectHeight);
    noFill();
  } 
  
  if (frameCount > scene1 && frameCount <= scene2) {
    color backColor = lerpColor(color(38, 42, 90, 255), color(13, 15, 22, 0), map(frameCount, scene1, scene2, 0, 1));
    fill((backColor & 0xffffff) | ((frameCount < 2*(scene2-scene1)/3+scene1) ? 255 : (int)map(frameCount, scene1, scene2, 25, 20)) << 24);
    rect(0, 0, width, height);
    noFill();
    
    
    pushMatrix();
    translate(width/2, height/4 - 100);
    cieloGrande.display((int)map(frameCount, 2*(scene2-scene1)/3+scene1, scene2, 0, 255));  
    popMatrix();   
    
    t = map(frameCount, scene1, scene2, 1, 0);
    y = 1-pow(t, 2.6);
    
    s.setY(map(y, 0, 1, montagne[3][0].getLastY(), height));
    s.setR2(map(frameCount, scene1, scene2, 900, 300));
    s.display();
    
    float quarterScene = scene1+(scene2-scene1)/4;
    
    if (frameCount < quarterScene) {
      montagne[0][0].setColour(lerpColor(color(242, 176, 102), color(255, 132, 0), map(frameCount, scene1, quarterScene, 0.3, 0)));
      montagne[0][1].setColour(lerpColor(color(242, 176, 102), color(255, 132, 0), map(frameCount, scene1, quarterScene, 0.3, 0)));
      montagne[1][0].setColour(lerpColor(color(177, 91, 58), color(255, 132, 0), map(frameCount, scene1, quarterScene, 0.3, 0)));
      montagne[1][1].setColour(lerpColor(color(177, 91, 58), color(255, 132, 0), map(frameCount, scene1, quarterScene, 0.3, 0)));
      
      montagne[1][0].blendGrassGreen(color(255, 132, 0), map(frameCount, scene1, quarterScene, 0.3, 0));
      montagne[1][1].blendGrassGreen(color(255, 132, 0), map(frameCount, scene1, quarterScene, 0.3, 0));
      
      montagne[2][0].setColour(lerpColor(color(110, 44, 28), color(255, 132, 0), map(frameCount, scene1, quarterScene, 0.3, 0)));
      montagne[2][1].setColour(lerpColor(color(110, 44, 28), color(255, 132, 0), map(frameCount, scene1, quarterScene, 0.3, 0)));
      montagne[3][0].setColour(lerpColor(color(50, 19, 25), color(255, 132, 0), map(frameCount, scene1, quarterScene, 0.3, 0)));
      montagne[3][1].setColour(lerpColor(color(50, 19, 25), color(255, 132, 0), map(frameCount, scene1, quarterScene, 0.3, 0)));
    } else {
      montagne[0][0].setColour(lerpColor(color(242, 176, 102), color(#0d0f16), map(frameCount, quarterScene, scene2, 0, 0.8)));
      montagne[0][1].setColour(lerpColor(color(242, 176, 102), color(#0d0f16), map(frameCount, quarterScene, scene2, 0, 0.8)));
      montagne[1][0].setColour(lerpColor(color(177, 91, 58), color(#0d0f16), map(frameCount, quarterScene, scene2, 0, 0.8)));
      montagne[1][1].setColour(lerpColor(color(177, 91, 58), color(#0d0f16), map(frameCount, quarterScene, scene2, 0, 0.8)));
      
      montagne[1][0].blendGrassGreen(color(#0d0f16), map(frameCount, quarterScene, scene2, 0, 0.8));
      montagne[1][1].blendGrassGreen(color(#0d0f16), map(frameCount, quarterScene, scene2, 0, 0.8));
      
      montagne[2][0].setColour(lerpColor(color(110, 44, 28), color(#0d0f16), map(frameCount, quarterScene, scene2, 0, 0.8)));
      montagne[2][1].setColour(lerpColor(color(110, 44, 28), color(#0d0f16), map(frameCount, quarterScene, scene2, 0, 0.8)));
      montagne[3][0].setColour(lerpColor(color(50, 19, 25), color(#0d0f16), map(frameCount, quarterScene, scene2, 0, 0.8)));
      montagne[3][1].setColour(lerpColor(color(50, 19, 25), color(#0d0f16), map(frameCount, quarterScene, scene2, 0, 0.8)));
    }
    
    for (int i = 3; i >= 0; i--) {
       montagne[i][0].display();
       montagne[i][1].display();
    }

  }
  
  if (frameCount > scene2 && frameCount <= scene3){
    fill(color(13, 15, 22), map(frameCount, scene2, scene3, 10, 2));
    rect(0, 0, width, height);
    noFill();
    
    pushMatrix();
    translate(width/2, height/4 - 100);
    cieloGrande.display();
    popMatrix();
    
    montagne[0][0].setColour(lerpColor(color(242, 176, 102), color(#0d0f16), 0.8));
    montagne[0][1].setColour(lerpColor(color(242, 176, 102), color(#0d0f16), 0.8));
    montagne[1][0].setColour(lerpColor(color(177, 91, 58), color(#0d0f16), 0.8));
    montagne[1][1].setColour(lerpColor(color(177, 91, 58), color(#0d0f16), 0.8));
    montagne[2][0].setColour(lerpColor(color(110, 44, 28), color(#0d0f16), 0.8));
    montagne[2][1].setColour(lerpColor(color(110, 44, 28), color(#0d0f16), 0.8));
    montagne[3][0].setColour(lerpColor(color(50, 19, 25), color(#0d0f16), 0.8));
    montagne[3][1].setColour(lerpColor(color(50, 19, 25), color(#0d0f16), 0.8));
    
    for (int i = 3; i >= 0; i--) {
       montagne[i][0].display();
       montagne[i][1].display();
    }
  }
  
  if (frameCount > scene3 && frameCount <= scene4) {
    color backColor = lerpColor(color(13, 15, 22), color(38, 42, 90), map(frameCount, scene3, scene4, 0, 1));
    float oneSixth = (scene4-scene3)/6 + scene3;
    
    fill((backColor & 0xffffff) | (int)map(frameCount, scene3, scene4, 0, 255) << 24);
    rect(0, 0, width, height);
    noFill();
    
    pushMatrix();
    translate(width/2, height/4 - 100);
    cieloGrande.display((int)map(frameCount, scene3, oneSixth, 255, 0));
    popMatrix();
    
    if (frameCount > oneSixth) {
      t = map(frameCount, oneSixth, scene4, 1, 0);
      y = pow(t, 2.6);
      s.setY(map(y, 0, 1, montagne[3][0].getLastY(), height));
    
      s.setR2(map(frameCount, oneSixth, scene4, 300, 900));
      s.display(); 
    }
    
    montagne[0][0].setColour(lerpColor(color(242, 176, 102), color(#0d0f16), map(frameCount, scene3, scene4, 0.8, 0)));
    montagne[0][1].setColour(lerpColor(color(242, 176, 102), color(#0d0f16), map(frameCount, scene3, scene4, 0.8, 0)));
    montagne[1][0].setColour(lerpColor(color(177, 91, 58), color(#0d0f16), map(frameCount, scene3, scene4, 0.8, 0)));
    montagne[1][1].setColour(lerpColor(color(177, 91, 58), color(#0d0f16), map(frameCount, scene3, scene4, 0.8, 0)));
    montagne[2][0].setColour(lerpColor(color(110, 44, 28), color(#0d0f16), map(frameCount, scene3, scene4, 0.8, 0)));
    montagne[2][1].setColour(lerpColor(color(110, 44, 28), color(#0d0f16), map(frameCount, scene3, scene4, 0.8, 0)));
    montagne[3][0].setColour(lerpColor(color(50, 19, 25), color(#0d0f16), map(frameCount, scene3, scene4, 0.8, 0)));
    montagne[3][1].setColour(lerpColor(color(50, 19, 25), color(#0d0f16), map(frameCount, scene3, scene4, 0.8, 0)));
    
    for (int i = 3; i >= 0; i--) {
       montagne[i][0].display();
       montagne[i][1].display();
    }
    
  }
  
  //saveFrame("line-####.tif"); 
}
