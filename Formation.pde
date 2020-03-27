class Formation {

  PVector position;
  Cell cells[];
  Formation formations[];

  Formation(Cell c[]) {
    cells = c;
  } 

  Formation(Cell c[], Formation f[]) {
    cells = c;
    formations = f;
  } 

  Formation(Formation f[]) {
    formations = f;
  } 


  void drawFormation(PVector l) { //Relative to top-right corner
    if (formations != null) {
      for (int i = 0; i < formations.length; i++) {
        formations[i].drawFormation(new PVector((l.x + i) * formations[i].cells.length, l.y));
      }
    }

    if (cells != null) {
      for (int i = 0; i < cells.length; i++) {
        PVector worldLoc = relativeToWorldLocation(l, cells[i].position);

        if (!grid.inBounds(worldLoc)) continue;

        grid.fillCell(new PVector(worldLoc.x, worldLoc.y), 0);
        liveCell[(int)worldLoc.x][(int)worldLoc.y] = true;
      }
    }
  }

  PVector relativeToWorldLocation(PVector w, PVector r) {
    return new PVector(w.x + r.x, w.y + r.y);
  }
}
