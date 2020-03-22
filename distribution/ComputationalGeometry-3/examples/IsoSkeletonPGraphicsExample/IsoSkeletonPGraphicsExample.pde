/*-----------------------------------
 Library: ComputationalGeometry
 By: Mark Collins & Toru Hasegawa
 Example: IsoSkeleton
 
 Creates a 3D skeleton with adjustable 
 thickness and node size, based on an
 edge pairing of points. This example draws into a canvas
 ------------------------------------*/

import ComputationalGeometry.*;
IsoSkeleton skeleton;

PGraphics canvas;

void setup() {
  size(250, 250, P3D);

  // Create iso-skeleton
  canvas = createGraphics(width, height, P3D);
  skeleton = new IsoSkeleton(canvas);

  // Create points to make the network
  PVector[] pts = new PVector[100];
  for (int i=0; i<pts.length; i++) {
    pts[i] = new PVector(random(-100, 100), random(-100, 100), random(-100, 100) );
  }  

  for (int i=0; i<pts.length; i++) {
    for (int j=i+1; j<pts.length; j++) {
      if (pts[i].dist( pts[j] ) < 50) {
        skeleton.addEdge(pts[i], pts[j]);
      }
    }
  }
}

void draw() {
  canvas.beginDraw();
  canvas.background(220);
  canvas.lights();  
  float zm = 150;
  float sp = 0.001 * frameCount;
  canvas.camera(zm * cos(sp), zm * sin(sp), zm, 0, 0, 0, 0, 0, -1);

  canvas.noStroke();
  skeleton.plot(10.f * float(mouseX) / (2.0f*width), float(mouseY) / (2.0*height));  // Thickness as parameter
  canvas.endDraw();

  image(canvas, 0, 0);
}
