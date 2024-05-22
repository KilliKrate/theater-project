/*
    Wrapper dell'oggetto PImage

    @author David Constantin Cirdan
*/


class Immagine{
  
  // Variabili dell'oggetto Immagine
  
  // Posizione nelle ascisse dell'oggetto
  float x;
  //Posizione nelle ordinate dell'oggetto
  float y;
  // Trasparenza dell'immagine
  float alpha;
  // Il filename dell'immagine che vogliamo utilizzare
  String fname;
  // Il filename della maschera dell'immagine
  String fmask;
  // Oggetto PImage di riferimento
  PImage img;
  // Oggetto PImage per la maschera;
  PImage mask;
  
  // Eventuale array di interi per la maskArray
  // int pix[];
  
  // Primo constructor
  Immagine(String filename){
    this.fname = filename;
  }
  // Secondo constructor
  Immagine(float posx, float posy, float alphaImage, String filename, String maskname){
    this.x = posx;
    this.y = posy;
    this.alpha = alphaImage;
    this.fname = filename;
    this.fmask = maskname;
  }
  // Carico il file dell'immagine all'interno dell'oggetto PImage
  public void load( ){
    img = loadImage(this.fname);
    mask = loadImage(this.fmask);
  }
  // Disegno l'immagine sul canvas 
  // avendo come parametri l'oggetto e le sue posizioni in x e y
  public void display(){
     image(img, this.x, this.y);
  }
  public void displayMask(){
    image(mask, this.x, this.y);
  }
  // Applico un'immagine PImage come maschera all'immagine attualmente in uso
  public void useMask(){
    img.mask(mask);
  }
  // Cambio la tinta dell'immagine rendendola più o meno trasparente oppure più o meno chiara
  public void setTint(){
    tint(255, this.alpha);
  }
  // Tint con i colori
  public void setColoredTint( int r, int g, int b, float a){
    tint( r, g, b, a);
  }
  // Cambio la dimensione dell'immagine
  public void reSize(int w, int h){
    img.resize(w, h);
    mask.resize(w, h);
  }

  /*
  
  Questi sono i metodi per usare la funzione mask
  con la maskArray (valori alpha dell'immagine)
  al posto dell'oggetto PImage 
  
  public void loadPix(){
    int[] pix = new int[img.width * img.height - 1];
    this.pix = pix;
    img.loadPixels();
    for (int i = 0; i < (img.width * img.height); i++){
      this.pix[i] = int(alpha(pixels[i]));
    }
    img.updatePixels();
  }
  
  public int[] getPixels(int[] ptArr){
    for(int i = 0; i < ptArr.length; i++){
      ptArr[i] = this.pix[i];
    }
    return ptArr;
  }
  
  public int getDimension(){
    return (img.width * img.height);
  }
  
  */
  
  public float getX(){
    return this.x; 
  }
  
  public void setX(float newX){
    this.x = newX;
  }
  
  public float getY(){
    return this.y;
  }
  
  public void setY(float newY){
    this.x = newY;
  }
  public float getAlpha(){
    return this.alpha;
  }
  public void setAlpha(float newAlpha){
    this.alpha = newAlpha;
  }
  public void increaseAlpha(float num){
    this.alpha += num;
  }
  public void decreaseAlpha(float num){
    this.alpha -= num;
  }
  public String getFname(){
    return this.fname;
  }
  public String getFmask(){
    return this.fname;
  }
  public PImage getImg(){
    return img;
  }
  public PImage getMask(){
    return mask;
  }
  public int getWidth(){
    return img.width;
  }
  
  public int getHeight(){
    return img.height;
  }
  
}
