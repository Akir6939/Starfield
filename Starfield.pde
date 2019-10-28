Particle[] dust = new Particle[150];
void setup()
{
	background(0);
	size(500,500);
	dust[0] = new OddballParticle(250,250);
	dust[1] = new OddballParticle(250,250);
	for(int i = 2; i<dust.length;i++)
		dust[i] = new Particle(250,250,Math.random()*2*Math.PI,Math.random()*5);
}
void draw()
{
	background(0);
	for(Particle p : dust){
		p.show();
		p.move();
		p.checkForOffScreen();
	}
}
void mousePressed(){
	for(Particle p : dust){
		p.reset();
		p.speed = Math.random()*5;
	}
}
class Particle
{
	double x,y,angle,speed;
	int col;
	Particle(double x, double y, double angle, double speed){
		this.x=x;
		this.y=y;
		this.angle=angle;
		this.speed=speed;
		col = color((int)(Math.random()*255),(int)(Math.random()*255),(int)(Math.random()*255));
	}
	Particle(){
	}
	void move(){
		x+=Math.cos(angle)*speed;
		y+=Math.sin(angle)*speed;
	}
	void show(){
		fill(col);
		stroke(col);
		ellipse((float)x,(float)y,10.0,10.0);
	}
	void reset(){
		x=y=250;
		col = color((int)(Math.random()*255),(int)(Math.random()*255),(int)(Math.random()*255));
		angle = Math.random()*2*PI;
		speed = Math.random()*3+2;
	}
	void checkForOffScreen(){
		if(x>500||x<0||y>500||y<0) reset();
	}
}

class OddballParticle extends Particle
{
	OddballParticle(double x, double y){
		super();
		this.x = x;
		this.y = y;
	}
	void move(){
		x+=Math.random()*6-3;
		y+=Math.random()*6-3;
	}
	void show(){
		fill(255,0,0);
		stroke(255,0,0);
		rect((float)x,(float)y,20.0,20.0);
	}
}


