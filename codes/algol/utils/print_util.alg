COMMENT
  File: print_util.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 utility functions for printing data structures
COMMENT

BEGIN
  MODE INTARRAY = FLEX[1:0]INT;
  MODE INTMATRIX = FLEX[1:0, 1:0]INT;
  
  COMMENT 打印矩阵 COMMENT
  PROC print matrix = (INTMATRIX mat) VOID:
  BEGIN
    print("[");
    print(newline);
    FOR i FROM LWB mat TO UPB mat DO
      print("  [");
      FOR j FROM LWB mat[i] TO UPB mat[i] DO
        print(whole(mat[i, j], 0));
        IF j < UPB mat[i] THEN print(", ") FI
      OD;
      print("]");
      IF i < UPB mat THEN print(",") FI;
      print(newline)
    OD;
    print("]")
  END;
  
  COMMENT 打印数组 COMMENT
  PROC print array = (INTARRAY arr) VOID:
  BEGIN
    print("[");
    FOR i FROM LWB arr TO UPB arr DO
      print(whole(arr[i], 0));
      IF i < UPB arr THEN print(", ") FI
    OD;
    print("]")
  END;
  
  COMMENT 打印堆 COMMENT
  PROC print heap = (INTARRAY heap) VOID:
  BEGIN
    print("堆的数组表示：");
    print array(heap);
    print(newline);
    print("堆的树状表示：");
    print(newline);
    COMMENT TODO: 实现树状打印 COMMENT
    print("(树状表示待实现)")
  END
END

