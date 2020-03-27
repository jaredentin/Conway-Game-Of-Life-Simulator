import processing.core.*;


public class Grid {// extends PApplet {

  private int columns, rows;
  private int cellSize;
  private boolean[][] filled;

  Grid(int r, int c) {
    columns = c;
    rows = r;

    if (width / columns > height / rows) {
      cellSize = height / rows;
    } else {
      cellSize = width / columns;
    }

    filled = new boolean[columns][rows];
  }

  boolean isCellFilled(PVector c) {
    return filled[(int)c.x][(int)c.y];
  }

  boolean inBounds(PVector c) {
    return (int)c.x >= 0 && (int)c.x < columns && (int)c.y >= 0 && (int)c.y < rows;
  }

  private PVector gridIndexToLocation(PVector c) {
    return new PVector(cellSize * (int)c.x, cellSize * (int)c.y);
  }

  void clearGrid() {
    for (int i = 0; i < columns; i++) {
      for (int j = 0; j < rows; j++) {
        clearCell(new PVector(i, j));
        filled[i][j] = false;
      }
    }
  }

  void clearCell(PVector c) {
    if (!isCellFilled(c)) {
      //println("Cell is already empty");
      return;
    }

    if (!inBounds(c)) {
      //println("Cell is out of bounds: X = " + (int)c.x + ", Y = " + (int)c.y);
      return;
    }

    PVector indexToGrid = gridIndexToLocation(c);
    fill(g.backgroundColor);
    rect(indexToGrid.x, indexToGrid.y, cellSize, cellSize);
    filled[(int)c.x][(int)c.y] = false;
  }

  void drawGrid() {
    fill(0);
    for (int i = 0; i <= rows; i++) {
      line(0, (i * cellSize), (cellSize * columns), (i * cellSize));
    }

    for (int i = 0; i <= columns; i++) {
      line((i * cellSize), 0, (i * cellSize), (rows * cellSize));
    }
  }

  void fillCell(PVector cell, color c) {

    if (isCellFilled(cell)) {
      //println("Cell is already filled");
      return;
    }

    if (!inBounds(cell)) {
      //println("Cell is out of bounds: X = " + (int)cell.x + ", Y = " + (int)cell.y);
      return;
    }

    fill(c);
    PVector indexToGrid = gridIndexToLocation(cell);
    rect(indexToGrid.x, indexToGrid.y, cellSize, cellSize);
    filled[(int)cell.x][(int)cell.y] = true;
  }

  int getNumRows() {
    return rows;
  }

  int getNumCols() {
    return columns;
  }
}
