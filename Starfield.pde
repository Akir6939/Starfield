Particle[] dust = new Particle[150];
boolean flashlight,fast,strobe;
void setup()
{
	flashlight=fast=strobe=false;
	size(500,500);
	for(int i = 146;i<dust.length;i++)
		dust[i] = new OddballParticle(250,250);
	for(int i = 0; i<dust.length-4;i++)
		dust[i] = new Particle(250,250,Math.random()*TWO_PI,Math.random()*5);
}
void draw()
{
	if(strobe||flashlight)
		background(0);
	else
		background(100);
	for(Particle p : dust)
		p.doDraw();
}
void mousePressed(){
	strobe = flashlight = fast = false;
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
	if(key=='r'||key=='R'){
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
	int r,g,b;
	Particle(double x, double y, double angle, double speed){
		this.x=x;
		this.y=y;
		this.angle=angle;
		this.speed=speed;
		opacity = 255.0;
		r = g = b = 255;
	}
	Particle(){
	}
	void doDraw(){
		show();
		move();
		updateOpacity();
		colorStrobe();
		checkForOffScreen();

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
		r=g=b=255;
		x=y=250;
		angle = Math.random()*TWO_PI;
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
		x+=1.2*(Math.random()*speed-speed/2);
		y+=1.2*(Math.random()*speed-speed/2);
	}
	void show(){
		fill(r,g,b,(float)opacity);
		stroke(r,g,b,(float)opacity);
		rect((float)x,(float)y,20.0,20.0,5.0);
	}
	void updateOpacity(){
		if(strobe){
			if(opacity>=255)
				opacity=0;
			opacity+=10;
		}
		if(!strobe)
			opacity = 127;
	}
}