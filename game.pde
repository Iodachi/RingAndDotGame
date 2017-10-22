int [][] board; //the chessboard
int eachSize = 50; //the size of each "spot"
Dot [][] dots; //a list of dots
Ring [][] rings; //a list of rings
int currentRow, currentCol; //the empty space to work with
int steps, count, bestSteps;
int l1, l2; 
ArrayList colors = new ArrayList<Color>(); 
//dots are randomly generated according to colorList, 
//then added in colors which will be chosen randomly 
//to generate rings with corresponding number of colors
ArrayList colorList; //a list of colors being used to be dots and rings
ArrayList scheme1, scheme2, scheme3, scheme4, scheme5, scheme6, scheme7, scheme8, scheme9, scheme10, scheme11, scheme12, scheme13, scheme14, scheme15; //a color scheme with 4 colors
ArrayList colorSchemeList = new ArrayList<ArrayList>(); //list of color schemes to choose from

void setup() {
  size(500, 500);
  noStroke();
  l1 = (int)random(2, 8); //number of points in a row
  l2 = (int)random(3, 8); //number of points in a column
  board = new int[l1][l2]; //chessboard based on the number of points in rows and columns
  dots = new Dot[l1][l2]; 
  rings = new Ring[l1][l2];
  addScheme();
  chooseColorScheme();
  addDotsAndRings();
}

void draw() {
  background(0);
  fill(230);
  rectMode(CENTER);
  rect(250, 270, 50*l1, 50*l2, 10); //the chessboard
  drawDotsAndRings();
  posCheck();
  fill(255);
  textSize(15);
  text("Steps: " + steps, 20, 30);
  text("Dots and rings in position: " + posCheck(), 20, 45);
  text("Least steps taken in current level: " + bestSteps, 20, 60);
  finish();
}

void restart() {
  l1 = (int)random(3, 8);
  l2 = (int)random(2, 8); 
  board = new int[l1][l2]; 
  dots = new Dot[l1][l2]; //reset dots
  rings = new Ring[l1][l2]; //reset rings
  chooseColorScheme();
  addDotsAndRings();
  steps = 0;
  bestSteps = 0;
}

void restartSameLevel() {
  addDotsAndRings();
  steps = 0;
}

