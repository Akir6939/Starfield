Particle[] dust = new Particle[150];
boolean flashlight = false;
boolean fast = false;
void setup()
{
	background(0);
	size(500,500);
	dust[149] = new OddballParticle(250,250);
	dust[148] = new OddballParticle(250,250);
	for(int i = 0; i<dust.length-2;i++)
		dust[i] = new Particle(250,250,Math.random()*2*Math.PI,Math.random()*5);
}
void draw()
{
	background(0);
	for(Particle p : dust){
		p.show();
		p.move();
		p.updateOpacity();
		p.checkForOffScreen();
	}
}
void mousePressed(){
	for(Particle p : dust){
		p.reset();
	}
}
void keyPressed(){
	if(key=='F'||key=='f')
		flashlight = !flashlight;
	if(key=='s'||key=='S'){
		if(fast){
			for(Particle p : dust)
				p.speed*=10;
		}
		if(!fast){
			for(Particle p : dust)
				p.speed/=10;
		}
		fast = !fast;
	}
}
class Particle
{
	double x,y,angle,speed,opacity;
	int col,r;
	Particle(double x, double y, double angle, double speed){
		this.x=x;
		this.y=y;
		this.angle=angle;
		this.speed=speed;
		opacity = 255;
		col = color(255,255,255);
	}
	Particle(){
	}
	void move(){
		x+=Math.cos(angle)*speed;
		y+=Math.sin(angle)*speed;
	}
	void show(){
		fill(col,(float)opacity);
		stroke(col,(float)opacity);
		ellipse((float)x,(float)y,10.0,10.0);
	}
	void reset(){
		x=y=250;
		angle = Math.random()*2*PI;
		speed = Math.random()*3+2;
	}
	void checkForOffScreen(){
		if(x>500||x<0||y>500||y<0) reset();
	}
	void updateOpacity(){
		if(!flashlight)
			opacity = dist((float)x,(float)y,250.0,250.0);
		if(flashlight)
			opacity = 255-dist((float)x,(float)y,250.0,250.0);
	}
}

class OddballParticle extends Particle
{
	OddballParticle(double x, double y){
		super();
		this.x = x;
		this.y = y;
		speed=6;
		opacity = 127;
		col = color(255,255,0);
	}
	void move(){
		x+=Math.random()*speed-speed/2;
		y+=Math.random()*speed-speed/2;
	}
	void show(){
		fill(col,(float)opacity);
		stroke(col,(float)opacity);
		rect((float)x,(float)y,20.0,20.0);
	}
	void updateOpacity(){

	}
}


