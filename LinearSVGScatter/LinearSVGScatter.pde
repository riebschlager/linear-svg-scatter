ArrayList<PShape> shapes = new ArrayList<PShape>();
PGraphics canvas;
PImage source;
float currentY;
int outputW, outputH;

void setup() {
  outputW = displayWidth;
  outputH = displayHeight;
  background(255);
  source = loadImage("bitmap/source.jpg");
  source.resize(outputW, outputH);
  size(outputW, outputH);
  canvas = createGraphics(width, height);
  loadVectors("ornaments", true);
}

void draw() {
  background(255);
  canvas.beginDraw();
  for (int i = 0; i < 100; i++) {
    update();
  }
  canvas.endDraw();
  image(canvas, 0, 0, width, height);
  scale(-1, 1);
  image(canvas, -width, 0, width, height);
}

void update() {
  frame.setTitle("Working...");
  int c = source.get((int) width/2, (int) currentY);
  PShape shape = shapes.get((int) random(shapes.size()));
  shape.resetMatrix();
  shape.disableStyle();
  shape.rotate(random(PI));
  float scaleFactor;
  if (random(1) > 0.9) {
    scaleFactor = random(0.25, 0.50);
  }
  else {
    scaleFactor = random(60, 100);
  }
  canvas.strokeWeight(0.25/scaleFactor);
  if (random(1) > 0.35) {
    canvas.fill(c);
  } 
  else {
    //canvas.fill(255);
  }

  canvas.shape(shape, width/2 + random(600), currentY);
  currentY += random(2);
  if (currentY > height) {
    frame.setTitle("Done!");
    noLoop();
  }
}

void loadVectors(String folderName, boolean loadChildrenAsShapes) {
  File folder = new File(this.sketchPath+"/data/vector/" + folderName);
  File[] listOfFiles = folder.listFiles();
  for (File file : listOfFiles) {
    if (file.isFile()) {
      PShape shape = loadShape(file.getAbsolutePath());
      if (loadChildrenAsShapes) {
        for (PShape layer : shape.getChildren()) {
          if (layer!=null) shapes.add(layer);
        }
      } 
      else {
        shapes.add(shape);
      }
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    background(255);
    canvas.beginDraw();
    canvas.clear();
    canvas.endDraw();
    currentY = 0;
    loop();
  }
  if (key == 's') {
    this.save("data/output/composition-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second() + ".tif");
  }
}

