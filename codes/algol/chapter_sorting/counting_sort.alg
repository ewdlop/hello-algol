COMMENT
  File: counting_sort.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of counting sort
COMMENT

BEGIN
  MODE INTARRAY = FLEX[1:0]INT;
  
  COMMENT 计数排序 COMMENT
  PROC counting sort = (REF INTARRAY nums) VOID:
  BEGIN
    COMMENT 1. 统计数组最大元素 m COMMENT
    INT m := 0;
    FOR i FROM 1 TO UPB nums DO
      IF nums[i] > m THEN
        m := nums[i]
      FI
    OD;
    COMMENT 2. 统计各数字的出现次数 COMMENT
    INTARRAY counter := (0:m);
    FOR i FROM 0 TO m DO
      counter[i] := 0
    OD;
    FOR i FROM 1 TO UPB nums DO
      counter[nums[i]] +:= 1
    OD;
    COMMENT 3. 求 counter 的前缀和，将"出现次数"转换为"尾索引" COMMENT
    FOR i FROM 1 TO m DO
      counter[i] +:= counter[i - 1]
    OD;
    COMMENT 4. 倒序遍历 nums ，将各元素填入结果数组 res COMMENT
    INTARRAY res := (1:UPB nums);
    FOR i FROM UPB nums BY -1 TO 1 DO
      BEGIN
        INT num := nums[i];
        res[counter[num]] := num;
        counter[num] -:= 1
      END
    OD;
    COMMENT 使用结果数组 res 覆盖原数组 nums COMMENT
    FOR i FROM 1 TO UPB nums DO
      nums[i] := res[i]
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
  INTARRAY nums := (1, 0, 1, 2, 0, 4, 0, 2, 2, 4);
  counting sort(nums);
  print("计数排序完成后 nums = ");
  print array(nums);
  print(newline)
END

