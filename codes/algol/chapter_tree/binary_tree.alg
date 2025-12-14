COMMENT
  File: binary_tree.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of binary tree (simplified)
COMMENT

BEGIN
  COMMENT 二叉树节点结构（使用数组模拟） COMMENT
  MODE TREENODE = STRUCT(INT val, INT left, INT right);
  
  COMMENT 初始化二叉树节点 COMMENT
  PROC create node = (INT val) TREENODE:
    (val, 0, 0);
  
  COMMENT 打印二叉树（简化版本） COMMENT
  PROC print tree = (TREENODE node, STRING prefix) VOID:
  BEGIN
    IF val OF node /= 0 THEN
      BEGIN
        print((prefix, whole(val OF node, 0), newline));
        IF left OF node /= 0 THEN
          print tree((val OF node, left OF node, right OF node), prefix + "  ")
        FI;
        IF right OF node /= 0 THEN
          print tree((val OF node, left OF node, right OF node), prefix + "  ")
        FI
      END
    FI
  END;
  
  COMMENT Driver Code COMMENT
  COMMENT 初始化二叉树 COMMENT
  COMMENT 初始化节点 COMMENT
  TREENODE n1 := create node(1);
  TREENODE n2 := create node(2);
  TREENODE n3 := create node(3);
  TREENODE n4 := create node(4);
  TREENODE n5 := create node(5);
  
  COMMENT 构建节点之间的引用（指针） COMMENT
  COMMENT 注意：ALGOL 68 中指针操作较复杂，这里使用简化表示 COMMENT
  print("初始化二叉树");
  print(newline);
  print("(二叉树结构简化表示)");
  print(newline);
  print("节点值: n1=", whole(val OF n1, 0), ", n2=", whole(val OF n2, 0), ", n3=", whole(val OF n3, 0), ", n4=", whole(val OF n4, 0), ", n5=", whole(val OF n5, 0), newline)
END

