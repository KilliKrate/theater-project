/** Crea una linea, deformata secondo un'algoritmo il cui risultato assomiglia ad una montagna
  *
  * @author Ovidiu Costin Andrioaia
*/

enum Direction {
  LEFT,
  RIGHT,
  UP,
  DOWN
}

class Montagna {
  
  // Coefficiente di riduzione del displacement.
  float decay;
  
  // Displacement iniziale. Per capire cos'è, guarda la funzione computeDisplacement.
  float displacement;
  
  // Punti della linea calcolati.
  float[][] points;
  float[][] ogPoints;
  
  // ArrayList che contiene i fili d'erba
  ArrayList<FiloErba> bs;
  
  color colour;
  
  /** Crea una linea "montagnosa" con coordinate di inizio e di fine, un coeff. di decadimento ed una distanza
   *
   * @param x1 Coordinata X dell'inizio della montagna.
   * @param y1 Coordinata Y dell'inizio della montagna.
   * @param x2 Coordinata X della fine della montagna.
   * @param y2 Coordinata Y della fine della montagna.
   * @param decay Coefficiente che detta con quanto viene ridotto il il displacement ad ogni iterazione.
   * @param distance la quantità di punti che formano la linea, più essi sono e più la montagna risulta visivamente distante.
  */
  
  public Montagna(float x1, float y1, float x2, float y2, float decay, int distance) {
    
    // Di default il displacement è pari all'altezza della montagna. 
    this.displacement = abs(y1 - y2);
    this.decay = decay;
    
    // Creo l'array di punti che, collegati, formano la montagna. Esso avrà sempre lunghezza 2^N + 1
    // perchè questo rende la distanza coerente (mi aspetto che un valore distanza di 2 sia doppiamente
    // distante rispetto a 1) ed inoltre, essendo sempre dispari, posso adottare un algoritmo più efficiente.
    this.points = new float[int(pow(2, distance)+1)][2];
    
    // Il punto iniziale e finale dell'array punti sono esattamente quelli presi in input. La magia sta nel mezzo.
    this.points[0][0] = x1;
    this.points[0][1] = y1;
    this.points[points.length - 1][0] = x2;
    this.points[points.length - 1][1] = y2;
    
    this.points = this.computeDisplacement(points);
    this.ogPoints = new float[this.points.length][2];
    
    for (int i = 0; i < this.points.length; i++)
      arrayCopy(this.points[i], this.ogPoints[i]);
  }
  
  /** Crea una linea "montagnosa" con coordinate di inizio e di fine, un coeff. di decadimento ed una distanza.
   * Questo costruttuore mi permette di manipolare il displacement iniziale, dandomi migliore controllo sull'output
   *
   * @param x1 Coordinata X dell'inizio della montagna.
   * @param y1 Coordinata Y dell'inizio della montagna.
   * @param x2 Coordinata X della fine della montagna.
   * @param y2 Coordinata Y della fine della montagna.
   * @param decay Coefficiente che detta con quanto viene ridotto il il displacement ad ogni iterazione.
   * @param distance la quantità di punti che formano la linea, più essi sono e più la montagna risulta visivamente distante.
   * @param displacement un numero che definisce di quanto la y di ogni punto che forma la linea va traslato in y.
                         Più è basso, più la linea risulterà "pianeggiante". Più è alto, più la linea risulterà "ripida".
  */
  
  public Montagna(float x1, float y1, float x2, float y2, float decay, int distance, float displacement, color colour) {
    this.displacement = displacement;
    this.decay = decay;
    this.points = new float[int(pow(2, distance)+1)][2];
    this.colour = colour;
    this.bs = new ArrayList<FiloErba>();
    this.points[0][0] = x1;
    this.points[0][1] = y1;
    this.points[points.length - 1][0] = x2;
    this.points[points.length - 1][1] = y2;
       
    this.points = this.computeDisplacement(points);
    this.ogPoints = new float[this.points.length][2];
    
    for (int i = 0; i < this.points.length; i++)
      arrayCopy(this.points[i], this.ogPoints[i]);
  }
  
