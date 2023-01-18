import peasy.*;
PeasyCam cam;
ArrayList<boxes> boxList = new ArrayList<boxes>();
float x;
float z;
float x2;
float z2;
float theta;
float r;
void setup()
{
  cam = new PeasyCam(this, 1000);
  fullScreen(P3D);
  rectMode(CENTER);
  frameRate(144);

  r = 300;
}

void draw()
{
  background(255);
  translate(0, -500, -200);

  if (keyPressed)
  {
    if (keyCode == RIGHT && r < width)
    {
      r += 5;
    } else if (keyCode == LEFT && r > 200)
    {
      r -= 5;
    }
  }

  x = cos(theta) * r;
  z = sin(theta) * r;
  x2 = -cos(theta) * r;
  z2 = -sin(theta) * r;
  theta += map(r, width, 200, .02, .1);

  boxList.add(new boxes(x, z));
  boxList.add(new boxes(x, z));
  boxList.add(new boxes(x2, z2));
  boxList.add(new boxes(x2, z2));

  for (int i = 0; i < boxList.size(); i++)
  {
    boxList.get(i).render();
    if (boxList.get(i).size < 0)
    {
      boxList.remove(i);
    }
  }

  fill(0);
  stroke(0);
  strokeWeight(10);
}

class boxes
{
  float x;
  float y;
  float z;

  float yMover = random(10, 12);
  float sizeChanger = random(.25, .5);

  float size = random(50, 75);
  float rot = 0;

  public boxes(float xL, float zL)
  {
    x = xL + random(-25, 25);
    y = height;
    z = zL;
  }

  public void render()
  {
    pushMatrix();
    translate(x, y, z);
    noStroke();
    fill(map(size, 40, 25, 255, 0), 0, map(size, 75, 50, 255, 0));
    rotateX(radians(rot));
    rotateY(radians(rot));
    rotateZ(radians(rot));
    box(size);

    y -= yMover;
    size -= sizeChanger;
    rot += 5;
    popMatrix();
  }
}
