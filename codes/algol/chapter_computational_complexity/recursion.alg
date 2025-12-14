COMMENT
  File: recursion.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of recursion examples
COMMENT

BEGIN
  COMMENT 递归 COMMENT
  PROC recur = (INT n) INT:
    IF n = 1 THEN
      1
    ELSE
      BEGIN
        COMMENT 递：递归调用 COMMENT
        INT res := recur(n - 1);
        COMMENT 归：返回结果 COMMENT
        n + res
      END
    FI;
  
  COMMENT 使用迭代模拟递归 COMMENT
  PROC for loop recur = (INT n) INT:
  BEGIN
    COMMENT 使用一个显式的栈来模拟系统调用栈 COMMENT
    MODE INTARRAY = FLEX[1:0]INT;
    INTARRAY stack := (1:0);
    INT res := 0;
    COMMENT 递：递归调用 COMMENT
    FOR i FROM n BY -1 TO 1 DO
      COMMENT 通过"入栈操作"模拟"递" COMMENT
      INTARRAY new stack := (1:UPB stack + 1);
      FOR j FROM 1 TO UPB stack DO
        new stack[j] := stack[j]
      OD;
      new stack[UPB new stack] := i;
      stack := new stack
    OD;
    COMMENT 归：返回结果 COMMENT
    WHILE UPB stack > 0 DO
      COMMENT 通过"出栈操作"模拟"归" COMMENT
      res +:= stack[UPB stack];
      INTARRAY new stack := (1:UPB stack - 1);
      FOR j FROM 1 TO UPB stack - 1 DO
        new stack[j] := stack[j]
      OD;
      stack := new stack
    OD;
    COMMENT res = 1+2+3+...+n COMMENT
    res
  END;
  
  COMMENT 尾递归 COMMENT
  PROC tail recur = (INT n, INT res) INT:
    IF n = 0 THEN
      res
    ELSE
      COMMENT 尾递归调用 COMMENT
      tail recur(n - 1, res + n)
    FI;
  
  COMMENT 斐波那契数列：递归 COMMENT
  PROC fib = (INT n) INT:
    IF n = 1 OR n = 2 THEN
      COMMENT 终止条件 f(1) = 0, f(2) = 1 COMMENT
      n - 1
    ELSE
      BEGIN
        COMMENT 递归调用 f(n) = f(n-1) + f(n-2) COMMENT
        INT res := fib(n - 1) + fib(n - 2);
        COMMENT 返回结果 f(n) COMMENT
        res
      END
    FI;
  
  COMMENT Driver Code COMMENT
  INT n := 5;
  INT res := recur(n);
  print(("递归函数的求和结果 res = ", whole(res, 0), newline));
  
  res := for loop recur(n);
  print(("使用迭代模拟递归求和结果 res = ", whole(res, 0), newline));
  
  res := tail recur(n, 0);
  print(("尾递归函数的求和结果 res = ", whole(res, 0), newline));
  
  res := fib(n);
  print(("斐波那契数列的第 ", whole(n, 0), " 项为 ", whole(res, 0), newline))
END

