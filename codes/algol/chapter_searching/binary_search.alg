COMMENT
  File: binary_search.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of binary search
COMMENT

BEGIN
  MODE INTARRAY = FLEX[1:0]INT;
  
  COMMENT 二分查找（双闭区间） COMMENT
  PROC binary search = (INTARRAY nums, INT target) INT:
  BEGIN
    COMMENT 初始化双闭区间 [1, n] ，即 i, j 分别指向数组首元素、尾元素 COMMENT
    INT i := LWB nums;
    INT j := UPB nums;
    COMMENT 循环，当搜索区间为空时跳出（当 i > j 时为空） COMMENT
    WHILE i <= j DO
      COMMENT 计算中点索引 m COMMENT
      INT m := (i + j) OVER 2;
      IF nums[m] < target THEN
        i := m + 1 COMMENT 此情况说明 target 在区间 [m+1, j] 中 COMMENT
      ELIF nums[m] > target THEN
        j := m - 1 COMMENT 此情况说明 target 在区间 [i, m-1] 中 COMMENT
      ELSE
        GOTO found COMMENT 找到目标元素，返回其索引 COMMENT
      FI
    OD;
    found: SKIP;
    -1 COMMENT 未找到目标元素，返回 -1 COMMENT
  END;
  
  COMMENT 二分查找（左闭右开区间） COMMENT
  PROC binary search lcro = (INTARRAY nums, INT target) INT:
  BEGIN
    COMMENT 初始化左闭右开区间 [1, n+1) ，即 i, j 分别指向数组首元素、尾元素+1 COMMENT
    INT i := LWB nums;
    INT j := UPB nums + 1;
    COMMENT 循环，当搜索区间为空时跳出（当 i = j 时为空） COMMENT
    WHILE i < j DO
      INT m := (i + j) OVER 2; COMMENT 计算中点索引 m COMMENT
      IF nums[m] < target THEN
        i := m + 1 COMMENT 此情况说明 target 在区间 [m+1, j) 中 COMMENT
      ELIF nums[m] > target THEN
        j := m COMMENT 此情况说明 target 在区间 [i, m) 中 COMMENT
      ELSE
        GOTO found COMMENT 找到目标元素，返回其索引 COMMENT
      FI
    OD;
    found: SKIP;
    -1 COMMENT 未找到目标元素，返回 -1 COMMENT
  END;
  
  COMMENT Driver Code COMMENT
  INT target := 6;
  INTARRAY nums := (1, 3, 6, 8, 12, 15, 23, 26, 31, 35);
  
  COMMENT 二分查找（双闭区间） COMMENT
  INT index := binary search(nums, target);
  print(("目标元素 ", whole(target, 0), " 的索引 = ", whole(index, 0), newline));
  
  COMMENT 二分查找（左闭右开区间） COMMENT
  index := binary search lcro(nums, target);
  print(("目标元素 ", whole(target, 0), " 的索引 = ", whole(index, 0), newline))
END

