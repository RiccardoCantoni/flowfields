class Particle{
  
  int xpos, ypos;
  int ttl;
  int c1,c2;
  
  public Particle(PVector v){
    this.xpos= (int)v.x;
    this.ypos= (int)v.y;
    this.ttl = PARTICLE_TTL+1;
    if(PERLIN_COLOR){
      float noise = pow(noise(xpos*0.007f, ypos*0.007f, zval_color)+0.5f,7)-0.5f;
      c1 = lerpColor(PARTICLE_COLOR_START_NEG,PARTICLE_COLOR_START_POS, noise);
      c2 = lerpColor(PARTICLE_COLOR_END_NEG,PARTICLE_COLOR_END_POS, noise);
    }else{
      c1 = PARTICLE_COLOR_START_NEG;
      c2 = PARTICLE_COLOR_END_NEG;
    }
  }
  
  public PVector position(){
    return new PVector(xpos, ypos);
  }
  
  public PVector tick(){
     if (ttl==0) return null;
     if (ttl==PARTICLE_TTL+1){
       ttl--;
       return new PVector(xpos,ypos);
     }
     PVector v =  flowField[xpos*height+ypos];
     PVector r = PVector.random2D().mult(PARTICLE_NOISE_FORCE);
     v=v.add(r);
     line(xpos,ypos,xpos+v.x,ypos+v.y);
     xpos+=v.x;
     ypos+=v.y;
     if(xpos>=width || xpos<0 || ypos>=height || ypos<0) return null;
     ttl--;
     return new PVector(xpos,ypos);
  }
  
  public void drawLine(int x1,int y1,int x2,int y2){
    float t = (float)ttl/(float)PARTICLE_TTL;
    stroke(lerpColor(c2,c1,t));
    line(x1,y1,x2,y2);
}
  
  
  
  
  
}
