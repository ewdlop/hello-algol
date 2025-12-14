COMMENT
  File: coin_change_greedy.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of coin change using greedy algorithm
COMMENT

BEGIN
  MODE INTARRAY = FLEX[1:0]INT;
  
  COMMENT 零钱兑换：贪心 COMMENT
  PROC coin change greedy = (INTARRAY coins, INT amt) INT:
  BEGIN
    COMMENT 假设 coins 列表有序 COMMENT
    INT i := UPB coins;
    INT count := 0;
    INT remaining := amt;
    COMMENT 循环进行贪心选择，直到无剩余金额 COMMENT
    WHILE remaining > 0 DO
      BEGIN
        COMMENT 找到小于且最接近剩余金额的硬币 COMMENT
        WHILE i > 1 AND coins[i] > remaining DO
          i -:= 1
        OD;
        COMMENT 选择 coins[i] COMMENT
        remaining -:= coins[i];
        count +:= 1
      END
    OD;
    COMMENT 若未找到可行方案，则返回 -1 COMMENT
    IF remaining = 0 THEN
      count
    ELSE
      -1
    FI
  END;
  
  COMMENT 打印数组 COMMENT
  PROC print array = (INTARRAY arr) VOID:
  BEGIN
    print("[");
    FOR i FROM 1 TO UPB arr DO
      print(whole(arr[i], 0));
      IF i < UPB arr THEN print(", ") FI
    OD;
    print("]")
  END;
  
  COMMENT Driver Code COMMENT
  COMMENT 贪心：能够保证找到全局最优解 COMMENT
  INTARRAY coins1 := (1, 5, 10, 20, 50, 100);
  INT amt1 := 186;
  INT res1 := coin change greedy(coins1, amt1);
  print("coins = ");
  print array(coins1);
  print((", amt = ", whole(amt1, 0), newline));
  print(("凑到 ", whole(amt1, 0), " 所需的最少硬币数量为 ", whole(res1, 0), newline));
  
  COMMENT 贪心：无法保证找到全局最优解 COMMENT
  INTARRAY coins2 := (1, 20, 50);
  INT amt2 := 60;
  INT res2 := coin change greedy(coins2, amt2);
  print("coins = ");
  print array(coins2);
  print((", amt = ", whole(amt2, 0), newline));
  print(("凑到 ", whole(amt2, 0), " 所需的最少硬币数量为 ", whole(res2, 0), newline));
  print("实际上需要的最少数量为 3 ，即 20 + 20 + 20");
  print(newline)
END

