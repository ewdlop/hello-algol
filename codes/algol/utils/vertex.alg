COMMENT
  File: vertex.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of vertex utilities
COMMENT

BEGIN
  MODE INTARRAY = FLEX[1:0]INT;
  
  COMMENT 顶点结构 COMMENT
  MODE VERTEX = STRUCT(INT val);
  
  COMMENT 输入值列表 vals ，返回顶点列表 vets COMMENT
  PROC vals to vets = (INTARRAY vals) INTARRAY:
  BEGIN
    INTARRAY vets := (1:UPB vals);
    FOR i FROM 1 TO UPB vals DO
      vets[i] := vals[i]
    OD;
    vets
  END;
  
  COMMENT 输入顶点列表 vets ，返回值列表 vals COMMENT
  PROC vets to vals = (INTARRAY vets) INTARRAY:
  BEGIN
    INTARRAY vals := (1:UPB vets);
    FOR i FROM 1 TO UPB vets DO
      vals[i] := vets[i]
    OD;
    vals
  END;
  
  COMMENT Driver Code COMMENT
  INTARRAY vals := (1, 3, 2, 5, 4);
  INTARRAY vets := vals to vets(vals);
  print("顶点列表：");
  FOR i FROM 1 TO UPB vets DO
    print(whole(vets[i], 0));
    IF i < UPB vets THEN print(", ") FI
  OD;
  print(newline)
END

