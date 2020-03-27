import java.util.Map; //<>//

/*
1) Any live cell with fewer than two live neighbors dies, as if caused by underpopulation.
 2) Any live cell with more than three live neighbors dies, as if by overcrowding.
 3) Any live cell with two or three live neighbors lives on to the next generation.
 4) Any dead cell with exactly three live neighbors becomes a live cell.
 */

boolean liveCell[][];
Grid grid ;//= new Grid(50, 50);
Cell curCell;

void setup() {

  frameRate(5);
  size(750, 750);
  grid = new Grid(50, 50); //dimension

  grid.drawGrid();
  liveCell = new boolean[grid.getNumCols()][grid.getNumRows()];


  Formation f_random1 = new Formation(randomFormation(1300));

  Formation f_blinker = new Formation(new Cell[] {
    new Cell(1, 0), 
    new Cell(1, 1), 
    new Cell(1, 2)
    });

  Formation f_beacon = new Formation(new Cell[] {
    new Cell(0, 0), 
    new Cell(0, 1), 
    new Cell(1, 0), 
    new Cell(2, 3), 
    new Cell(3, 3), 
    new Cell(3, 2)
    });

  Formation f_glider = new Formation(new Cell[] {
    new Cell(0, 1), 
    new Cell(1, 2), 
    new Cell(2, 2), 
    new Cell(2, 1), 
    new Cell(2, 0)
    });

  Formation f_combo1 = new Formation(new Formation[] {
    f_glider, 
    f_glider, 
    f_glider, 
    f_glider, 
    f_glider, 
    f_glider
    });


  Formation f_and_c = new Formation(new Cell[] {
    new Cell(2, 2), 
    new Cell(2, 1), 
    new Cell(2, 0)}, 
    new Formation[] {
      f_beacon, 
      f_beacon, 
      f_glider
    });

  //f_blinker.drawFormation(new PVector(2, 2));
  //f_beacon.drawFormation(new PVector(10, 5));
  f_random1.drawFormation(new PVector(0, 0));
  //f_glider.drawFormation(new PVector(5, 10));
  //f_combo1.drawFormation(new PVector(0, 0));
  //f_and_c.drawFormation(new PVector(20,2));
}

void draw() {

  simulate();
  updateGrid();
}


void simulate() {
  for (int i = 0; i < grid.getNumCols(); i++) {
    for (int j = 0; j < grid.getNumRows(); j++) {

      curCell = new Cell(i, j);

      if (!grid.inBounds(curCell.getPosition())) continue;

      if (grid.isCellFilled(curCell.position)) {
        //Live cell

        if (curCell.getNeighborCount() < 2 || curCell.getNeighborCount() > 3) {
          //1 and 2
          //println("Cell (" + curCell.loc.x + ", " + curCell.loc.y + ") is dead and has " + curCell.getNeighborCount() + " neighbors.");
          grid.fillCell(new PVector(curCell.position.x, curCell.position.y), color(0));
          liveCell[(int)curCell.position.x][(int)curCell.position.y] = false;
        }
        //3
      } else if (curCell.getNeighborCount() == 3) {
        //4
        //println("Cell (" + curCell.loc.x + ", " + curCell.loc.y + ") is live and has " + curCell.getNeighborCount() + " neighbors.");
        grid.clearCell(new PVector(curCell.position.x, curCell.position.y));
        liveCell[(int)curCell.position.x][(int)curCell.position.y] = true;
      }
    }
  }
}

void updateGrid() {
  for (int i = 0; i < grid.getNumCols(); i++) {
    for (int j = 0; j < grid.getNumRows(); j++) {
      if (liveCell[i][j]) {
        grid.fillCell(new PVector(i, j), 0);
      } else {
        grid.clearCell(new PVector(i, j));
      }
    }
  }
}

Cell[] randomFormation(int cells) {
  Cell c[] = new Cell[cells];

  for (int i = 0; i < cells; i++) {
    c[i] = new Cell((int)random(0, grid.columns), (int)random(0, grid.rows));
  }

  return c;
}



class Cell {

  private PVector position;

  HashMap<String, PVector> neighbors = new HashMap<String, PVector>();

  Cell(int x, int y) {
    position = new PVector(x, y);

    neighbors.put("NORTH", new PVector(position.x, position.y + 1));
    neighbors.put("SOUTH", new PVector(position.x, position.y - 1));
    neighbors.put("EAST", new PVector(position.x + 1, position.y));
    neighbors.put("WEST", new PVector(position.x -1, position.y));
    neighbors.put("NORTHEAST", new PVector(position.x + 1, position.y + 1));
    neighbors.put("NORTHWEST", new PVector(position.x - 1, position.y + 1));
    neighbors.put("SOUTHEAST", new PVector(position.x + 1, position.y - 1));
    neighbors.put("SOUTHWEST", new PVector(position.x - 1, position.y - 1));
  }

  int getNeighborCount() {
    int i = 0;
    for (Map.Entry n : neighbors.entrySet()) {
      PVector position = (PVector)n.getValue();

      if (grid.inBounds(position) && grid.isCellFilled(position)) {
        i++;
      }
    }
    return i;
  }

  public PVector getPosition(){
    return position;
  }
  
  public void setLocation(int x, int y) {
    grid.clearCell(position);
    position = new PVector(x, y);
    grid.fillCell(position, color(0));
  }
}
