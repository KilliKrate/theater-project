/** Crea un punto che emana luce
  *
  * @author Ovidiu Costin Andrioaia
*/

class PuntoLuminoso {
  
  // Coordinate dell'oggetto
  private float x, y;
  
  // Raggio del corpo dell'oggetto e della luce che emana
  private float r1, r2;
  
  // Intensità della luce da r1 a r2
  private float startAlpha, endAlpha;
  
  // Colore del punto
  private color colorePunto, coloreLuce;
  
  
  /** Crea un punto luminoso di centro (x,y) e raggio r1
   *
   * @param x Coordinata X del Punto.
   * @param y Coordinata Y del Punto.
   * @param r1 Raggio del Punto.
   * @param colore il colore del Punto.
  */
  
  public PuntoLuminoso(float x, float y, float r1, color colorePunto) {
    
    // Assegnazione delle variabili prese in input
    this.x = x;
    this.y = y;
    this.r1 = r1;
    this.colorePunto = colorePunto;
  }
  
  /** Crea un punto luminoso di centro (x,y) e raggio r1,
    * seguito da una luce sotto forma di gradiente
    * che si estende da r1 a r2, che parte con una 
    * trasparenza startAlpha, finendo con una endAlpha
    *
    * @param x Coordinata X del Punto.
    * @param y Coordinata Y del Punto.
    * @param r1 Raggio del Punto.
    * @param r2 Raggio della Luce.
    * @param startAlpha Intensità con cui parte la luce del punto da r1.
    * @param endAlpha Intensità a cui arriverà la luce del punto a r2.
    * @param colorePunto il colore del Punto.
    * @param coloreLuce il colore della Luce.
  */
  
  public PuntoLuminoso(float x, float y, float r1, float r2,  float startAlpha, float endAlpha, color colorePunto, color coloreLuce) {
    
    // Assegnazione delle variabili prese in input
    this.x = x;
    this.y = y;
    this.r1 = r1;
    this.r2 = r2;
    this.startAlpha = startAlpha;
    this.endAlpha = endAlpha;
    this.colorePunto = colorePunto;
    this.coloreLuce = coloreLuce;
    
  }
  
  public void display() {
    
    ellipseMode(RADIUS);
    // Disegno il Punto
    stroke(this.coloreLuce);
    fill(this.colorePunto);
    ellipse(this.x, this.y, this.r1, this.r1); 
    noFill();
    
    // Disegno la luce tramite creando cerchi vuoti in un ciclo, e abbassando l'alpha del loro bordo
    // colorato man mano che si procede verso l'esterno
    for (float i = this.r1; i < this.r2; i++) {
      float alpha = map(i, this.r1, this.r2, this.startAlpha, this.endAlpha);
      stroke(this.coloreLuce, alpha);
      ellipse(this.x, this.y, i, i); 
    }
    noStroke();
    
  }

  public float getX(){
    return this.x;
  }
  
  public void setX(float x){
    this.x = x;
  }
  
  public float getY(){
    return this.y;
  }
  
  public void setY(float y){
    this.y = y;
  }

  public float getR1() {
    return this.r1;
  }

  public void setR1(float r1) {
    this.r1 = r1;
  }

  public float getR2() {
    return this.r2;
  }

  public void setR2(float r2) {
    this.r2 = r2;
  }

  public float getStartAlpha() {
    return this.startAlpha;
  }

  public void setStartAlpha(float startAlpha) {
    this.startAlpha = startAlpha;
  }

  public float getEndAlpha() {
    return this.endAlpha;
  }

  public void setEndAlpha(float endAlpha) {
    this.endAlpha = endAlpha;
  }

  public color getColorePunto() {
    return this.colorePunto;
  }

  public void setColorePunto(color colorePunto) {
    this.colorePunto = colorePunto;
  }
  
  public color getColoreLuce() {
    return this.coloreLuce;
  }
  
  public void setColoreLuce(color coloreLuce) {
    this.coloreLuce = coloreLuce;
  }
  
}
