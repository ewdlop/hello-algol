COMMENT
  File: iteration.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of iteration examples
COMMENT

BEGIN
  COMMENT for 循环 COMMENT
  PROC for loop = (INT n) INT:
  BEGIN
    INT res := 0;
    COMMENT 循环求和 1, 2, ..., n-1, n COMMENT
    FOR i FROM 1 TO n DO
      res +:= i
    OD;
    res
  END;
  
  COMMENT while 循环 COMMENT
  PROC while loop = (INT n) INT:
  BEGIN
    INT res := 0;
    INT i := 1; COMMENT 初始化条件变量 COMMENT
    COMMENT 循环求和 1, 2, ..., n-1, n COMMENT
    WHILE i <= n DO
      res +:= i;
      i +:= 1 COMMENT 更新条件变量 COMMENT
    OD;
    res
  END;
  
  COMMENT while 循环（两次更新） COMMENT
  PROC while loop ii = (INT n) INT:
  BEGIN
    INT res := 0;
    INT i := 1; COMMENT 初始化条件变量 COMMENT
    COMMENT 循环求和 1, 4, 10, ... COMMENT
    WHILE i <= n DO
      res +:= i;
      COMMENT 更新条件变量 COMMENT
      i +:= 1;
      i *:= 2
    OD;
    res
  END;
  
  COMMENT 双层 for 循环 COMMENT
  PROC nested for loop = (INT n) STRING:
  BEGIN
    STRING res := "";
    COMMENT 循环 i = 1, 2, ..., n-1, n COMMENT
    FOR i FROM 1 TO n DO
      COMMENT 循环 j = 1, 2, ..., n-1, n COMMENT
      FOR j FROM 1 TO n DO
        res +:= "(" + whole(i, 0) + ", " + whole(j, 0) + "), "
      OD
    OD;
    res
  END;
  
  COMMENT Driver Code COMMENT
  INT n := 5;
  INT res := for loop(n);
  print(("for 循环的求和结果 res = ", whole(res, 0), newline));
  
  res := while loop(n);
  print(("while 循环的求和结果 res = ", whole(res, 0), newline));
  
  res := while loop ii(n);
  print(("while 循环（两次更新）求和结果 res = ", whole(res, 0), newline));
  
  STRING res2 := nested for loop(n);
  print(("双层 for 循环的遍历结果 ", res2, newline))
END

