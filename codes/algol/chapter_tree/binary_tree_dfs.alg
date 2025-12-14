COMMENT
  File: binary_tree_dfs.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of binary tree DFS traversal
COMMENT

BEGIN
  MODE INTARRAY = FLEX[1:0]INT;
  
  COMMENT 前序遍历 COMMENT
  PROC pre order = (INTARRAY tree, INT idx, REF INTARRAY res) VOID:
  BEGIN
    IF idx <= UPB tree AND tree[idx] /= 0 THEN
      BEGIN
        COMMENT 访问优先级：根节点 -> 左子树 -> 右子树 COMMENT
        INTARRAY new res := (1:UPB res + 1);
        FOR i FROM 1 TO UPB res DO
          new res[i] := res[i]
        OD;
        new res[UPB new res] := tree[idx];
        res := new res;
        COMMENT 递归左子树 COMMENT
        pre order(tree, 2 * idx, res);
        COMMENT 递归右子树 COMMENT
        pre order(tree, 2 * idx + 1, res)
      END
    FI
  END;
  
  COMMENT 中序遍历 COMMENT
  PROC in order = (INTARRAY tree, INT idx, REF INTARRAY res) VOID:
  BEGIN
    IF idx <= UPB tree AND tree[idx] /= 0 THEN
      BEGIN
        COMMENT 访问优先级：左子树 -> 根节点 -> 右子树 COMMENT
        COMMENT 递归左子树 COMMENT
        in order(tree, 2 * idx, res);
        COMMENT 访问根节点 COMMENT
        INTARRAY new res := (1:UPB res + 1);
        FOR i FROM 1 TO UPB res DO
          new res[i] := res[i]
        OD;
        new res[UPB new res] := tree[idx];
        res := new res;
        COMMENT 递归右子树 COMMENT
        in order(tree, 2 * idx + 1, res)
      END
    FI
  END;
  
  COMMENT 后序遍历 COMMENT
  PROC post order = (INTARRAY tree, INT idx, REF INTARRAY res) VOID:
  BEGIN
    IF idx <= UPB tree AND tree[idx] /= 0 THEN
      BEGIN
        COMMENT 访问优先级：左子树 -> 右子树 -> 根节点 COMMENT
        COMMENT 递归左子树 COMMENT
        post order(tree, 2 * idx, res);
        COMMENT 递归右子树 COMMENT
        post order(tree, 2 * idx + 1, res);
        COMMENT 访问根节点 COMMENT
        INTARRAY new res := (1:UPB res + 1);
        FOR i FROM 1 TO UPB res DO
          new res[i] := res[i]
        OD;
        new res[UPB new res] := tree[idx];
        res := new res
      END
    FI
  END;
  
  COMMENT 打印数组 COMMENT
  PROC print array = (INTARRAY arr) VOID:
  BEGIN
    print("[");
    FOR i FROM 1 TO UPB arr DO
      print(whole(arr[i], 0));
      IF i < UPB arr THEN print(", ") FI
    OD;
    print("]")
  END;
  
  COMMENT Driver Code COMMENT
  COMMENT 初始化二叉树（数组表示） COMMENT
  INTARRAY tree := (0, 1, 2, 3, 4, 5, 6, 7);
  COMMENT 注意：索引 0 不使用，从索引 1 开始 COMMENT
  
  COMMENT 前序遍历 COMMENT
  INTARRAY res := (1:0);
  pre order(tree, 1, res);
  print("前序遍历的节点打印序列 = ");
  print array(res);
  print(newline);
  
  COMMENT 中序遍历 COMMENT
  res := (1:0);
  in order(tree, 1, res);
  print("中序遍历的节点打印序列 = ");
  print array(res);
  print(newline);
  
  COMMENT 后序遍历 COMMENT
  res := (1:0);
  post order(tree, 1, res);
  print("后序遍历的节点打印序列 = ");
  print array(res);
  print(newline)
END

