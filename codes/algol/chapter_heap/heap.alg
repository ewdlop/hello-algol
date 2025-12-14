COMMENT
  File: heap.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of heap (simplified)
COMMENT

BEGIN
  MODE INTARRAY = FLEX[1:0]INT;
  
  COMMENT 元素入堆（大顶堆） COMMENT
  PROC heap push = (REF INTARRAY heap, INT val) VOID:
  BEGIN
    INTARRAY new heap := (1:UPB heap + 1);
    FOR i FROM 1 TO UPB heap DO
      new heap[i] := heap[i]
    OD;
    new heap[UPB new heap] := val;
    heap := new heap;
    COMMENT 上浮操作（简化） COMMENT
    INT i := UPB heap;
    WHILE i > 1 AND heap[i] > heap[i OVER 2] DO
      BEGIN
        INT tmp := heap[i];
        heap[i] := heap[i OVER 2];
        heap[i OVER 2] := tmp;
        i := i OVER 2
      END
    OD
  END;
  
  COMMENT 堆顶元素出堆 COMMENT
  PROC heap pop = (REF INTARRAY heap) INT:
  BEGIN
    IF UPB heap = 0 THEN
      -1
    ELSE
      BEGIN
        INT val := heap[1];
        heap[1] := heap[UPB heap];
        INTARRAY new heap := (1:UPB heap - 1);
        FOR i FROM 1 TO UPB heap - 1 DO
          new heap[i] := heap[i]
        OD;
        heap := new heap;
        COMMENT 下沉操作（简化） COMMENT
        INT i := 1;
        WHILE 2 * i <= UPB heap DO
          BEGIN
            INT j := 2 * i;
            IF j + 1 <= UPB heap AND heap[j + 1] > heap[j] THEN
              j +:= 1
            FI;
            IF heap[i] >= heap[j] THEN
              GOTO done
            FI;
            INT tmp := heap[i];
            heap[i] := heap[j];
            heap[j] := tmp;
            i := j
          END;
        done: SKIP;
        val
      END
    FI
  END;
  
  COMMENT 打印堆 COMMENT
  PROC print heap = (INTARRAY heap) VOID:
  BEGIN
    print("堆的数组表示：");
    print("[");
    FOR i FROM 1 TO UPB heap DO
      print(whole(heap[i], 0));
      IF i < UPB heap THEN print(", ") FI
    OD;
    print("]");
    print(newline)
  END;
  
  COMMENT Driver Code COMMENT
  INTARRAY max heap := (1:0);
  
  print("以下测试样例为大顶堆");
  print(newline);
  
  COMMENT 元素入堆 COMMENT
  heap push(max heap, 1);
  print("元素 1 入堆后");
  print(newline);
  print heap(max heap);
  
  heap push(max heap, 3);
  print("元素 3 入堆后");
  print(newline);
  print heap(max heap);
  
  heap push(max heap, 2);
  print("元素 2 入堆后");
  print(newline);
  print heap(max heap);
  
  COMMENT 获取堆顶元素 COMMENT
  IF UPB max heap > 0 THEN
    BEGIN
      INT peek := max heap[1];
      print(("堆顶元素为 ", whole(peek, 0), newline))
    END
  FI;
  
  COMMENT 堆顶元素出堆 COMMENT
  INT pop val := heap pop(max heap);
  print(("堆顶元素 ", whole(pop val, 0), " 出堆后", newline));
  print heap(max heap)
END

