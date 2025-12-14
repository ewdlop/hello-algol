COMMENT
  File: list_node.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of list node utilities
COMMENT

BEGIN
  MODE INTARRAY = FLEX[1:0]INT;
  
  COMMENT 链表节点结构（使用数组模拟） COMMENT
  MODE LISTNODE = STRUCT(INT val, INT next);
  
  COMMENT 将列表反序列化为链表（返回数组表示） COMMENT
  PROC list to linked list = (INTARRAY arr) INTARRAY:
  BEGIN
    INTARRAY result := (1:UPB arr);
    FOR i FROM 1 TO UPB arr DO
      result[i] := arr[i]
    OD;
    result
  END;
  
  COMMENT 将链表序列化为列表（数组转数组） COMMENT
  PROC linked list to list = (INTARRAY list) INTARRAY:
  BEGIN
    INTARRAY result := (1:UPB list);
    FOR i FROM 1 TO UPB list DO
      result[i] := list[i]
    OD;
    result
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
  INTARRAY arr := (1, 2, 3, 4, 5);
  INTARRAY linked list := list to linked list(arr);
  print("链表：");
  print linked list(linked list);
  print(newline)
END

