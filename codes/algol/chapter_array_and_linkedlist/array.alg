COMMENT
  File: array.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of array operations
COMMENT

BEGIN
  MODE INTARRAY = FLEX[1:0]INT;
  
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
  
  COMMENT 随机访问 COMMENT
  PROC random access = (INTARRAY nums) INT:
  BEGIN
    INT index := 3;
    INT val := nums[index];
    print(("在索引 ", whole(index, 0), " 处的元素为 ", whole(val, 0), newline));
    val
  END;
  
  COMMENT 插入元素 COMMENT
  PROC insert = (REF INTARRAY nums, INT num, INT index) VOID:
  BEGIN
    COMMENT 移动元素 COMMENT
    FOR i FROM UPB nums BY -1 TO index DO
      nums[i + 1] := nums[i]
    OD;
    nums[index] := num
  END;
  
  COMMENT 删除元素 COMMENT
  PROC remove = (REF INTARRAY nums, INT index) VOID:
  BEGIN
    COMMENT 移动元素 COMMENT
    FOR i FROM index TO UPB nums - 1 DO
      nums[i] := nums[i + 1]
    OD
  END;
  
  COMMENT 遍历数组 COMMENT
  PROC traverse = (INTARRAY nums) VOID:
  BEGIN
    INT count := 0;
    FOR i FROM LWB nums TO UPB nums DO
      count +:= 1
    OD;
    print(("遍历数组，统计元素数量 = ", whole(count, 0), newline))
  END;
  
  COMMENT 查找元素 COMMENT
  PROC find = (INTARRAY nums, INT target) INT:
  BEGIN
    FOR i FROM LWB nums TO UPB nums DO
      IF nums[i] = target THEN
        print(("在数组中查找元素 ", whole(target, 0), " ，返回索引 ", whole(i, 0), newline));
        GOTO found
      FI
    OD;
    print(("在数组中查找元素 ", whole(target, 0), " ，未找到", newline));
    found: SKIP;
    -1
  END;
  
  COMMENT Driver Code COMMENT
  INTARRAY nums := (1, 3, 2, 5, 4);
  print("数组 nums = ");
  print array(nums);
  print(newline);
  
  INT val := random access(nums);
  
  INTARRAY nums2 := (1, 3, 2, 5, 4);
  insert(nums2, 6, 3);
  print("在索引 3 处插入数字 6 ，得到 nums = ");
  print array(nums2);
  print(newline);
  
  INTARRAY nums3 := (1, 3, 2, 5, 4);
  remove(nums3, 2);
  print("删除索引 2 处的元素，得到 nums = ");
  print array(nums3);
  print(newline);
  
  traverse(nums);
  
  INT index := find(nums, 3)
END

