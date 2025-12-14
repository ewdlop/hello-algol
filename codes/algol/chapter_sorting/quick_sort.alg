COMMENT
  File: quick_sort.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of quick sort
COMMENT

BEGIN
  MODE INTARRAY = FLEX[1:0]INT;
  
  COMMENT 哨兵划分 COMMENT
  PROC partition = (REF INTARRAY nums, INT left, INT right) INT:
  BEGIN
    COMMENT 以 nums[left] 为基准数 COMMENT
    INT i := left;
    INT j := right;
    WHILE i < j DO
      WHILE i < j AND nums[j] >= nums[left] DO
        j -:= 1 COMMENT 从右向左找首个小于基准数的元素 COMMENT
      OD;
      WHILE i < j AND nums[i] <= nums[left] DO
        i +:= 1 COMMENT 从左向右找首个大于基准数的元素 COMMENT
      OD;
      COMMENT 元素交换 COMMENT
      INT tmp := nums[i];
      nums[i] := nums[j];
      nums[j] := tmp
    OD;
    COMMENT 将基准数交换至两子数组的分界线 COMMENT
    INT tmp := nums[i];
    nums[i] := nums[left];
    nums[left] := tmp;
    i COMMENT 返回基准数的索引 COMMENT
  END;
  
  COMMENT 快速排序 COMMENT
  PROC quick sort = (REF INTARRAY nums, INT left, INT right) VOID:
  BEGIN
    COMMENT 子数组长度为 1 时终止递归 COMMENT
    IF left >= right THEN
      SKIP
    ELSE
      BEGIN
        COMMENT 哨兵划分 COMMENT
        INT pivot := partition(nums, left, right);
        COMMENT 递归左子数组、右子数组 COMMENT
        quick sort(nums, left, pivot - 1);
        quick sort(nums, pivot + 1, right)
      END
    FI
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
  INTARRAY nums := (2, 4, 1, 0, 3, 5);
  quick sort(nums, 1, UPB nums);
  print("快速排序完成后 nums = ");
  print array(nums);
  print(newline)
END

