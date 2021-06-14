using System;
using System.Collections.Generic;
using System.Linq;

namespace AdvancedTicTacToe
{
    public class Program
    {        
        static void Main(string[] args)
        {            
            TicTacToe ticTacToeGame = new TicTacToe(Convert.ToInt32(args[0]));
            //TicTacToe ticTacToeGame = new TicTacToe(5);

            ticTacToeGame.GetSpaceCoordinates();

            int winner = ticTacToeGame.PlacePiece(ticTacToeGame.GetRow(ticTacToeGame.currentGridNumber), ticTacToeGame.GetColumn(ticTacToeGame.currentGridNumber), ticTacToeGame.player);

            ticTacToeGame.PrintBoard();

            Console.WriteLine($"{ticTacToeGame.pieces[ticTacToeGame.player]}'s are the winner! Congratulations Player #{ticTacToeGame.player}!");
            Console.WriteLine($"This game took {ticTacToeGame.turns} turns!");    
        }        
    }

    public class TicTacToe
    {   
        public char[] pieces = new char[]{' ', 'O', 'X'};
        public int player { get; set; }
        public int turns { get; set; }
        public List<int> availableSpaces { get; set; }
        public char[,] gameBoard { get; set; }
        public int width { get; set; }
        public int totalBoardSpaces { get; set; }
        public int currentGridNumber { get; set; }

        /// <summary>
        /// Created a Tic Tac Tow game board
        /// </summary>
        /// <param name="n">nxn dimension for the game board</param>
        public TicTacToe(int n)
        {            
            player = 1;
            turns = 1;
            width = n;
            gameBoard = InitializeCharArray(n);
            totalBoardSpaces = n * n;
            availableSpaces = Enumerable.Range(0, totalBoardSpaces).ToList();
        }

        private static char[,] InitializeCharArray(int n)
        {
            char[,] newCharArray = new char[n,n];

            for (int i = 0; i < n; i++)
            {
                for (int j = 0; j < n; j++)
                {
                    newCharArray[i,j] = ' '; 
                }
            }

            return newCharArray;
        }

        /// <summary>
        /// Place a piece on the game board
        /// </summary>
        /// <param name="row">row to place a piece</param>
        /// <param name="col">column to place a piece</param>
        /// <param name="player">the player (1 or 2) the piece is for</param>
        /// <returns>0 = no winner, 1 = player 1 won, 2 = player 2 won</returns>
        public int PlacePiece(int row, int col, int player)
        {
            int winner = 0;
            this.gameBoard[row, col] = pieces[player];

            if (IsWinnerDecided())
                winner = this.player;
            else
            {
                switch (player)
                {
                    case 1:
                        this.player = 2;
                        break;
                    default:
                        this.player = 1;
                        break;
                }

                this.turns++;
                this.GetSpaceCoordinates();
                PlacePiece(this.GetRow(this.currentGridNumber), this.GetColumn(this.currentGridNumber), this.player);
            }

            return winner;
        }

        public void GetSpaceCoordinates()
        {
            Random random = new Random();
            this.currentGridNumber = random.Next(this.availableSpaces.Count);
            //if (this.availableSpaces[this.currentGridNumber] == -1)
                //this.GetSpaceCoordinates();
        }

        public int GetRow(int gridNumber)
        {
            int row = gridNumber / this.width;
            return row;
        }

        public int GetColumn(int gridNumber)
        {
            int column = gridNumber % this.width;
            return column;
        }

        public bool IsWinnerDecided()
        {
            bool didWin = true;

            //Check Rows
            for (var col = 0; col < this.width; col++)
            {
                for (var row = 0; row < this.width; row++)
                {
                    if (this.gameBoard[row, col] != pieces[this.player])
                    {    
                        didWin = false;
                        break;
                    }
                }
                if (!didWin)
                    break;
            }            

            //Check Columns
            if (!didWin)
            {
                didWin = true;
                for (var row = 0; row < this.width; row++)
                {
                    for (var col = 0; col < this.width; col++)
                    {
                        if (this.gameBoard[row, col] != pieces[this.player])
                        {    
                            didWin = false;
                            break;
                        }
                    } 
                    if (!didWin)
                        break;               
                }
            }

            //Check Top-Left to Bottom-Right Diagonal
            if (!didWin)
            {
                didWin = true;                
                for (int i = 0; i < this.width; i++)
                {
                    if (this.gameBoard[i, i] != pieces[this.player])
                    {
                        didWin = false;
                        break;
                    }
                }
            }
            
            //Check Bottom-Left to Top-Right Diagonal
            if (!didWin)
            {
                didWin = true;
                int rowIndex = 0;
                for (int j = this.width - 1; j >= 0; j--)
                {
                    if(this.gameBoard[rowIndex, j] != pieces[this.player])
                    {
                        didWin = false;
                        break;
                    }
                    rowIndex++;
                }
            }            
            return didWin;        
        }

        public void PrintBoard()
        {
            int howManyLinesToPrint = this.width * 2 - 1;
            int xIndex = 0;
            int yIndex = 0;

            for (int i = 0; i < this.width; i++)
            {
                if (i > 0 && i != this.width)
                {
                    for (int k = 0; k < howManyLinesToPrint; k++)
                        Console.Write("-");
                    Console.WriteLine();
                    yIndex++;
                }

                for (int j = 0; j <= howManyLinesToPrint; j++)
                {
                    int print = j%2;

                    switch (print)
                    {
                        case 1:
                            Console.Write(this.gameBoard[xIndex, yIndex]);
                            xIndex++;
                            break;
                        case 0:
                            if (j > 0)
                                Console.Write("|");
                            break;
                    }
                }
                Console.WriteLine();
                xIndex = 0;
            }
        }
    }
}