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


## Solvers

- `auto` - mode chosen by program
- `bruteforce`
- `penandpaper` - TODO