  /** Questa funzione è responsabile della creazione della linea che definisce la montagna. Esso adotta un
   * algoritmo molto simile alla ricerca binaria, rendendolo molto efficiente. Infatti con un O(2^N + 1), la sua efficienza
   * è N. La logica è semplice: Prendendo due estremi, trovo il punto centrale, lo imposto uguale alla media dei due estremi,
   * e poi lo offsetto in y di un valore pari a displacement. Se displacement fosse 0, e quindi io non offsetterei nulla,
   * risulterebbe una linea dritta. Se invece esso è molto alto, risulterebbe una montagna estremamente ripida. Questo valore,
   * insieme al decay, definisce di fatto la forma della montagna.
   *
   * @param ptArr L'array che la funzione riempirà con i punti calcolati
  */
  
  public float[][] computeDisplacement(float[][] ptArr) {
    
    // i è il mio puntatore, mentre i+dist è dove mi aspetto di trovare il punto opposto 
    int i = 0;
    int dist = ptArr.length - 1;
    
    // Quando la distanza si riduce a 1, significa che ogni punto dell'array è stato definito, e posso terminare il ciclo
    while (dist != 1.0) {
      while (true) {
        // Se il punto centrale ai due estremi e i+dist è uguale a 0, significa che non è ancora stato definito
        if (ptArr[int(this.avg(i, i+dist))][0] == 0.0) {
          // Con un random scelgo se offsettare il punto verso l'alto o verso il basso.
          float tempDisp = int(random(0, 2)) == 1 ? this.displacement : -this.displacement;
          // La posizione in x è semplicemente la x media dei due estremi
          ptArr[int(this.avg(i, i+dist))][0] = this.avg(ptArr[i][0], ptArr[i+dist][0]);
          // La posizione in y è la y media dei due estremi più (o meno) il displacement.
          ptArr[int(this.avg(i, i+dist))][1] = this.avg(ptArr[i][1], ptArr[i+dist][1]) + tempDisp;
        }
        
        // Ogni ciclo interno termina quando raggiungo la fine dell'array.
        if (i+dist == ptArr.length-1) 
          break; 
        // Altrimenti se non ho ancora raggiunto la fine, incremento il mio puntatore di un valore pari a dist.
        else 
          i += dist;
      }
      
      // Riparto dall'inizio, ma con distanza dimezzata
      i = 0;
      dist /= 2;
      
      // Il displacement decade ogni volta di una potenza negativa di due. Se il decay fosse 1, 2^-1 è 1/2, e quindi dimezza ogni volta.
      this.displacement *= pow(2, -this.decay);
    }
    
    return ptArr;
  }
  
  public void generateGrass(int amount, int sizeStart, int sizeEnd) {
    this.bs.clear();
    float[] point;
    for(int i=0; i<amount; i++) {
      point = this.getRandomPoint();
      this.bs.add(new FiloErba(point[0], point[1],int(random(sizeStart, sizeEnd)),1.0));
    }
  }
  
  public void blendGrassGreen(color newColor, float amount) {
    for (FiloErba filo : this.bs)
      filo.blendGreen(newColor, amount);
  }
  
  public void moveY(float y, Direction dir) {
    float distance;
    switch (dir) {
      case LEFT:
        distance = y - this.ogPoints[0][1];

        for (float[] point: this.ogPoints)
          point[1] += distance;
          
        for (int i = 0; i < this.ogPoints.length; i++)
          arrayCopy(this.ogPoints[i], this.points[i]);
          
        for (FiloErba filo : this.bs)
          filo.move(filo.getAnchorX(), filo.getAnchorY() + distance);
        
        break;
        
      case RIGHT:
        distance = y - this.getLastOgPoint()[1];        
        for (float[] point: this.ogPoints)
          point[1] += distance;
          
        for (int i = 0; i < this.ogPoints.length; i++)
          arrayCopy(this.ogPoints[i], this.points[i]);
          
        for (FiloErba filo : this.bs)
          filo.move(filo.getAnchorX(), filo.getAnchorY() + distance);
          
      break;  
      case UP:
      case DOWN:
      default:
        break;
    }
  }
  
