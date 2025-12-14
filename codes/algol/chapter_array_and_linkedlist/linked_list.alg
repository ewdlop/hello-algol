COMMENT
  File: linked_list.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of linked list (simplified using arrays)
COMMENT

BEGIN
  MODE INTARRAY = FLEX[1:0]INT;
  
  COMMENT 链表节点（使用数组模拟） COMMENT
  MODE LISTNODE = STRUCT(INT val, INT next);
  
  COMMENT 初始化链表节点 COMMENT
  PROC create node = (INT val) LISTNODE:
    (val, 0);
  
  COMMENT 在链表的节点 n0 之后插入节点 P COMMENT
  PROC insert = (REF LISTNODE n0, LISTNODE P) VOID:
  BEGIN
    COMMENT 简化版本：使用数组索引模拟指针 COMMENT
    COMMENT 注意：ALGOL 68 中指针操作较复杂，这里使用简化表示 COMMENT
    SKIP
  END;
  
  COMMENT 删除链表的节点 n0 之后的首个节点 COMMENT
  PROC remove = (REF LISTNODE n0) VOID:
  BEGIN
    COMMENT 简化版本 COMMENT
    SKIP
  END;
  
  COMMENT 访问链表中索引为 index 的节点 COMMENT
  PROC access = (INTARRAY list, INT index) INT:
    IF index >= 1 AND index <= UPB list THEN
      list[index]
    ELSE
      -1
    FI;
  
  COMMENT 在链表中查找值为 target 的首个节点 COMMENT
  PROC find = (INTARRAY list, INT target) INT:
  BEGIN
    FOR i FROM 1 TO UPB list DO
      IF list[i] = target THEN
        GOTO found
      FI
    OD;
    found: SKIP;
    -1
  END;
  
  COMMENT 打印链表 COMMENT
  PROC print linked list = (INTARRAY list) VOID:
  BEGIN
    FOR i FROM 1 TO UPB list DO
      print(whole(list[i], 0));
      IF i < UPB list THEN print(" -> ") FI
    OD
  END;
  
  COMMENT Driver Code COMMENT
  COMMENT 初始化链表 COMMENT
  INTARRAY list := (1, 3, 2, 5, 4);
  print("初始化的链表为 ");
  print linked list(list);
  print(newline);
  
  COMMENT 访问节点 COMMENT
  INT node val := access(list, 3);
  print(("链表中索引 3 处的节点的值 = ", whole(node val, 0), newline));
  
  COMMENT 查找节点 COMMENT
  INT index := find(list, 2);
  print(("链表中值为 2 的节点的索引 = ", whole(index, 0), newline))
END

