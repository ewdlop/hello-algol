COMMENT
  File: bucket_sort.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of bucket sort
COMMENT

BEGIN
  MODE REALARRAY = FLEX[1:0]REAL;
  MODE REALMATRIX = FLEX[1:0, 1:0]REAL;
  
  COMMENT 桶排序 COMMENT
  PROC bucket sort = (REF REALARRAY nums) VOID:
  BEGIN
    INT n := UPB nums;
    COMMENT 初始化 k = n/2 个桶，预期向每个桶分配 2 个元素 COMMENT
    INT k := n OVER 2;
    MODE BUCKET = FLEX[1:0]REAL;
    MODE BUCKETARRAY = FLEX[1:0]BUCKET;
    COMMENT 简化实现：使用固定大小的桶 COMMENT
    REALMATRIX buckets := (1:k, 1:n);
    INTARRAY bucket sizes := (1:k);
    FOR i FROM 1 TO k DO
      bucket sizes[i] := 0
    OD;
    COMMENT 1. 将数组元素分配到各个桶中 COMMENT
    FOR i FROM 1 TO n DO
      BEGIN
        COMMENT 输入数据范围为 [0, 1)，使用 num * k 映射到索引范围 [1, k] COMMENT
        INT bucket idx := ENTIER(nums[i] * k) + 1;
        IF bucket idx > k THEN bucket idx := k FI;
        bucket sizes[bucket idx] +:= 1;
        buckets[bucket idx, bucket sizes[bucket idx]] := nums[i]
      END
    OD;
    COMMENT 2. 对各个桶执行排序（使用简单插入排序） COMMENT
    FOR i FROM 1 TO k DO
      BEGIN
        INT size := bucket sizes[i];
        FOR j FROM 2 TO size DO
          BEGIN
            REAL key := buckets[i, j];
            INT k := j - 1;
            WHILE k >= 1 AND buckets[i, k] > key DO
              BEGIN
                buckets[i, k + 1] := buckets[i, k];
                k -:= 1
              END
            OD;
            buckets[i, k + 1] := key
          END
        OD
      END
    OD;
    COMMENT 3. 遍历桶合并结果 COMMENT
    INT idx := 1;
    FOR i FROM 1 TO k DO
      FOR j FROM 1 TO bucket sizes[i] DO
        BEGIN
          nums[idx] := buckets[i, j];
          idx +:= 1
        END
      OD
    OD
  END;
  
  COMMENT 打印数组 COMMENT
  PROC print array = (REALARRAY nums) VOID:
  BEGIN
    print("[");
    FOR i FROM LWB nums TO UPB nums DO
      print(fixed(nums[i], -1, 2));
      IF i < UPB nums THEN print(", ") FI
    OD;
    print("]")
  END;
  
  COMMENT Driver Code COMMENT
  COMMENT 设输入数据为浮点数，范围为 [0, 1) COMMENT
  REALARRAY nums := (0.49, 0.96, 0.82, 0.09, 0.57, 0.43, 0.91, 0.75, 0.15, 0.37);
  bucket sort(nums);
  print("桶排序完成后 nums = ");
  print array(nums);
  print(newline)
END

