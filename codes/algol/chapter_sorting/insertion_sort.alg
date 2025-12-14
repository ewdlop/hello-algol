COMMENT
  File: insertion_sort.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of insertion sort
COMMENT

BEGIN
  MODE INTARRAY = FLEX[1:0]INT;
  
  COMMENT 插入排序 COMMENT
  PROC insertion sort = (REF INTARRAY nums) VOID:
  BEGIN
    INT n := UPB nums;
    COMMENT 外循环：已排序区间为 [1, i-1] COMMENT
    FOR i FROM 2 TO n DO
      INT base := nums[i];
      INT j := i - 1;
      COMMENT 内循环：将 base 插入到已排序区间 [1, i-1] 中的正确位置 COMMENT
      WHILE j >= 1 AND nums[j] > base DO
        nums[j + 1] := nums[j]; COMMENT 将 nums[j] 向右移动一位 COMMENT
        j -:= 1
      OD;
      nums[j + 1] := base COMMENT 将 base 赋值到正确位置 COMMENT
    OD
  END;
  
  COMMENT 打印数组 COMMENT
  PROC print array = (INTARRAY nums) VOID:
  BEGIN
    print("[");
    FOR i FROM LWB nums TO UPB nums DO
      print(whole(nums[i], 0));
      IF i < UPB nums THEN print(", ") FI
    OD;
    print("]")
  END;
  
  COMMENT Driver Code COMMENT
  INTARRAY nums := (4, 1, 3, 1, 5, 2);
  insertion sort(nums);
  print("插入排序完成后 nums = ");
  print array(nums);
  print(newline)
END

