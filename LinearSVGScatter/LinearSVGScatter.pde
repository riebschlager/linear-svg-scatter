ArrayList<PShape> shapes = new ArrayList<PShape>();
PGraphics canvas;
PImage source;
float currentY;
int outputW, outputH;

void setup() {
  outputW = 5100;
  outputH = 3300;
  background(255);
  source = loadImage("bitmap/source.jpg");
  source.resize(outputW, outputH);
  int appW, appH;
  if (outputW >= outputH) {
    appW = displayWidth;
    appH = outputH * (outputW / source.width);
  } 
  else {
    appH = displayHeight;
    appW = outputW * (outputH / source.height);
  }

  //  int appW = (outputW >= outputH) ? displayWidth : displayWidth * (outputW/displayWidth);
  //  int appH = (outputH >= outputW) ? displayHeight : displayHeight * (outputH/displayHeight);

  println(appW);
  println(appH);


  size(appW, appH);
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
  if (random(1) > 0.2) {
    scaleFactor = random(0.25, 0.50);
  }
  else {
    scaleFactor = random(4, 10);
  }
  canvas.strokeWeight(0.25/scaleFactor);
  if (random(1) > 0.35) {
    canvas.fill(c);
  } 
  else {
    canvas.fill(255);
  }

  canvas.shape(shape, width/2 + random(600), currentY);
  currentY += random(30);
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

