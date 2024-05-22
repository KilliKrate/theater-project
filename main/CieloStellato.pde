/** Classe CieloStellato
  *
  * @author Luciano Mateias
*/

color[] defaultColoreStelle = {
    color(157, 180, 255), color(167, 188, 255), color(175, 195, 255),
    color(192, 209, 255), color(228, 232, 255), color(251, 248, 255),
    color(255, 245, 236), color(255, 241,223), color(255, 215, 174),
    color(255, 190, 127), color(255, 187, 123)
};

class CieloStellato {

  private PuntoLuminoso[] stelle;
  
  // Possibili colori di una stella
  private color[] coloreStelle;
  
  /*
    TODO: Costruire la classe Stella che estenda PuntoLuminoso
  */
  private float[] raggioStelle;
  
  // Distanza dal centro di ognuna delle stelle
  private float[] distanzaStelle;
  
  // Angoli delle stelle
  private float[] angoloStelle;

  /*
    Velocità di movimento delle stelle nel
    cielo, espressa in angolo/frame
  */
  private float speed ;

  /** Crea un cielo stellato */
  public CieloStellato(){

   this(int(random(1, 30)), defaultColoreStelle, 0, 15, PI, 2 * PI);

  }
  
  /** Crea un cielo stellato con un
    * numero variabile di stelle e con
    * colori predefiniti
    *
    * @param numStelle numero di stelle del cielo
  */
  public CieloStellato(int numStelle){
    
   this(numStelle, defaultColoreStelle, 0, 15, PI, 2 * PI);
    
  }
  
  /** Crea un cielo stellato con un
    * numero variabile di stelle e con
    * colori prestabiliti
    * 
    * @param numStelle numero di stelle del cielo
    * @param coloreStelle lista dei colori per le stelle
  */
  public CieloStellato(int numStelle, color[] coloreStelle){
    
   this(numStelle, coloreStelle, 0, 15, PI, 2 * PI);
    
  }
  
  /** Crea un cielo stellato con un
    * numero variabile di stelle e con
    * colori predefiniti. Il raggio delle stelle
    * va da minR a maxR.
    * 
    * @param numStelle numero di stelle del cielo
    * @param minR raggio minimo raggiungibile di una stella
    * @param maxR raggio massimo raggiungibile da una stella
    * @param minAngle (espresso in radianti) angolo minimo da cui parte la stella
    * @param maxAngle (espresso in radianti) angolo massimo a cui può arrivare la stella
  */
  public CieloStellato(int numStelle, float minR, float maxR, float minAngle, float maxAngle){

    this(numStelle, defaultColoreStelle, minR, maxR, minAngle, maxAngle);

  }

  /** Crea un cielo stellato con un
    * numero variabile di stelle e con
    * colori prestabiliti. Il raggio delle stelle
    * va da minR a maxR.
    * 
    * @param numStelle numero di stelle del cielo
    * @param coloreStelle lista dei colori per le stelle
    * @param minR raggio minimo raggiungibile di una stella
    * @param maxR raggio massimo raggiungibile da una stella
    * @param minAngle (espresso in radianti) angolo minimo da cui parte la stella
    * @param maxAngle (espresso in radianti) angolo massimo a cui può arrivare la stella
  */
  public CieloStellato(int numStelle, color[] coloreStelle, float minR, float maxR, float minAngle, float maxAngle){
    
    this.stelle = new PuntoLuminoso[numStelle];
    this.coloreStelle = coloreStelle;
    
    this.raggioStelle = new float[numStelle];
    this.angoloStelle = new float[numStelle];
    this.distanzaStelle = new float[numStelle];
    
     for (int i = 0; i < numStelle; i++) {
      this.raggioStelle[i] = random(minR, maxR);
      this.angoloStelle[i] = random(minAngle, maxAngle);
      
      this.distanzaStelle[i] = random(-height, height);
      
      this.stelle[i] = new PuntoLuminoso(0, 0, 0, this.raggioStelle[i], 200, 200, randomColoreStella(), randomColoreStella());
    }

  }

  public void display(int alpha){

    for(int i = 0; i < this.getNumStelle(); i++){
      this.stelle[i].setX((height + this.distanzaStelle[i] + random(2)) * cos(this.angoloStelle[i]) + this.raggioStelle[i]);
      this.stelle[i].setY((height + this.distanzaStelle[i] + random(2)) * sin(this.angoloStelle[i]) + this.raggioStelle[i]);
      
      this.stelle[i].setStartAlpha(alpha);
      this.stelle[i].setEndAlpha(alpha);
      
      this.stelle[i].display();
      
      this.angoloStelle[i] += this.speed;
    }

  }
  
  public void display(){
    this.display(200);
  }
    
  public int getNumStelle(){
    return this.stelle.length;
  }

  public color randomColoreStella() {
    return this.coloreStelle[int(random(this.coloreStelle.length))];
  }
  
  public float getSpeed(){
    return this.speed;
  }
  
  public void setSpeed(float speed){
    this.speed = speed;
  }
  
}