  public void moveX(float x, Direction dir) {
     float distance;
     switch (dir) {
       case LEFT:
          distance = x - this.ogPoints[0][1];
         
          for (float[] point: this.ogPoints)
            point[0] += distance;
          
          for (int i = 0; i < this.ogPoints.length; i++)
            arrayCopy(this.ogPoints[i], this.points[i]);
          
          for (FiloErba filo : this.bs)
            filo.move(filo.getAnchorX() + distance, filo.getAnchorY());
        
       break;
       case RIGHT:
         distance = x - getLastOgPoint()[0];
        
         for (float[] point: this.ogPoints)
           point[0] += distance;
          
         for (int i = 0; i < this.ogPoints.length; i++)
           arrayCopy(this.ogPoints[i], this.points[i]);
           
         for (FiloErba filo : this.bs)
            filo.move(filo.getAnchorX() + distance, filo.getAnchorY());
       break;
       case UP:
       case DOWN:
       default:
        break;
     }
  }
  
  public void scaleX(float scale, Direction dir) {
    switch (dir) {
      case LEFT:
        for (int i = 1; i < this.ogPoints.length; i++)
          this.points[i][0] = (abs(this.ogPoints[i][0] - this.ogPoints[0][0])) * scale + this.ogPoints[0][0];
        break;
        
      case RIGHT:
        for (int i = 0; i < this.ogPoints.length - 1; i++)
          this.points[i][0] = this.ogPoints[this.ogPoints.length - 1][0] - (abs(this.ogPoints[this.ogPoints.length - 1][0] - this.ogPoints[i][0])) * scale;
        break;
        
      default:
        break;
    }
  }
  
  public void scaleY(float scale, Direction dir) {
    switch (dir) {
      case LEFT:
      for (int i = 0; i < this.ogPoints.length; i++)
        this.points[i][1] = this.ogPoints[0][1] - (this.ogPoints[0][1] - this.ogPoints[i][1]) * scale;
      break;
        
      case RIGHT:
        for (int i = 0; i < this.ogPoints.length; i++)
          this.points[i][1] = this.getLastOgPoint()[1] - (this.getLastOgPoint()[1] - this.ogPoints[i][1]) * scale;
        break;
      case UP:
        for (int i = 0; i < this.ogPoints.length; i++)
          this.points[i][1] = height - (height - this.ogPoints[i][1]) * scale;
        break;
        
      case DOWN:
        break;
        
      default:
        break;
    }
    
  }
  
  /** Questa funzione disegna la montagna come una forma geometrica che parte dall'inizio verticale del canvas
   * riempiendola con un colore a scelta
   *
   * @param colore il colore della montagna
  */
  
  public void display() {
    fill(colour);
    beginShape();
    
    vertex(this.points[0][0], height);
    for (int i = 0; i < this.points.length; i++) {
      vertex(this.points[i][0], this.points[i][1]);
    }
    vertex(this.points[this.points.length-1][0], height);
    
    endShape(CLOSE);
    noFill();
    
    for(FiloErba b : this.bs) {
      b.update(-50, height/4, 1.5, 1.5);
      b.draw();
    }
    
  }
  
  public float[][] getPoints() {
     return this.points; 
  }
  
  public float[] getPoint(int index) {
    return this.points[index];
  }
  
  public void setPoint(int index, float[] values) {
    this.points[index] = values;
  }
  
  public float getLastY() {
    return this.points[this.points.length-1][1];
  }
  
  public float[] getLastOgPoint() {
    return this.ogPoints[this.ogPoints.length-1];
  }
  
  public color getColour() {
    return this.colour;
  }
  
  public void setColour(color colour) {
    this.colour = colour;
  }
  
  private float avg(float n1, float n2){
    return (n1+n2)/2;
  }
  
  private float[] getRandomPoint() {
    float x = random(this.points[0][0], this.points[this.points.length-1][0]);
    float[] closestPoint = {0, 0};
    for (float[] point : this.points) {
      if (abs(x - point[0]) < abs(x - closestPoint[0]))
        arrayCopy(point, closestPoint);
    }
    float y = random(closestPoint[1], height);
    float[] point = {x, y};
    return point;
  }
  
  
  
}
