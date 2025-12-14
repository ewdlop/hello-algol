COMMENT
  File: binary_search_recur.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of binary search using recursion
COMMENT

BEGIN
  MODE INTARRAY = FLEX[1:0]INT;
  
  COMMENT 二分查找：问题 f(i, j) COMMENT
  PROC dfs = (INTARRAY nums, INT target, INT i, INT j) INT:
  BEGIN
    COMMENT 若区间为空，代表无目标元素，则返回 -1 COMMENT
    IF i > j THEN
      -1
    ELSE
      BEGIN
        INT m := (i + j) OVER 2;
        IF nums[m] < target THEN
          COMMENT 递归子问题 f(m+1, j) COMMENT
          dfs(nums, target, m + 1, j)
        ELIF nums[m] > target THEN
          COMMENT 递归子问题 f(i, m-1) COMMENT
          dfs(nums, target, i, m - 1)
        ELSE
          COMMENT 找到目标元素，返回其索引 COMMENT
          m
        FI
      END
    FI
  END;
  
  COMMENT 二分查找 COMMENT
  PROC binary search = (INTARRAY nums, INT target) INT:
    dfs(nums, target, 1, UPB nums);
  
  COMMENT Driver Code COMMENT
  INT target := 6;
  INTARRAY nums := (1, 3, 6, 8, 12, 15, 23, 26, 31, 35);
  INT index := binary search(nums, target);
  print(("目标元素 ", whole(target, 0), " 的索引 = ", whole(index, 0), newline))
END

