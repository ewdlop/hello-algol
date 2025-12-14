COMMENT
  File: merge_sort.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of merge sort
COMMENT

BEGIN
  MODE INTARRAY = FLEX[1:0]INT;
  
  COMMENT 合并左子数组和右子数组 COMMENT
  PROC merge = (REF INTARRAY nums, INT left, INT mid, INT right) VOID:
  BEGIN
    COMMENT 左子数组区间 [left, mid], 右子数组区间 [mid+1, right] COMMENT
    INTARRAY tmp := (1:right - left + 1);
    INT i := left;
    INT j := mid + 1;
    INT k := 1;
    COMMENT 当左右子数组都还有元素时，进行比较并将较小的元素复制到临时数组中 COMMENT
    WHILE i <= mid AND j <= right DO
      IF nums[i] <= nums[j] THEN
        tmp[k] := nums[i];
        i +:= 1
      ELSE
        tmp[k] := nums[j];
        j +:= 1
      FI;
      k +:= 1
    OD;
    COMMENT 将左子数组剩余元素复制到临时数组 COMMENT
    WHILE i <= mid DO
      tmp[k] := nums[i];
      i +:= 1;
      k +:= 1
    OD;
    COMMENT 将右子数组剩余元素复制到临时数组 COMMENT
    WHILE j <= right DO
      tmp[k] := nums[j];
      j +:= 1;
      k +:= 1
    OD;
    COMMENT 将临时数组 tmp 中的元素复制回原数组 nums 的对应区间 COMMENT
    FOR m FROM 1 TO UPB tmp DO
      nums[left + m - 1] := tmp[m]
    OD
  END;
  
  COMMENT 归并排序 COMMENT
  PROC merge sort = (REF INTARRAY nums, INT left, INT right) VOID:
  BEGIN
    COMMENT 终止条件 COMMENT
    IF left >= right THEN
      SKIP
    ELSE
      BEGIN
        COMMENT 划分阶段 COMMENT
        INT mid := (left + right) OVER 2;
        COMMENT 递归子数组 COMMENT
        merge sort(nums, left, mid);
        merge sort(nums, mid + 1, right);
        COMMENT 合并阶段 COMMENT
        merge(nums, left, mid, right)
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
  INTARRAY nums := (7, 3, 2, 6, 0, 1, 5, 4);
  merge sort(nums, 1, UPB nums);
  print("归并排序完成后 nums = ");
  print array(nums);
  print(newline)
END

