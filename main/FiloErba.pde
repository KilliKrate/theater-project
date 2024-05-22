class FiloErba {
  float anchorx;
  float anchory;
  float offset;
  color originalGreen;
  color blendedGreen;
  float stiffness;
  int nSegments;
  ArrayList<float[]> segments;
 
  FiloErba(float setAnchorx,float setAnchory, int setSegments, float preOffset) {
    anchorx = setAnchorx;
    anchory = setAnchory;
    nSegments = setSegments;
    segments = new ArrayList<float[]>();
    for (int x = 0; x < setSegments; x++) {
      segments.add(new float[]{anchorx, anchory+10*x});
    }
    offset = random(100)/100 + preOffset;
    originalGreen = lerpColor(color((int)random(0, 50), (int)random(100, 255), (int)random(0, 100)), color(0, 0, 0), 0.3);
    this.blendedGreen = originalGreen;
    stiffness = random(1, 2);
    //grounding force
    segments.get(0)[0] = anchorx;
    segments.get(0)[1] = anchory;
  }
 
  void update(float blowx,float blowy,float forcex,float forcey) {
    //perlin noise wind, slightly offset from every other blade
    float wind = (noise(frameCount/100.0+offset)-0.5);
    //apply forces to each blade segment
    for (int x = 1; x < segments.size (); x++) {
      float[] segment = segments.get(x);
      segment[1] -= (((segments.size ()-x)*1))*stiffness;
      segment[0] += x*wind*(4);
      //effect of mouse acceleration
      float secondWind = dist(blowx, blowy, segment[0], segment[1]);
      if (secondWind < 100) {
        segment[0] += forcex*(20/secondWind*(4));
        segment[1] += forcey*(20/secondWind*(4));
      }
    }
    //pull joints together
    for (int x = 0; x < segments.size ()-1; x++) {
      float jointx = segments.get(x)[0] - segments.get(x+1)[0];
      float jointy = segments.get(x)[1] - segments.get(x+1)[1];
      float jointlength = sqrt(jointx*jointx + jointy*jointy);
      if (jointlength > 5*(4)) {
        float tempvar = 1.0/jointlength;
        jointx *= tempvar;
        jointy *= tempvar;
        jointx *= -5*(4);
        jointy *= -5*(4);
        segments.get(x+1)[0] = segments.get(x)[0] + jointx;
        segments.get(x+1)[1] = segments.get(x)[1] + jointy;
      }
    }
  }
  
  void blendGreen(color newColor, float amount) {
    this.blendedGreen = lerpColor(this.originalGreen, newColor, amount);
  }
  
  void move(float newAnchorX, float newAnchorY) {
    
    float distX = newAnchorX - this.anchorx;
    float distY = newAnchorY - this.anchory;
    
    this.anchorx = newAnchorX;
    this.anchory = newAnchorY;
    
    for (float[] segment : this.segments) {
      segment[0] += distX;
      segment[1] += distY;
    }
  }
  
  float getAnchorX() {
    return this.anchorx;
  }
  
  float getAnchorY() {
    return this.anchory;
  }
 
  void draw() {
    fill(blendedGreen);
    stroke(blendedGreen);
    int h = segments.size()-2;
    beginShape(TRIANGLE_STRIP);
      for (int x = 0; x < segments.size ()-1; x++) {
        float segmentx = segments.get(x)[0];
        float segmenty = segments.get(x)[1];
        vertex(segmentx+1*(h-x), segmenty);
        vertex(segmentx-1*(h-x), segmenty);
      }
    endShape();
    noFill();
    noStroke();
  }
}
