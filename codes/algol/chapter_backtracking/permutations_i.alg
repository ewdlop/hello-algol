COMMENT
  File: permutations_i.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of permutations I
COMMENT

BEGIN
  MODE INTARRAY = FLEX[1:0]INT;
  MODE BOOLARRAY = FLEX[1:0]BOOL;
  
  COMMENT 回溯算法：全排列 I COMMENT
  PROC backtrack = (REF INTARRAY state, INTARRAY choices, REF BOOLARRAY selected, REF INT count) VOID:
  BEGIN
    COMMENT 当状态长度等于元素数量时，记录解 COMMENT
    IF UPB state = UPB choices THEN
      count +:= 1
    ELSE
      BEGIN
        COMMENT 遍历所有选择 COMMENT
        FOR i FROM 1 TO UPB choices DO
          COMMENT 剪枝：不允许重复选择元素 COMMENT
          IF NOT selected[i] THEN
            BEGIN
              COMMENT 尝试：做出选择，更新状态 COMMENT
              selected[i] := TRUE;
              INTARRAY new state := (1:UPB state + 1);
              FOR j FROM 1 TO UPB state DO
                new state[j] := state[j]
              OD;
              new state[UPB new state] := choices[i];
              state := new state;
              COMMENT 进行下一轮选择 COMMENT
              backtrack(state, choices, selected, count);
              COMMENT 回退：撤销选择，恢复到之前的状态 COMMENT
              selected[i] := FALSE;
              INTARRAY new state2 := (1:UPB state - 1);
              FOR j FROM 1 TO UPB state - 1 DO
                new state2[j] := state[j]
              OD;
              state := new state2
            END
          FI
        OD
      END
    FI
  END;
  
  COMMENT 全排列 I COMMENT
  PROC permutations i = (INTARRAY nums) INT:
  BEGIN
    INTARRAY state := (1:0);
    BOOLARRAY selected := (1:UPB nums);
    FOR i FROM 1 TO UPB nums DO
      selected[i] := FALSE
    OD;
    INT count := 0;
    backtrack(state, nums, selected, count);
    count
  END;
  
  COMMENT Driver Code COMMENT
  INTARRAY nums := (1, 2, 3);
  INT res := permutations i(nums);
  print("输入数组 nums = [1, 2, 3]");
  print(newline);
  print(("全排列数量 = ", whole(res, 0), newline))
END

