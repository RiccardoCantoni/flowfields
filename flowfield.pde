
//===============SETTINGS===============
int PARTICLES = 5000;
float PERLIN_SAMPLING_SCALE = 0.0025f;
float PERLIN_POW = 3;
float FORCE = 7;
float PARTICLE_NOISE_FORCE = 0.5f;
int PARTICLE_TTL = 75;
boolean PERLIN_COLOR = false;
color BACKGROUND_COLOR = color(50,50,50);
color PARTICLE_COLOR_START_NEG = color(50,50,50);
color PARTICLE_COLOR_END_NEG = color(132, 105, 51);
color PARTICLE_COLOR_START_POS = color(50,50,50);
color PARTICLE_COLOR_END_POS = color(221, 173, 13);
String OUTPUT_IMAGE = "output.jpg";
//======================================



PVector[] flowField;
PVector[] particles;
PVector p1;
PVector p2;
int index;
float zval_color;

void setup() {
  size(800, 800);
  frameRate(500);
  blendMode(BLEND);
  background(BACKGROUND_COLOR);
  //fill(255);
  flowField = generateFlowfield();
  particles = placeParticles(PARTICLES);
  index=0;
  zval_color = random(0,100000);
}

void draw(){
  if (index>=particles.length-1){ 
    //filter(INVERT);
    noLoop();
    if (OUTPUT_IMAGE!=null){
      save(OUTPUT_IMAGE);
    }
    return;
  }else{
    index++;
    Particle p = new Particle(particles[index]);
    p1 = p.position();
    p2 = p.position();
    for (int i=0; i<1000; i++){
      p2 = p.tick();
      if (p2==null) return;
      p.drawLine((int)p1.x,(int)p1.y,(int)p2.x,(int)p2.y);
      p1 = new PVector(p2.x,p2.y);
    }
  }
}

PVector[] placeParticles(int num){
  PVector[] v = new PVector[num];
  for (int i=0; i<num; i++){
    v[i] = new PVector(random(width), random(height));
  }
  
  return v;
}

PVector[] generateFlowfield(){
  PVector[] field = new PVector[(width*height)];
  float angle, noise;
  float zval = random(0,100000);
  for (int x=0; x<width; x++){
    for (int y=0; y<height; y++){
      noise = pow((noise(x*PERLIN_SAMPLING_SCALE, y*PERLIN_SAMPLING_SCALE, zval)+0.5f),PERLIN_POW)-0.5f;
      angle = noise*TWO_PI;
      field[x*height+y]=PVector.fromAngle(angle).mult(FORCE);
    }  
  }
  return field;
}
