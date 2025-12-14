COMMENT
  File: radix_sort.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of radix sort
COMMENT

BEGIN
  MODE INTARRAY = FLEX[1:0]INT;
  
  COMMENT 获取元素 num 的第 k 位，其中 exp = 10^(k-1) COMMENT
  PROC digit = (INT num, INT exp) INT:
    (num OVER exp) MOD 10;
  
  COMMENT 计数排序（根据 nums 第 k 位排序） COMMENT
  PROC counting sort digit = (REF INTARRAY nums, INT exp) VOID:
  BEGIN
    COMMENT 十进制的位范围为 0~9 ，因此需要长度为 10 的桶数组 COMMENT
    INTARRAY counter := (0:9);
    FOR i FROM 0 TO 9 DO
      counter[i] := 0
    OD;
    INT n := UPB nums;
    COMMENT 统计 0~9 各数字的出现次数 COMMENT
    FOR i FROM 1 TO n DO
      BEGIN
        INT d := digit(nums[i], exp); COMMENT 获取 nums[i] 第 k 位，记为 d COMMENT
        counter[d] +:= 1 COMMENT 统计数字 d 的出现次数 COMMENT
      END
    OD;
    COMMENT 求前缀和，将"出现个数"转换为"数组索引" COMMENT
    FOR i FROM 1 TO 9 DO
      counter[i] +:= counter[i - 1]
    OD;
    COMMENT 倒序遍历，根据桶内统计结果，将各元素填入 res COMMENT
    INTARRAY res := (1:n);
    FOR i FROM n BY -1 TO 1 DO
      BEGIN
        INT d := digit(nums[i], exp);
        INT j := counter[d]; COMMENT 获取 d 在数组中的索引 j COMMENT
        res[j] := nums[i]; COMMENT 将当前元素填入索引 j COMMENT
        counter[d] -:= 1 COMMENT 将 d 的数量减 1 COMMENT
      END
    OD;
    COMMENT 使用结果覆盖原数组 nums COMMENT
    FOR i FROM 1 TO n DO
      nums[i] := res[i]
    OD
  END;
  
  COMMENT 基数排序 COMMENT
  PROC radix sort = (REF INTARRAY nums) VOID:
  BEGIN
    COMMENT 获取数组的最大元素，用于判断最大位数 COMMENT
    INT m := 0;
    FOR i FROM 1 TO UPB nums DO
      IF nums[i] > m THEN
        m := nums[i]
      FI
    OD;
    COMMENT 按照从低位到高位的顺序遍历 COMMENT
    INT exp := 1;
    WHILE exp <= m DO
      BEGIN
        COMMENT 对数组元素的第 k 位执行计数排序 COMMENT
        COMMENT k = 1 -> exp = 1, k = 2 -> exp = 10, 即 exp = 10^(k-1) COMMENT
        counting sort digit(nums, exp);
        exp *:= 10
      END
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
  INTARRAY nums := (10546151, 35663510, 42865989, 34862445, 81883077, 88906420, 72429244, 30524779, 82060337, 63832996);
  radix sort(nums);
  print("基数排序完成后 nums = ");
  print array(nums);
  print(newline)
END

