Particle[] dust = new Particle[150];
boolean flashlight = false;
boolean fast = false;
boolean strobe = false;
void setup()
{
	background(0);
	size(500,500);
	dust[149] = new OddballParticle(250,250);
	dust[148] = new OddballParticle(250,250);
	dust[147] = new OddballParticle(250,250);
	dust[146] = new OddballParticle(250,250);
	dust[145] = new OddballParticle(250,250);
	for(int i = 0; i<dust.length-5;i++)
		dust[i] = new Particle(250,250,Math.random()*2*Math.PI,Math.random()*5);
}
void draw()
{
	background(0);
	for(Particle p : dust){
		p.show();
		p.move();
		p.updateOpacity();
		p.colorStrobe();
		p.checkForOffScreen();
	}
}
void mousePressed(){
	strobe = false;
	flashlight=false;
	for(Particle p : dust){
		p.reset();
		p.r=p.g=p.b=255;
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
	if(key=='t'||key=='T'){
		if(strobe){
			for(Particle p : dust)
				p.r=p.g=p.b=255;
		}
		strobe = !strobe;
	}
}
class Particle
{
	double x,y,angle,speed,opacity;
	int col,r,g,b;
	Particle(double x, double y, double angle, double speed){
		this.x=x;
		this.y=y;
		this.angle=angle;
		this.speed=speed;
		opacity = 255;
		r = g = b = 255;
	}
	Particle(){
	}
	void move(){
		x+=Math.cos(angle)*speed;
		y+=Math.sin(angle)*speed;
	}
	void show(){
		fill(r,g,b,(float)opacity);
		stroke(r,g,b,(float)opacity);
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
	void colorStrobe(){
		if(strobe){
			if(r>=255)
				r=20;
			if(g>=255)
				g=13;
			if(b>=255)
				b=9;
			r+=5;
			g+=11;
			b+=6;
		}
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
		r = g = b = 255;
	}
	void move(){
		x+=Math.random()*speed-speed/2;
		y+=Math.random()*speed-speed/2;
	}
	void show(){
		fill(r,g,b,(float)opacity);
		stroke(r,g,b,(float)opacity);
		rect((float)x,(float)y,20.0,20.0);
	}
	void updateOpacity(){

	}
}