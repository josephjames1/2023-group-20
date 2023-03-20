import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

public class TestMazeGenerator {

    private final int width;
    private final int height;
    private int endX;
    private int endY;
    private final boolean[][] maze;

    public TestMazeGenerator(int width, int height) {
        this.width = width;
        this.height = height;
        this.maze = new boolean[height][width];
    }

    public void generateMaze(int startX, int startY) {
        maze[startY][startX] = true;
        Random rand = new Random();
        DFS(startX, startY, rand);
    }

    private void DFS(int x, int y, Random rand) {
        List<int[]> directions = new ArrayList<>();
        directions.add(new int[]{1, 0});
        directions.add(new int[]{-1, 0});
        directions.add(new int[]{0, 1});
        directions.add(new int[]{0, -1});
    
        Collections.shuffle(directions, rand);
    
        for (int[] dir : directions) {
            int newX = x + 2 * dir[0];
            int newY = y + 2 * dir[1];
    
            if (isValidCoordinate(newX, newY) && !maze[newY][newX]) {
                maze[y + dir[1]][x + dir[0]] = true;
                maze[newY][newX] = true;
                DFS(newX, newY, rand);
            }
        }
        endX = width - 1;
        endY = height - 2;
        maze[endY][endX-1] = true;
    }

    private boolean isValidCoordinate(int x, int y) {
        return x > 0 && x < width - 1 && y > 0 && y < height - 1;
    }

    public void printMaze() {
        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                if (x == 1 && y == 1) {
                    System.out.print("S");
                } else if (x == endX && y == endY) {
                    System.out.print("E");
                } else {
                    System.out.print(maze[y][x] ? " " : "#");
                }
            }
            System.out.println();
        }
    }
    public String[] getMaze() {
        String[] mazeString = new String[height];
        for (int y = 0; y < height; y++) {
            String row = "";
            for (int x = 0; x < width; x++) {
                if (x == 1 && y == 1) {
                    row += "S";
                } else if (x == endX && y == endY) {
                    row += "E";
                } else {
                    row += maze[y][x] ? " " : "#";
                }
            }
            mazeString[y] = row;
        }
        return mazeString;
    }

    public static void main(String[] args) {
        int width = 21;
        int height = 21;
        TestMazeGenerator mazeGenerator = new TestMazeGenerator(width, height);
        mazeGenerator.generateMaze(0, 1);
        String[] maze = mazeGenerator.getMaze();
        for (String row : maze) {
            System.out.println(row);
        }
    }
}
