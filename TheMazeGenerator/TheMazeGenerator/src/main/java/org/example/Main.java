package org.example;

import java.util.ArrayList;

public class Main {
    public static void main(String[] args) {
        System.out.println("Hello World!");
        runMazeGenerator();
    }
    // Run the MazeGenerator class
    public static <Wall> void runMazeGenerator() {
        MazeGenerator maze = new MazeGenerator(20, 20);
        System.out.println("Walls:");
        ArrayList<Wall> walls = (ArrayList<Wall>) maze.getWalls();
        for (int i = 0; i < walls.size(); i++) {
            System.out.println(walls.get(i));
        }
        System.out.println("Path:");
        ArrayList<MazeGenerator.Position> path = maze.getPath();
        for (int i = 0; i < path.size(); i++) {
            System.out.println(path.get(i));
        }
    }
}
