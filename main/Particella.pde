/* 
    Crea una particella di polvere che si muove secono un pattern
    @author David Constantin Cirdan
*/

class Particella{

    float x;
    float y;
    Particella(){
      this.x = random(0, width);
      this.y = random(height / 1.5, height);
    }
    
    public void show(){
      fill(244, 164, 96, 130);
      noStroke();
      ellipse(this.x, this.y, 2, 2);
      this.x = this.x + 30;
      this.y = this.y + random(2);
      this.y = this.y - random(5);
      
    }
    public void update(){
      if( this.x >= width || this.y >= y){
        this.x = random(0, width);
        this.y = random(height / 2, height);
      }
    }
}
