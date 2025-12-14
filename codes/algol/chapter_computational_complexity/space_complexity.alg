COMMENT
  File: space_complexity.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of space complexity examples
COMMENT

BEGIN
  MODE INTARRAY = FLEX[1:0]INT;
  
  COMMENT 函数 COMMENT
  PROC function = INT: 0;
  
  COMMENT 常数阶 COMMENT
  PROC constant = (INT n) VOID:
  BEGIN
    COMMENT 常量、变量、对象占用 O(1) 空间 COMMENT
    INT a := 0;
    INTARRAY nums := (1:10000);
    FOR i FROM 1 TO 10000 DO
      nums[i] := 0
    OD;
    COMMENT 循环中的变量占用 O(1) 空间 COMMENT
    FOR i FROM 1 TO n DO
      INT c := 0
    OD;
    COMMENT 循环中的函数占用 O(1) 空间 COMMENT
    FOR i FROM 1 TO n DO
      INT dummy := function()
    OD
  END;
  
  COMMENT 线性阶 COMMENT
  PROC linear = (INT n) VOID:
  BEGIN
    COMMENT 长度为 n 的列表占用 O(n) 空间 COMMENT
    INTARRAY nums := (1:n);
    FOR i FROM 1 TO n DO
      nums[i] := 0
    OD
  END;
  
  COMMENT 线性阶（递归实现） COMMENT
  PROC linear recur = (INT n) VOID:
  BEGIN
    print(("递归 n = ", whole(n, 0), newline));
    IF n = 1 THEN
      SKIP
    ELSE
      linear recur(n - 1)
    FI
  END;
  
  COMMENT 平方阶 COMMENT
  PROC quadratic = (INT n) VOID:
  BEGIN
    COMMENT 二维列表占用 O(n^2) 空间 COMMENT
    MODE INTMATRIX = FLEX[1:0, 1:0]INT;
    INTMATRIX num matrix := (1:n, 1:n);
    FOR i FROM 1 TO n DO
      FOR j FROM 1 TO n DO
        num matrix[i, j] := 0
      OD
    OD
  END;
  
  COMMENT 平方阶（递归实现） COMMENT
  PROC quadratic recur = (INT n) INT:
    IF n <= 0 THEN
      0
    ELSE
      BEGIN
        COMMENT 数组 nums 长度为 n, n-1, ..., 2, 1 COMMENT
        INTARRAY nums := (1:n);
        FOR i FROM 1 TO n DO
          nums[i] := 0
        OD;
        quadratic recur(n - 1)
      END
    FI;
  
  COMMENT Driver Code COMMENT
  INT n := 5;
  COMMENT 常数阶 COMMENT
  constant(n);
  COMMENT 线性阶 COMMENT
  linear(n);
  linear recur(n);
  COMMENT 平方阶 COMMENT
  quadratic(n);
  INT dummy := quadratic recur(n);
  print(("空间复杂度示例完成", newline))
END

