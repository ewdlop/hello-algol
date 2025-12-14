COMMENT
  File: hanota.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of Tower of Hanoi
COMMENT

BEGIN
  MODE INTARRAY = FLEX[1:0]INT;
  
  COMMENT 移动一个圆盘 COMMENT
  PROC move = (REF INTARRAY src, REF INTARRAY tar) VOID:
  BEGIN
    IF UPB src > 0 THEN
      BEGIN
        COMMENT 从 src 顶部拿出一个圆盘 COMMENT
        INT pan := src[UPB src];
        COMMENT 将圆盘放入 tar 顶部 COMMENT
        INTARRAY new src := (1:UPB src - 1);
        FOR i FROM 1 TO UPB src - 1 DO
          new src[i] := src[i]
        OD;
        src := new src;
        INTARRAY new tar := (1:UPB tar + 1);
        FOR i FROM 1 TO UPB tar DO
          new tar[i] := tar[i]
        OD;
        new tar[UPB new tar] := pan;
        tar := new tar
      END
    FI
  END;
  
  COMMENT 求解汉诺塔问题 f(i) COMMENT
  PROC dfs = (INT i, REF INTARRAY src, REF INTARRAY buf, REF INTARRAY tar) VOID:
  BEGIN
    COMMENT 若 src 只剩下一个圆盘，则直接将其移到 tar COMMENT
    IF i = 1 THEN
      move(src, tar)
    ELSE
      BEGIN
        COMMENT 子问题 f(i-1) ：将 src 顶部 i-1 个圆盘借助 tar 移到 buf COMMENT
        dfs(i - 1, src, tar, buf);
        COMMENT 子问题 f(1) ：将 src 剩余一个圆盘移到 tar COMMENT
        move(src, tar);
        COMMENT 子问题 f(i-1) ：将 buf 顶部 i-1 个圆盘借助 src 移到 tar COMMENT
        dfs(i - 1, buf, src, tar)
      END
    FI
  END;
  
  COMMENT 求解汉诺塔问题 COMMENT
  PROC solve hanota = (REF INTARRAY A, REF INTARRAY B, REF INTARRAY C) VOID:
  BEGIN
    INT n := UPB A;
    COMMENT 将 A 顶部 n 个圆盘借助 B 移到 C COMMENT
    dfs(n, A, B, C)
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
  COMMENT 列表尾部是柱子顶部 COMMENT
  INTARRAY A := (5, 4, 3, 2, 1);
  INTARRAY B := (1:0);
  INTARRAY C := (1:0);
  print("初始状态下：");
  print(newline);
  print("A = ");
  print array(A);
  print(newline);
  print("B = ");
  print array(B);
  print(newline);
  print("C = ");
  print array(C);
  print(newline);
  
  solve hanota(A, B, C);
  
  print("圆盘移动完成后：");
  print(newline);
  print("A = ");
  print array(A);
  print(newline);
  print("B = ");
  print array(B);
  print(newline);
  print("C = ");
  print array(C);
  print(newline)
END

