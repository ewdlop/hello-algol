COMMENT
  File: bubble_sort.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of bubble sort
COMMENT

BEGIN
  MODE INTARRAY = FLEX[1:0]INT;
  
  COMMENT 冒泡排序 COMMENT
  PROC bubble sort = (REF INTARRAY nums) VOID:
  BEGIN
    INT n := UPB nums;
    COMMENT 外循环：未排序区间为 [1, i] COMMENT
    FOR i FROM n BY -1 TO 2 DO
      COMMENT 内循环：将未排序区间 [1, i] 中的最大元素交换至该区间的最右端 COMMENT
      FOR j FROM 1 TO i - 1 DO
        IF nums[j] > nums[j + 1] THEN
          COMMENT 交换 nums[j] 与 nums[j + 1] COMMENT
          INT tmp := nums[j];
          nums[j] := nums[j + 1];
          nums[j + 1] := tmp
        FI
      OD
    OD
  END;
  
  COMMENT 冒泡排序（标志优化） COMMENT
  PROC bubble sort with flag = (REF INTARRAY nums) VOID:
  BEGIN
    INT n := UPB nums;
    COMMENT 外循环：未排序区间为 [1, i] COMMENT
    FOR i FROM n BY -1 TO 2 DO
      BOOL flag := FALSE; COMMENT 初始化标志位 COMMENT
      COMMENT 内循环：将未排序区间 [1, i] 中的最大元素交换至该区间的最右端 COMMENT
      FOR j FROM 1 TO i - 1 DO
        IF nums[j] > nums[j + 1] THEN
          COMMENT 交换 nums[j] 与 nums[j + 1] COMMENT
          INT tmp := nums[j];
          nums[j] := nums[j + 1];
          nums[j + 1] := tmp;
          flag := TRUE COMMENT 记录交换元素 COMMENT
        FI
      OD;
      IF NOT flag THEN
        GOTO exit COMMENT 此轮"冒泡"未交换任何元素，直接跳出 COMMENT
      FI;
      exit: SKIP
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
  bubble sort(nums);
  print("冒泡排序完成后 nums = ");
  print array(nums);
  print(newline);
  
  INTARRAY nums1 := (4, 1, 3, 1, 5, 2);
  bubble sort with flag(nums1);
  print("冒泡排序（标志优化）完成后 nums = ");
  print array(nums1);
  print(newline)
END

