COMMENT
  File: tree_node.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of tree node utilities
COMMENT

BEGIN
  MODE INTARRAY = FLEX[1:0]INT;
  
  COMMENT 二叉树节点结构（使用数组模拟） COMMENT
  MODE TREENODE = STRUCT(INT val, INT left, INT right);
  
  COMMENT 将列表反序列化为二叉树：递归 COMMENT
  PROC list to tree dfs = (INTARRAY arr, INT i) TREENODE:
    IF i < 1 OR i > UPB arr OR arr[i] = 0 THEN
      COMMENT 如果索引超出数组长度，或者对应的元素为 0，则返回空节点 COMMENT
      (0, 0, 0)
    ELSE
      BEGIN
        COMMENT 构建当前节点 COMMENT
        TREENODE root := (arr[i], 0, 0);
        COMMENT 递归构建左右子树 COMMENT
        INT left idx := 2 * i;
        INT right idx := 2 * i + 1;
        IF left idx <= UPB arr THEN
          root := (val OF root, left idx, right OF root)
        FI;
        IF right idx <= UPB arr THEN
          root := (val OF root, left OF root, right idx)
        FI;
        root
      END
    FI;
  
  COMMENT 将列表反序列化为二叉树 COMMENT
  PROC list to tree = (INTARRAY arr) TREENODE:
    list to tree dfs(arr, 1);
  
  COMMENT 打印二叉树（简化版本） COMMENT
  PROC print tree = (TREENODE node, INT level) VOID:
  BEGIN
    IF val OF node /= 0 THEN
      BEGIN
        FOR i FROM 1 TO level DO
          print("  ")
        OD;
        print(whole(val OF node, 0));
        print(newline);
        IF left OF node /= 0 THEN
          print tree((val OF node, left OF node, right OF node), level + 1)
        FI;
        IF right OF node /= 0 THEN
          print tree((val OF node, left OF node, right OF node), level + 1)
        FI
      END
    FI
  END;
  
  COMMENT Driver Code COMMENT
  INTARRAY arr := (0, 1, 2, 3, 4, 0, 6, 7, 8, 9);
  COMMENT 注意：ALGOL 68 數組索引從 1 開始，所以第一個元素為 0 表示根節點在索引 1 COMMENT
  TREENODE root := list to tree(arr);
  print("二叉树：");
  print(newline);
  print tree(root, 0)
END

