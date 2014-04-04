import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.core.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.mapdisplay.MapDisplayFactory;


UnfoldingMap map;
String[] paths;
int[] data;
ArrayList<Object> settlements;


void setup() {
  size(800, 600, OPENGL);
  paths = loadStrings("settlements-locations.csv");
  settlements =new ArrayList<Object>();
  
  
  processData();
  
  
}

void draw() {
  background(0);
  map.draw(); 
//  println(settlements.get(5).words);
  for (int i = 0; i < paths.length; i++) {
  println(paths[i] + " " + i);

}

//for (int i = 0; i < map.markers.size(); i++) {
//  println(maps.markers[i]);
//
//}
  
  
  noStroke();
  fill(250, 0, 0);

  // Shows geo-location at mouse position
  Location location = map.getLocation(mouseX, mouseY);
text(location.toString(), mouseX, mouseY);
//   text(location.toString(), mouseX, mouseY);
  
   fill(201, 0, 4);
  stroke(20);
  textSize(20);
  text("Welcome to the Occupied Territories", 260, 40);
  
  fill(255,0,0);
  textSize(14);
  text("Washington, DC", 20, 80);
//  textFont(mono);
//textSize(20);

  
  Marker marker = map.getFirstHitMarker(mouseX, mouseY);
  if (marker != null) {
    marker.setSelected(true);
    text("Settlement", 150, 80);
  }  
  
}

void processData() {
  
//  String mbTilesString = sketchPath("data/washDC.mbtiles");
  map = new UnfoldingMap(this, "map", new Microsoft.AerialProvider());
  Location dcLoc = new Location(38.8951 , -77.0367);
  map.zoomAndPanTo(dcLoc, 11);
  
  for(int i=1; i<paths.length; i++) {
    String[] thisRow = split(paths[i], ",");
    Location thisLocation = new Location(float(thisRow[0]), float(thisRow[1]));
    SimplePointMarker here = new SimplePointMarker(thisLocation);
    color c = color( random(236), random(104), random(45)); 
//    ellipse(20, 30);
    fill(0,0,40);
    stroke(50);
    String tempWords = thisRow[2];
    Object tempObject = new Object(tempWords);
    settlements.add(tempObject);
    
//    fill(0);
//    text("NASA", 250, 25);
    here.setColor(c);
    here.setStrokeWeight(0);
    map.addMarkers(here);
    data = int(split(thisRow[1], ',' ));
    for (int j = 0; j < data.length; j ++ ) {
    // The array of ints is used to set the color and height of each rectangle.
    fill(data[j]); 
    rect(j*20,0,20,data[j]);
  }

  } 
    MapUtils.createDefaultEventDispatcher(this, map); 

   

}

void mouseMoved() {
  // Deselect all marker
  for (Marker marker : map.getMarkers()) {
    marker.setSelected(false);
  }

  // Select hit marker
  // Note: Use getHitMarkers(x, y) if you want to allow multiple selection.
  
  Marker marker = map.getFirstHitMarker(mouseX, mouseY);
  if (marker != null) {
    marker.setSelected(true);
//    text("Settlement", mouseX, mouseY);
  }
}