void addScheme() {
  //initialize color schemes
  scheme1 = new ArrayList<Color>();
  scheme2 = new ArrayList<Color>();
  scheme3 = new ArrayList<Color>();
  scheme4 = new ArrayList<Color>();
  scheme5 = new ArrayList<Color>();
  scheme6 = new ArrayList<Color>();
  scheme7 = new ArrayList<Color>();
  scheme8 = new ArrayList<Color>();
  scheme9 = new ArrayList<Color>();
  scheme10 = new ArrayList<Color>();
  scheme11 = new ArrayList<Color>();
  scheme12 = new ArrayList<Color>();
  scheme13 = new ArrayList<Color>();
  scheme14 = new ArrayList<Color>();
  scheme15 = new ArrayList<Color>();

  //store a color scheme in a list
  scheme1.add(new Color(color(#C1E1DC))); //blue
  scheme1.add(new Color(color(#FFCCAC))); //peach
  scheme1.add(new Color(color(#FFEB94))); //butter
  scheme1.add(new Color(color(#FDD475))); //orange

  scheme2.add(new Color(color(#344D90))); 
  scheme2.add(new Color(color(#5CC5EF))); 
  scheme2.add(new Color(color(#FFB745))); 
  scheme2.add(new Color(color(#E7552C))); 

  scheme3.add(new Color(color(#8593AE))); 
  scheme3.add(new Color(color(#5A4E4D))); 
  scheme3.add(new Color(color(#7E675E))); 
  scheme3.add(new Color(color(#DDA288)));

  scheme4.add(new Color(color(#AFB5B5)));
  scheme4.add(new Color(color(#232122)));
  scheme4.add(new Color(color(#A5C05B)));
  scheme4.add(new Color(color(#7BA4A8)));

  scheme5.add(new Color(color(#2C4A52)));
  scheme5.add(new Color(color(#537072)));
  scheme5.add(new Color(color(#8E9B97)));
  scheme5.add(new Color(color(#F4EBDB)));

  scheme6.add(new Color(color(#FFBEBD)));
  scheme6.add(new Color(color(#FCFCFA)));
  scheme6.add(new Color(color(#337BAE)));
  scheme6.add(new Color(color(#1A405F)));

  scheme7.add(new Color(color(#42313A)));
  scheme7.add(new Color(color(#6C2D2C)));
  scheme7.add(new Color(color(#9F4636)));
  scheme7.add(new Color(color(#F1DCC9)));

  scheme8.add(new Color(color(#688B8A)));
  scheme8.add(new Color(color(#A0B084)));
  scheme8.add(new Color(color(#FAEFD4)));
  scheme8.add(new Color(color(#A57C65)));

  scheme9.add(new Color(color(#444C5C)));
  scheme9.add(new Color(color(#CE5A57)));
  scheme9.add(new Color(color(#78A5A3)));
  scheme9.add(new Color(color(#E1B16A)));

  scheme10.add(new Color(color(#FFCCBB)));
  scheme10.add(new Color(color(#6EB5C0)));
  scheme10.add(new Color(color(#006C84)));
  scheme10.add(new Color(color(#C6C6C6)));

  scheme11.add(new Color(color(#EBDF00)));
  scheme11.add(new Color(color(#7E7B15)));
  scheme11.add(new Color(color(#563E20)));
  scheme11.add(new Color(color(#B38540)));

  scheme12.add(new Color(color(#011A27)));
  scheme12.add(new Color(color(#063852)));
  scheme12.add(new Color(color(#F0810F)));
  scheme12.add(new Color(color(#E6DF44)));

  scheme13.add(new Color(color(#003B46)));
  scheme13.add(new Color(color(#07575B)));
  scheme13.add(new Color(color(#66A5AD)));
  scheme13.add(new Color(color(#C4DFE6)));

  scheme14.add(new Color(color(#375E97)));
  scheme14.add(new Color(color(#FB6542)));
  scheme14.add(new Color(color(#FFBB00)));
  scheme14.add(new Color(color(#3F681C)));

  scheme15.add(new Color(color(#363237)));
  scheme15.add(new Color(color(#2D4262)));
  scheme15.add(new Color(color(#73605B)));
  scheme15.add(new Color(color(#D09683)));

  //add all the lists to a list
  colorSchemeList.add(scheme1);
  colorSchemeList.add(scheme2);
  colorSchemeList.add(scheme3);
  colorSchemeList.add(scheme4);
  colorSchemeList.add(scheme5);
  colorSchemeList.add(scheme6);
  colorSchemeList.add(scheme7);
  colorSchemeList.add(scheme8);
  colorSchemeList.add(scheme9);
  colorSchemeList.add(scheme10);
  colorSchemeList.add(scheme11);
  colorSchemeList.add(scheme12);
  colorSchemeList.add(scheme13);
  colorSchemeList.add(scheme14);
  colorSchemeList.add(scheme15);
} 

void chooseColorScheme() {
  //choose randomly from the list to set the current color scheme
  colorList = (ArrayList)colorSchemeList.get((int)random(0, colorSchemeList.size()));
}

void addDotsAndRings() {
  for (int i=0; i<board.length; i++) {
    for (int j=0; j<board[i].length; j++) {
      dots[i][j] = new Dot((Color)colorList.get((int)random(0, colorList.size())));
      //add the color of the new dot to a list of colors in order for the following color matching
      colors.add(dots[i][j].getColor());
    }
  }
  int row = (int)random(0, board.length);
  int col = (int)random(0, board[0].length);
  Color c  = dots[row][col].getColor(); //store the color of the dot being removed 
  //in order to remove a ring in same color
  dots[row][col] = null; //remove one dot to make an empty space


  for (int i=0; i<board.length; i++) {
    for (int j=0; j<board[i].length; j++) {
      rings[i][j] = new Ring((Color)colors.remove((int)random(0, colors.size()))); 
      //after creating a ring, remove the color from list colors
    }
  }// to ensure no bug occurs, add rings after adding all the dots

  for (int i=0; i<board.length; i++) {
    for (int j=0; j<board[i].length; j++) {
      if (rings[i][j].getColor() == c) {
        rings[i][j] = null; //set the ring with the same color of the removed dot to be empty
        currentRow =i;
        currentCol = j;  //set current to be the empty ring slot
        return; //select only one empty ring
      }
    }
  }
}

void drawDotsAndRings() {
  for (int i=0; i<board.length; i++) {
    for (int j=0; j<board[i].length; j++) {
      float x = eachSize/2 + i*eachSize + 250 - 50*l1/2;
      float y = eachSize/2 + j*eachSize + 270 - 50*l2/2; //convert rows and colunms to be the x and y coordinates on board
      if (rings[i][j] != null) {
        rings[i][j].drawRing(x, y);
      }//draw rings first to make dots appear on top of them
      if (dots[i][j] != null) {
        dots[i][j].drawDot(x, y);
      }
    }
  }
}

int posCheck() { //check how many dots and rings are matched
  count = 0;
  for (int i=0; i<rings.length; i++) {
    for (int j=0; j<rings[i].length; j++) {
      if (rings[i][j] != null && dots[i][j] != null) {
        if (rings[i][j].getColor().equals(dots[i][j].getColor())) {
          count++;
        }
      }
    }
  }
  return count;
}

void finish() {
  if (posCheck() == rings.length * rings[0].length -1) { //if all the dots and rings are in position
    fill(#A0A0A0);
    textSize(30);
    text("LEVEL FINISHED", 140, 270);
    textSize(10);
    text("- PRESS SPACE TO RESTART -", 185, 300);
    text("- PRESS ENTER TO START A DIFFERENT LEVEL -", 150, 310);
    //text("You won!", CENTER, CENTER); //center doesn't work?
    if (steps < bestSteps || bestSteps == 0) {
      bestSteps = steps;
    }
  }
}

void keyPressed() {
  if (keyCode == LEFT) {
    if (currentRow+1<board.length) { //if have right of current
      rings[currentRow][currentCol] = rings[currentRow+1][currentCol];
      rings[currentRow+1][currentCol] = null;
      currentRow ++; //update current
      steps++;
    }//move right to current
  } else if (keyCode == RIGHT) {
    if (currentRow-1>=0) {
      rings[currentRow][currentCol] = rings[currentRow-1][currentCol];
      rings[currentRow-1][currentCol] = null;
      currentRow--;
      steps++;
    }//move left to current
  } else if (keyCode == DOWN) {
    if (currentCol-1 >=0) {
      rings[currentRow][currentCol] = rings[currentRow][currentCol-1];
      rings[currentRow][currentCol-1] = null;
      currentCol--;
      steps++;
    }//move up to current
  } else if (keyCode == UP) {
    if (currentCol+1<board[0].length) {
      rings[currentRow][currentCol] = rings[currentRow][currentCol+1];
      rings[currentRow][currentCol+1] = null; 
      currentCol++;
      steps++;
    }//move down to current
  }

  //if (posCheck() == rings.length * rings[0].length -1) {
    //when a level is finished, press ENTER to restart
    if (keyCode == ENTER) {
      restart();
    } else if (key == ' ') {
      //press SPACE to restart the same level with the same size of chessboard and same color of dots and rings
      restartSameLevel();
    //}
  }
}