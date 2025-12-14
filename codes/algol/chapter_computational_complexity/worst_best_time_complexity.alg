COMMENT
  File: worst_best_time_complexity.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of worst/best time complexity examples
COMMENT

BEGIN
  MODE INTARRAY = FLEX[1:0]INT;
  
  COMMENT 生成一个数组，元素为: 1, 2, ..., n ，顺序被打乱 COMMENT
  PROC random numbers = (INT n) INTARRAY:
  BEGIN
    COMMENT 生成数组 nums =: 1, 2, 3, ..., n COMMENT
    INTARRAY nums := (1:n);
    FOR i FROM 1 TO n DO
      nums[i] := i
    OD;
    COMMENT 随机打乱数组元素（简化版本：反转数组） COMMENT
    FOR i FROM 1 TO n OVER 2 DO
      INT tmp := nums[i];
      nums[i] := nums[n - i + 1];
      nums[n - i + 1] := tmp
    OD;
    nums
  END;
  
  COMMENT 查找数组 nums 中数字 1 所在索引 COMMENT
  PROC find one = (INTARRAY nums) INT:
  BEGIN
    INT n := UPB nums;
    FOR i FROM 1 TO n DO
      COMMENT 当元素 1 在数组头部时，达到最佳时间复杂度 O(1) COMMENT
      COMMENT 当元素 1 在数组尾部时，达到最差时间复杂度 O(n) COMMENT
      IF nums[i] = 1 THEN
        GOTO found
      FI
    OD;
    found: SKIP;
    -1
  END;
  
  COMMENT Driver Code COMMENT
  FOR i FROM 1 TO 3 DO
    INT n := 10;
    INTARRAY nums := random numbers(n);
    INT index := find one(nums);
    print(("数组 [ 1, 2, ..., n ] 被打乱后 = "));
    FOR j FROM 1 TO n DO
      print(whole(nums[j], 0));
      IF j < n THEN print(", ") FI
    OD;
    print(newline);
    print(("数字 1 的索引为 ", whole(index, 0), newline)))
  OD
END

