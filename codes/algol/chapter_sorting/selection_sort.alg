COMMENT
  File: selection_sort.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of selection sort
COMMENT

BEGIN
  MODE INTARRAY = FLEX[1:0]INT;
  
  COMMENT 选择排序 COMMENT
  PROC selection sort = (REF INTARRAY nums) VOID:
  BEGIN
    INT n := UPB nums;
    COMMENT 外循环：未排序区间为 [1, n] COMMENT
    FOR i FROM 1 TO n - 1 DO
      COMMENT 内循环：找到未排序区间内的最小元素 COMMENT
      INT k := i;
      FOR j FROM i + 1 TO n DO
        IF nums[j] < nums[k] THEN
          k := j COMMENT 记录最小元素的索引 COMMENT
        FI
      OD;
      COMMENT 将该最小元素与未排序区间的首个元素交换 COMMENT
      INT tmp := nums[i];
      nums[i] := nums[k];
      nums[k] := tmp
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
  selection sort(nums);
  print("选择排序完成后 nums = ");
  print array(nums);
  print(newline)
END

