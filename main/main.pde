Cross[] crosses;
PImage img;

void setup() {
    size(800, 500);
    img = loadImage("./image.png");
    img.resize(floor(img.width*0.8), floor(img.height*0.8));
    crosses = new Cross[150];
    for (int i=0; i<crosses.length; i++) {
        float rand = random(30, 50);
        crosses[i] = new Cross(random(200, width-200), random(height), rand, rand/7.0);
    }
}

void draw() {
    background(20);
    image(img, (width-img.width)/2.0 + 30, (height-img.height));
    for (Cross cross : crosses) {
        cross.draw();
    }
}

class Cross {
    PVector pos;
    PVector vec;
    float len;
    float w;
    long timePoint;
    long flashTime;
    boolean upper = true;
    final float SEED = random(-PIE, PIE);
    float initX;
    final float SHACK = random(20, 50);
    final float SHACK_GAP = random(30, 60);
    final color COLOR = color(random(190, 255), random(0, 100), random(0, 100));

    Cross(float x, float y, float len, float w) {
        this.pos = new PVector(x, y);
        this.initX = x;
        this.len = len;
        this.w = w;
        this.flashTime = floor(random(3, 6)*1000);
        this.timePoint = floor(random(this.flashTime));
        this.vec = new PVector(0, random(1, 6));
    }

    void draw() {
        this.pos.x = this.pos.y+(this.len*sin(PIE/4.0))/2.0 < 0 ? random(200, width-200) : initX + sin(frameCount/this.SHACK_GAP+this.SEED)*this.SHACK;
        this.pos.y = this.pos.y+(this.len*sin(PIE/4.0))/2.0 < 0 ? height+(this.len*sin(PIE/4.0))/2.0 : this.pos.y - this.vec.y;
        this.upper = (this.timePoint += this.upper? 60 : -60) < 0 || this.timePoint > this.flashTime ? !this.upper : this.upper;

        push();
        noStroke();
        fill(this.COLOR, map(this.timePoint, 0, this.flashTime, 0, 255));

        pushMatrix();
        translate(this.pos.x-this.len*cos(PIE/4.0)/2.0, this.pos.y-this.len*cos(PIE/4.0)/2.0);
        rotate(PIE/4.0);
        rect(0, -this.w/2.0, this.len, this.w, 30);
        popMatrix();

        pushMatrix();
        translate(this.pos.x-this.len*cos(PIE/4.0)/2.0, this.pos.y-this.len*cos(PIE/4.0)/2.0+this.len*sin(PIE/4.0));
        rotate(-PIE/4.0);
        rect(0, -this.w/2.0, this.len, this.w, 30);
        popMatrix();
        pop();
    }
}
