# Sudoku solver

Sudoku solver written in Haskell as a semester project for course Functional Programming at the Jagiellonian University.

It is based on the simplified version of [the Pencil-and-Paper algorithm](https://www.ams.org/notices/200904/rtx090400460p.pdf) for Solving Sudoku Puzzles.

## Project setup
[Install stack](https://docs.haskellstack.org/en/stable/install_and_upgrade/) then execute below commands:
```
git clone https://github.com/seqre/sudoku.git
cd sudoku
stack setup
stack build
stack exec sudoku-exe
```

## Usage

`sudoku SOLVER`

Then supply the sudoku in the following format:

`Sudoku:{numerical representation of sudoku}`

Where `numerical representation of sudoku` are concatenated rows of sudoku with numbers 1-9 for given numbers and 0 for blanks. 

### Example

```
    3  9 | 5       |         
         | 8       |    7    
         |    1    | 9     4 
---------|---------|---------
 1       | 4       |       3 
         |         |         
       7 |         | 8  6    
---------|---------|---------
       6 | 7     8 | 2       
    1    |    9    |       5 
         |       1 |       8 
```

This board will result in such representation:
`Sudoku:039500000000800070000010904100400003000000000007000860006708200010090005000001008`

## Solvers

- `auto` - mode chosen by program
- `bruteforce`
- `penandpaper` - TODO
