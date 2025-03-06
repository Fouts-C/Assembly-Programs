#include <stdio.h>

//While loop to print right triangle
void printTriangleWhile(int n) {
    if (n < 1) return; //no triangle

    int row = 0;
    while (row < n) {
        int spaces = row;
        while (spaces > 0) {
            printf(" ");
            spaces--;
        }
        
        if (row == 0 || row == n - 1) {
            int pluses = n - row;
            while (pluses > 0) {
                printf("+");
                pluses--;
            }
        } else {
            printf("+");
            
            int dashes = n - row - 2;
            while (dashes > 0) {
                printf("-");
                dashes--;
            }
            
            printf("+");
        }
        
        printf("\n");
        row++;
    }
}

//For loop equalateral triangle
void printTriangleFor(int n) {
    if (n < 1) return; //no triangle

    for (int row = 0; row < n; row++) {

        for (int spaces = 0; spaces < n - row - 1; spaces++) {
            printf(" ");
        }
        
        if (row == 0 || row == n - 1) {
            for (int pluses = 0; pluses < 2 * row + 1; pluses++) {
                printf("+");
            }
        } else {
            printf("+"); //first plus
            
            for (int dashes = 0; dashes < 2 * row - 1; dashes++) {
                printf("-");
            }
            
            printf("+"); 
        }
        
        printf("\n");
    }
}