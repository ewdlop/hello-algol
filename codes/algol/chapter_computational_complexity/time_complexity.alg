COMMENT
  File: time_complexity.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of time complexity examples
COMMENT

BEGIN
  MODE INTARRAY = FLEX[1:0]INT;
  
  COMMENT 常数阶 COMMENT
  PROC constant = (INT n) INT:
  BEGIN
    INT count := 0;
    INT size := 100000;
    FOR i FROM 1 TO size DO
      count +:= 1
    OD;
    count
  END;
  
  COMMENT 线性阶 COMMENT
  PROC linear = (INT n) INT:
  BEGIN
    INT count := 0;
    FOR i FROM 1 TO n DO
      count +:= 1
    OD;
    count
  END;
  
  COMMENT 线性阶（遍历数组） COMMENT
  PROC array traversal = (INTARRAY nums) INT:
  BEGIN
    INT count := 0;
    COMMENT 循环次数与数组长度成正比 COMMENT
    FOR i FROM LWB nums TO UPB nums DO
      count +:= 1
    OD;
    count
  END;
  
  COMMENT 平方阶 COMMENT
  PROC quadratic = (INT n) INT:
  BEGIN
    INT count := 0;
    COMMENT 循环次数与数据大小 n 成平方关系 COMMENT
    FOR i FROM 1 TO n DO
      FOR j FROM 1 TO n DO
        count +:= 1
      OD
    OD;
    count
  END;
  
  COMMENT 平方阶（冒泡排序） COMMENT
  PROC bubble sort = (REF INTARRAY nums) INT:
  BEGIN
    INT count := 0; COMMENT 计数器 COMMENT
    INT n := UPB nums;
    COMMENT 外循环：未排序区间为 [1, i] COMMENT
    FOR i FROM n BY -1 TO 2 DO
      COMMENT 内循环：将未排序区间 [1, i] 中的最大元素交换至该区间的最右端 COMMENT
      FOR j FROM 1 TO i - 1 DO
        IF nums[j] > nums[j + 1] THEN
          COMMENT 交换 nums[j] 与 nums[j + 1] COMMENT
          INT tmp := nums[j];
          nums[j] := nums[j + 1];
          nums[j + 1] := tmp;
          count +:= 3 COMMENT 元素交换包含 3 个单元操作 COMMENT
        FI
      OD
    OD;
    count
  END;
  
  COMMENT 指数阶（循环实现） COMMENT
  PROC exponential = (INT n) INT:
  BEGIN
    INT count := 0;
    INT base := 1;
    COMMENT 细胞每轮一分为二，形成数列 1, 2, 4, 8, ..., 2^(n-1) COMMENT
    FOR i FROM 1 TO n DO
      FOR j FROM 1 TO base DO
        count +:= 1
      OD;
      base *:= 2
    OD;
    COMMENT count = 1 + 2 + 4 + 8 + .. + 2^(n-1) = 2^n - 1 COMMENT
    count
  END;
  
  COMMENT 指数阶（递归实现） COMMENT
  PROC exp recur = (INT n) INT:
    IF n = 1 THEN
      1
    ELSE
      exp recur(n - 1) + exp recur(n - 1) + 1
    FI;
  
  COMMENT 对数阶（循环实现） COMMENT
  PROC logarithmic = (INT n) INT:
  BEGIN
    INT count := 0;
    INT m := n;
    WHILE m > 1 DO
      m := m OVER 2;
      count +:= 1
    OD;
    count
  END;
  
  COMMENT 对数阶（递归实现） COMMENT
  PROC log recur = (INT n) INT:
    IF n <= 1 THEN
      0
    ELSE
      log recur(n OVER 2) + 1
    FI;
  
  COMMENT 线性对数阶 COMMENT
  PROC linear log recur = (INT n) INT:
    IF n <= 1 THEN
      1
    ELSE
      BEGIN
        INT count := linear log recur(n OVER 2) + linear log recur(n OVER 2);
        COMMENT 当前子问题包含 n 个操作 COMMENT
        FOR i FROM 1 TO n DO
          count +:= 1
        OD;
        count
      END
    FI;
  
  COMMENT 阶乘阶（递归实现） COMMENT
  PROC factorial recur = (INT n) INT:
    IF n = 0 THEN
      1
    ELSE
      BEGIN
        INT count := 0;
        COMMENT 从 1 个分裂出 n 个 COMMENT
        FOR i FROM 1 TO n DO
          count +:= factorial recur(n - 1)
        OD;
        count
      END
    FI;
  
  COMMENT Driver Code COMMENT
  INT n := 8;
  print(("输入数据大小 n = ", whole(n, 0), newline));
  
  INT count := constant(n);
  print(("常数阶的操作数量 = ", whole(count, 0), newline));
  
  count := linear(n);
  print(("线性阶的操作数量 = ", whole(count, 0), newline));
  
  INTARRAY nums := (n, n-1, n-2, n-3, n-4, n-5, n-6, n-7);
  count := array traversal(nums);
  print(("线性阶（遍历数组）的操作数量 = ", whole(count, 0), newline));
  
  count := quadratic(n);
  print(("平方阶的操作数量 = ", whole(count, 0), newline));
  
  INTARRAY nums2 := (n, n-1, n-2, n-3, n-4, n-5, n-6, n-7);
  count := bubble sort(nums2);
  print(("平方阶（冒泡排序）的操作数量 = ", whole(count, 0), newline));
  
  count := exponential(n);
  print(("指数阶（循环实现）的操作数量 = ", whole(count, 0), newline));
  
  count := exp recur(n);
  print(("指数阶（递归实现）的操作数量 = ", whole(count, 0), newline));
  
  count := logarithmic(n);
  print(("对数阶（循环实现）的操作数量 = ", whole(count, 0), newline));
  
  count := log recur(n);
  print(("对数阶（递归实现）的操作数量 = ", whole(count, 0), newline));
  
  count := linear log recur(n);
  print(("线性对数阶（递归实现）的操作数量 = ", whole(count, 0), newline));
  
  count := factorial recur(n);
  print(("阶乘阶（递归实现）的操作数量 = ", whole(count, 0), newline))
END

