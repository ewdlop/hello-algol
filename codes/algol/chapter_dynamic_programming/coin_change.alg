COMMENT
  File: coin_change.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of coin change using dynamic programming
COMMENT

BEGIN
  MODE INTARRAY = FLEX[1:0]INT;
  
  COMMENT 零钱兑换：动态规划 COMMENT
  PROC coin change dp = (INTARRAY coins, INT amt) INT:
  BEGIN
    INT n := UPB coins;
    INT MAX := amt + 1;
    COMMENT 初始化 dp 表 COMMENT
    MODE INTMATRIX = FLEX[1:0, 1:0]INT;
    INTMATRIX dp := (1:n + 1, 0:amt);
    COMMENT 状态转移：首行首列 COMMENT
    FOR a FROM 1 TO amt DO
      dp[1, a] := MAX
    OD;
    COMMENT 状态转移：其余行和列 COMMENT
    FOR i FROM 2 TO n + 1 DO
      BEGIN
        dp[i, 0] := 0;
        FOR a FROM 1 TO amt DO
          IF coins[i - 1] > a THEN
            COMMENT 若超过目标金额，则不选硬币 i COMMENT
            dp[i, a] := dp[i - 1, a]
          ELSE
            BEGIN
              COMMENT 不选和选硬币 i 这两种方案的较小值 COMMENT
              INT not choose := dp[i - 1, a];
              INT choose := dp[i, a - coins[i - 1]] + 1;
              dp[i, a] := (IF not choose < choose THEN not choose ELSE choose FI)
            END
          FI
        OD
      END
    OD;
    IF dp[n + 1, amt] /= MAX THEN
      dp[n + 1, amt]
    ELSE
      -1
    FI
  END;
  
  COMMENT 零钱兑换：空间优化后的动态规划 COMMENT
  PROC coin change dp comp = (INTARRAY coins, INT amt) INT:
  BEGIN
    INT n := UPB coins;
    INT MAX := amt + 1;
    COMMENT 初始化 dp 表 COMMENT
    INTARRAY dp := (0:amt);
    dp[0] := 0;
    FOR a FROM 1 TO amt DO
      dp[a] := MAX
    OD;
    COMMENT 状态转移 COMMENT
    FOR i FROM 1 TO n DO
      FOR a FROM 1 TO amt DO
        IF coins[i] > a THEN
          COMMENT 若超过目标金额，则不选硬币 i COMMENT
          SKIP
        ELSE
          BEGIN
            COMMENT 不选和选硬币 i 这两种方案的较小值 COMMENT
            INT not choose := dp[a];
            INT choose := dp[a - coins[i]] + 1;
            dp[a] := (IF not choose < choose THEN not choose ELSE choose FI)
          END
        FI
      OD
    OD;
    IF dp[amt] /= MAX THEN
      dp[amt]
    ELSE
      -1
    FI
  END;
  
  COMMENT Driver Code COMMENT
  INTARRAY coins := (1, 2, 5);
  INT amt := 4;
  
  COMMENT 动态规划 COMMENT
  INT res := coin change dp(coins, amt);
  print(("凑到目标金额所需的最少硬币数量为 ", whole(res, 0), newline));
  
  COMMENT 空间优化后的动态规划 COMMENT
  res := coin change dp comp(coins, amt);
  print(("凑到目标金额所需的最少硬币数量为 ", whole(res, 0), newline))
END

