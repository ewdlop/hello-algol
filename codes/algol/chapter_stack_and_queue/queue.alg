COMMENT
  File: queue.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of queue
COMMENT

BEGIN
  MODE INTARRAY = FLEX[1:0]INT;
  
  COMMENT 初始化队列 COMMENT
  INTARRAY que := (1:0);
  
  COMMENT 元素入队 COMMENT
  PROC enqueue = (REF INTARRAY que, INT val) VOID:
  BEGIN
    INTARRAY new que := (1:UPB que + 1);
    FOR i FROM 1 TO UPB que DO
      new que[i] := que[i]
    OD;
    new que[UPB new que] := val;
    que := new que
  END;
  
  COMMENT 元素出队 COMMENT
  PROC dequeue = (REF INTARRAY que) INT:
  BEGIN
    IF UPB que = 0 THEN
      -1
    ELSE
      BEGIN
        INT val := que[1];
        INTARRAY new que := (1:UPB que - 1);
        FOR i FROM 1 TO UPB que - 1 DO
          new que[i] := que[i + 1]
        OD;
        que := new que;
        val
      END
    FI
  END;
  
  COMMENT 访问队首元素 COMMENT
  PROC front = (INTARRAY que) INT:
    IF UPB que = 0 THEN
      -1
    ELSE
      que[1]
    FI;
  
  COMMENT 打印队列 COMMENT
  PROC print queue = (INTARRAY que) VOID:
  BEGIN
    print("队列 que = [");
    FOR i FROM 1 TO UPB que DO
      print(whole(que[i], 0));
      IF i < UPB que THEN print(", ") FI
    OD;
    print("]")
  END;
  
  COMMENT Driver Code COMMENT
  enqueue(que, 1);
  enqueue(que, 3);
  enqueue(que, 2);
  enqueue(que, 5);
  enqueue(que, 4);
  print queue(que);
  print(newline);
  
  INT front val := front(que);
  print(("队首元素 front = ", whole(front val, 0), newline));
  
  INT pop val := dequeue(que);
  print(("出队元素 pop = ", whole(pop val, 0), newline));
  print("出队后 ");
  print queue(que);
  print(newline);
  
  INT size := UPB que;
  print(("队列长度 size = ", whole(size, 0), newline));
  
  BOOL is empty := UPB que = 0;
  print(("队列是否为空 = ", (IF is empty THEN "True" ELSE "False" FI), newline))
END

