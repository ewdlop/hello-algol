COMMENT
  File: climbing_stairs_dp.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of climbing stairs using dynamic programming
COMMENT

BEGIN
  MODE INTARRAY = FLEX[1:0]INT;
  
  COMMENT 爬楼梯：动态规划 COMMENT
  PROC climbing stairs dp = (INT n) INT:
    IF n = 1 OR n = 2 THEN
      n
    ELSE
      BEGIN
        COMMENT 初始化 dp 表，用于存储子问题的解 COMMENT
        INTARRAY dp := (1:n + 1);
        COMMENT 初始状态：预设最小子问题的解 COMMENT
        dp[1] := 1;
        dp[2] := 2;
        COMMENT 状态转移：从较小子问题逐步求解较大子问题 COMMENT
        FOR i FROM 3 TO n DO
          dp[i] := dp[i - 1] + dp[i - 2]
        OD;
        dp[n]
      END
    FI;
  
  COMMENT 爬楼梯：空间优化后的动态规划 COMMENT
  PROC climbing stairs dp comp = (INT n) INT:
    IF n = 1 OR n = 2 THEN
      n
    ELSE
      BEGIN
        INT a := 1;
        INT b := 2;
        FOR i FROM 3 TO n DO
          BEGIN
            INT tmp := a;
            a := b;
            b := tmp + b
          END
        OD;
        b
      END
    FI;
  
  COMMENT Driver Code COMMENT
  INT n := 9;
  INT res := climbing stairs dp(n);
  print(("爬 ", whole(n, 0), " 阶楼梯共有 ", whole(res, 0), " 种方案", newline));
  
  res := climbing stairs dp comp(n);
  print(("爬 ", whole(n, 0), " 阶楼梯共有 ", whole(res, 0), " 种方案", newline))
END

