package org.example;

import java.util.ArrayList;
import java.util.Random;

public class MazeGenerator {
    private int width;
    private int height;
    private ArrayList<Position> walls;
    private Random random;
    private boolean[][] visited;
    private Position[][] grid;
    private ArrayList<Position> path;

    public MazeGenerator(int width, int height) {
        this.width = width;
        this.height = height;
        walls = new ArrayList<Position>();
        random = new Random();
        visited = new boolean[height][width];
        grid = new Position[height][width];
        path = new ArrayList<Position>();
        for (int i = 0; i < height; i++) {
            for (int j = 0; j < width; j++) {
                grid[i][j] = new Position(j, i);
            }
        }
        generateMaze();
    }

    public ArrayList<Position> getWalls() {
        return walls;
    }

    private void generateMaze() {
        System.out.println("Generating maze...");
        // choose a random cell and mark it as visited
        int x = random.nextInt(width);
        int y = random.nextInt(height);
        visited[y][x] = true;
        // while there are unvisited cells
        while (!allVisited()) {
            // choose a random unvisited cell
            Position cell = getRandomUnvisited();
            // mark the cell as visited
            visited[cell.getY()][cell.getX()] = true;
            // add the cell to the path
            path.add(cell);
            // while the cell is not the first cell in the path
            while (!path.get(0).equals(cell)) {
                // choose a random neighbor of the cell
                Position neighbor = getRandomNeighbor(cell);
                // if the neighbor is in the path
                if (path.contains(neighbor)) {
                    // remove all cells after the neighbor in the path
                    while (!path.get(path.size() - 1).equals(neighbor)) {
                        path.remove(path.size() - 1);
                    }
                } else {
                    // add the neighbor to the path
                    path.add(neighbor);
                }
                // set the cell to the neighbor
                cell = neighbor;
            }
            // for each cell in the path except the first
            for (int i = 1; i < path.size(); i++) {
                // remove the wall between the cell and the previous cell in the path
                removeWall(path.get(i), path.get(i - 1));
            }
            // clear the path
            path.clear();
        }
        System.out.println("Maze generated.");
    }

    private void removeWall(Position cell, Position neighbor) {
        // if the cell is above the neighbor
        if (cell.getY() < neighbor.getY()) {
            // remove the bottom wall of the cell
            walls.remove(cell);
        }
        // if the cell is below the neighbor
        if (cell.getY() > neighbor.getY()) {
            // remove the bottom wall of the neighbor
            walls.remove(neighbor);
        }
        // if the cell is to the left of the neighbor
        if (cell.getX() < neighbor.getX()) {
            // remove the right wall of the cell
            walls.remove(cell);
        }
        // if the cell is to the right of the neighbor
        if (cell.getX() > neighbor.getX()) {
            // remove the right wall of the neighbor
            walls.remove(neighbor);
        }
    }

    private Position getRandomUnvisited() {
        // choose a random cell
        int x = random.nextInt(width);
        int y = random.nextInt(height);
        // while the cell is visited
        while (visited[y][x]) {
            // choose a random cell
            x = random.nextInt(width);
            y = random.nextInt(height);
        }
        // return the cell
        return grid[y][x];
    }

    private Position getRandomNeighbor(Position cell) {
        // get the neighbors of the cell
        ArrayList<Position> neighbors = getNeighbors(cell);
        // choose a random neighbor
        int index = random.nextInt(neighbors.size());
        // return the neighbor
        return neighbors.get(index);
    }

    private ArrayList<Position> getNeighbors(Position cell) {
        // create a list of neighbors
        ArrayList<Position> neighbors = new ArrayList<Position>();
        // if the cell is not on the top edge
        if (cell.getY() > 0) {
            // add the cell above to the list of neighbors
            neighbors.add(grid[cell.getY() - 1][cell.getX()]);
        }
        // if the cell is not on the bottom edge
        if (cell.getY() < height - 1) {
            // add the cell below to the list of neighbors
            neighbors.add(grid[cell.getY() + 1][cell.getX()]);
        }
        // if the cell is not on the left edge
        if (cell.getX() > 0) {
            // add the cell to the left to the list of neighbors
            neighbors.add(grid[cell.getY()][cell.getX() - 1]);
        }
        // if the cell is not on the right edge
        if (cell.getX() < width - 1) {
            // add the cell to the right to the list of neighbors
            neighbors.add(grid[cell.getY()][cell.getX() + 1]);
        }
        // return the list of neighbors
        return neighbors;
    }

    private boolean allVisited() {
        // for each cell
        for (int i = 0; i < height; i++) {
            for (int j = 0; j < width; j++) {
                // if the cell is not visited
                if (!visited[i][j]) {
                    // return false
                    return false;
                }
            }
        }
        // return true
        return true;
    }

    public ArrayList<Position> getPath() {
        return path;
    }

    class Position {
        private int x;
        private int y;

        public Position(int x, int y) {
            this.x = x;
            this.y = y;
        }

        public int getX() {
            return x;
        }

        public int getY() {
            return y;
        }

        public boolean equals(Object o) {
            if (o instanceof Position) {
                Position p = (Position) o;
                return p.getX() == x && p.getY() == y;
            }
            return false;
        }
    }
}

// run the program
