COMMENT
  File: knapsack.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of knapsack problem
COMMENT

BEGIN
  MODE INTARRAY = FLEX[1:0]INT;
  
  COMMENT 0-1 背包：动态规划 COMMENT
  PROC knapsack dp = (INTARRAY wgt, INTARRAY val, INT cap) INT:
  BEGIN
    INT n := UPB wgt;
    COMMENT 初始化 dp 表 COMMENT
    MODE INTMATRIX = FLEX[1:0, 0:0]INT;
    INTMATRIX dp := (1:n + 1, 0:cap);
    FOR i FROM 1 TO n + 1 DO
      FOR c FROM 0 TO cap DO
        dp[i, c] := 0
      OD
    OD;
    COMMENT 状态转移 COMMENT
    FOR i FROM 2 TO n + 1 DO
      FOR c FROM 1 TO cap DO
        IF wgt[i - 1] > c THEN
          COMMENT 若超过背包容量，则不选物品 i COMMENT
          dp[i, c] := dp[i - 1, c]
        ELSE
          BEGIN
            COMMENT 不选和选物品 i 这两种方案的较大值 COMMENT
            INT not choose := dp[i - 1, c];
            INT choose := dp[i - 1, c - wgt[i - 1]] + val[i - 1];
            dp[i, c] := (IF not choose > choose THEN not choose ELSE choose FI)
          END
        FI
      OD
    OD;
    dp[n + 1, cap]
  END;
  
  COMMENT 0-1 背包：空间优化后的动态规划 COMMENT
  PROC knapsack dp comp = (INTARRAY wgt, INTARRAY val, INT cap) INT:
  BEGIN
    INT n := UPB wgt;
    COMMENT 初始化 dp 表 COMMENT
    INTARRAY dp := (0:cap);
    FOR c FROM 0 TO cap DO
      dp[c] := 0
    OD;
    COMMENT 状态转移 COMMENT
    FOR i FROM 1 TO n DO
      COMMENT 倒序遍历 COMMENT
      FOR c FROM cap BY -1 TO 1 DO
        IF wgt[i] > c THEN
          COMMENT 若超过背包容量，则不选物品 i COMMENT
          SKIP
        ELSE
          BEGIN
            COMMENT 不选和选物品 i 这两种方案的较大值 COMMENT
            INT not choose := dp[c];
            INT choose := dp[c - wgt[i]] + val[i];
            dp[c] := (IF not choose > choose THEN not choose ELSE choose FI)
          END
        FI
      OD
    OD;
    dp[cap]
  END;
  
  COMMENT Driver Code COMMENT
  INTARRAY wgt := (10, 20, 30, 40, 50);
  INTARRAY val := (50, 120, 150, 210, 240);
  INT cap := 50;
  
  COMMENT 动态规划 COMMENT
  INT res := knapsack dp(wgt, val, cap);
  print(("不超过背包容量的最大物品价值为 ", whole(res, 0), newline));
  
  COMMENT 空间优化后的动态规划 COMMENT
  res := knapsack dp comp(wgt, val, cap);
  print(("不超过背包容量的最大物品价值为 ", whole(res, 0), newline))
END

