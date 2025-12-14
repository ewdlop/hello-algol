COMMENT
  File: linear_search.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of linear search
COMMENT

BEGIN
  MODE INTARRAY = FLEX[1:0]INT;
  
  COMMENT 线性查找（数组） COMMENT
  PROC linear search array = (INTARRAY nums, INT target) INT:
  BEGIN
    COMMENT 遍历数组 COMMENT
    FOR i FROM LWB nums TO UPB nums DO
      IF nums[i] = target THEN
        COMMENT 找到目标元素，返回其索引 COMMENT
        GOTO found
      FI
    OD;
    found: SKIP;
    -1 COMMENT 未找到目标元素，返回 -1 COMMENT
  END;
  
  COMMENT Driver Code COMMENT
  INT target := 3;
  INTARRAY nums := (1, 5, 3, 2, 4, 7, 5, 9, 10, 8);
  INT index := linear search array(nums, target);
  print(("目标元素 ", whole(target, 0), " 的索引 = ", whole(index, 0), newline))
END

