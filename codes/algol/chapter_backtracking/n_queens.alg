COMMENT
  File: n_queens.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of n-queens problem
COMMENT

BEGIN
  MODE INTARRAY = FLEX[1:0]INT;
  MODE BOOLARRAY = FLEX[1:0]BOOL;
  MODE CHARMATRIX = FLEX[1:0, 1:0]CHAR;
  
  COMMENT 回溯算法：n 皇后 COMMENT
  PROC backtrack = (INT row, INT n, REF CHARMATRIX state, REF INTARRAY res count, REF BOOLARRAY cols, REF BOOLARRAY diags1, REF BOOLARRAY diags2) VOID:
  BEGIN
    COMMENT 当放置完所有行时，记录解 COMMENT
    IF row = n + 1 THEN
      res count[1] +:= 1
    ELSE
      BEGIN
        COMMENT 遍历所有列 COMMENT
        FOR col FROM 1 TO n DO
          BEGIN
            COMMENT 计算该格子对应的主对角线和次对角线 COMMENT
            INT diag1 := row - col + n;
            INT diag2 := row + col - 1;
            COMMENT 剪枝：不允许该格子所在列、主对角线、次对角线上存在皇后 COMMENT
            IF NOT cols[col] AND NOT diags1[diag1] AND NOT diags2[diag2] THEN
              BEGIN
                COMMENT 尝试：将皇后放置在该格子 COMMENT
                state[row, col] := "Q";
                cols[col] := TRUE;
                diags1[diag1] := TRUE;
                diags2[diag2] := TRUE;
                COMMENT 放置下一行 COMMENT
                backtrack(row + 1, n, state, res count, cols, diags1, diags2);
                COMMENT 回退：将该格子恢复为空位 COMMENT
                state[row, col] := "#";
                cols[col] := FALSE;
                diags1[diag1] := FALSE;
                diags2[diag2] := FALSE
              END
            FI
          END
        OD
      END
    FI
  END;
  
  COMMENT 求解 n 皇后 COMMENT
  PROC n queens = (INT n) INT:
  BEGIN
    COMMENT 初始化 n*n 大小的棋盘，其中 'Q' 代表皇后，'#' 代表空位 COMMENT
    CHARMATRIX state := (1:n, 1:n);
    FOR i FROM 1 TO n DO
      FOR j FROM 1 TO n DO
        state[i, j] := "#"
      OD
    OD;
    BOOLARRAY cols := (1:n);
    FOR i FROM 1 TO n DO
      cols[i] := FALSE
    OD;
    BOOLARRAY diags1 := (1:2 * n - 1);
    FOR i FROM 1 TO 2 * n - 1 DO
      diags1[i] := FALSE
    OD;
    BOOLARRAY diags2 := (1:2 * n - 1);
    FOR i FROM 1 TO 2 * n - 1 DO
      diags2[i] := FALSE
    OD;
    INTARRAY res count := (1:1);
    res count[1] := 0;
    backtrack(1, n, state, res count, cols, diags1, diags2);
    res count[1]
  END;
  
  COMMENT Driver Code COMMENT
  INT n := 4;
  INT res := n queens(n);
  print(("输入棋盘长宽为 ", whole(n, 0), newline));
  print(("皇后放置方案共有 ", whole(res, 0), " 种", newline))
END

