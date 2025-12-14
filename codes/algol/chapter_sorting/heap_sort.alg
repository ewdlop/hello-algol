COMMENT
  File: heap_sort.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of heap sort
COMMENT

BEGIN
  MODE INTARRAY = FLEX[1:0]INT;
  
  COMMENT 堆的长度为 n ，从节点 i 开始，从顶至底堆化 COMMENT
  PROC sift down = (REF INTARRAY nums, INT n, INT i) VOID:
  BEGIN
    INT idx := i;
    WHILE TRUE DO
      BEGIN
        COMMENT 判断节点 i, l, r 中值最大的节点，记为 ma COMMENT
        INT l := 2 * idx;
        INT r := 2 * idx + 1;
        INT ma := idx;
        IF l <= n AND nums[l] > nums[ma] THEN
          ma := l
        FI;
        IF r <= n AND nums[r] > nums[ma] THEN
          ma := r
        FI;
        COMMENT 若节点 i 最大或索引 l, r 越界，则无须继续堆化，跳出 COMMENT
        IF ma = idx THEN
          GOTO done
        FI;
        COMMENT 交换两节点 COMMENT
        INT tmp := nums[idx];
        nums[idx] := nums[ma];
        nums[ma] := tmp;
        COMMENT 循环向下堆化 COMMENT
        idx := ma
      END
    OD;
    done: SKIP
  END;
  
  COMMENT 堆排序 COMMENT
  PROC heap sort = (REF INTARRAY nums) VOID:
  BEGIN
    INT n := UPB nums;
    COMMENT 建堆操作：堆化除叶节点以外的其他所有节点 COMMENT
    FOR i FROM n OVER 2 BY -1 TO 1 DO
      sift down(nums, n, i)
    OD;
    COMMENT 从堆中提取最大元素，循环 n-1 轮 COMMENT
    FOR i FROM n BY -1 TO 2 DO
      BEGIN
        COMMENT 交换根节点与最右叶节点（交换首元素与尾元素） COMMENT
        INT tmp := nums[1];
        nums[1] := nums[i];
        nums[i] := tmp;
        COMMENT 以根节点为起点，从顶至底进行堆化 COMMENT
        sift down(nums, i - 1, 1)
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
  INTARRAY nums := (4, 1, 3, 1, 5, 2);
  heap sort(nums);
  print("堆排序完成后 nums = ");
  print array(nums);
  print(newline)
END

