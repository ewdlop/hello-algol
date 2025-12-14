COMMENT
  File: graph_adjacency_list.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of graph using adjacency list (simplified)
COMMENT

BEGIN
  MODE INTARRAY = FLEX[1:0]INT;
  MODE INTMATRIX = FLEX[1:0, 1:0]INT;
  
  COMMENT 基于邻接表实现的无向图类（简化版本） COMMENT
  COMMENT 使用二维数组模拟邻接表 COMMENT
  INTMATRIX adj list := (1:5, 1:5);
  FOR i FROM 1 TO 5 DO
    FOR j FROM 1 TO 5 DO
      adj list[i, j] := 0
    OD
  OD;
  
  COMMENT 添加边 COMMENT
  PROC add edge = (REF INTMATRIX graph, INT v1, INT v2) VOID:
  BEGIN
    graph[v1, v2] := 1;
    graph[v2, v1] := 1
  END;
  
  COMMENT 删除边 COMMENT
  PROC remove edge = (REF INTMATRIX graph, INT v1, INT v2) VOID:
  BEGIN
    graph[v1, v2] := 0;
    graph[v2, v1] := 0
  END;
  
  COMMENT 打印邻接表 COMMENT
  PROC print graph = (INTMATRIX graph) VOID:
  BEGIN
    print("邻接表 =");
    print(newline);
    FOR i FROM 1 TO 5 DO
      BEGIN
        print((whole(i, 0), ": ["));
        INT count := 0;
        FOR j FROM 1 TO 5 DO
          IF graph[i, j] = 1 THEN
            BEGIN
              IF count > 0 THEN print(", ") FI;
              print(whole(j, 0));
              count +:= 1
            END
          FI
        OD;
        print("],");
        print(newline)
      END
    OD
  END;
  
  COMMENT Driver Code COMMENT
  COMMENT 初始化无向图 COMMENT
  COMMENT 添加边 COMMENT
  add edge(adj list, 1, 2);
  add edge(adj list, 1, 4);
  add edge(adj list, 2, 3);
  add edge(adj list, 3, 4);
  add edge(adj list, 3, 5);
  add edge(adj list, 4, 5);
  print("初始化后，图为");
  print(newline);
  print graph(adj list);
  
  COMMENT 添加边 COMMENT
  add edge(adj list, 1, 3);
  print("添加边 1-3 后，图为");
  print(newline);
  print graph(adj list);
  
  COMMENT 删除边 COMMENT
  remove edge(adj list, 1, 2);
  print("删除边 1-2 后，图为");
  print(newline);
  print graph(adj list)
END

