COMMENT
  File: stack.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of stack
COMMENT

BEGIN
  MODE INTARRAY = FLEX[1:0]INT;
  
  COMMENT 初始化栈 COMMENT
  INTARRAY stack := (1:0);
  
  COMMENT 元素入栈 COMMENT
  PROC push = (REF INTARRAY stack, INT val) VOID:
  BEGIN
    INTARRAY new stack := (1:UPB stack + 1);
    FOR i FROM 1 TO UPB stack DO
      new stack[i] := stack[i]
    OD;
    new stack[UPB new stack] := val;
    stack := new stack
  END;
  
  COMMENT 元素出栈 COMMENT
  PROC pop = (REF INTARRAY stack) INT:
  BEGIN
    IF UPB stack = 0 THEN
      -1
    ELSE
      BEGIN
        INT val := stack[UPB stack];
        INTARRAY new stack := (1:UPB stack - 1);
        FOR i FROM 1 TO UPB stack - 1 DO
          new stack[i] := stack[i]
        OD;
        stack := new stack;
        val
      END
    FI
  END;
  
  COMMENT 访问栈顶元素 COMMENT
  PROC peek = (INTARRAY stack) INT:
    IF UPB stack = 0 THEN
      -1
    ELSE
      stack[UPB stack]
    FI;
  
  COMMENT 打印栈 COMMENT
  PROC print stack = (INTARRAY stack) VOID:
  BEGIN
    print("栈 stack = [");
    FOR i FROM 1 TO UPB stack DO
      print(whole(stack[i], 0));
      IF i < UPB stack THEN print(", ") FI
    OD;
    print("]")
  END;
  
  COMMENT Driver Code COMMENT
  push(stack, 1);
  push(stack, 3);
  push(stack, 2);
  push(stack, 5);
  push(stack, 4);
  print stack(stack);
  print(newline);
  
  INT peek val := peek(stack);
  print(("栈顶元素 peek = ", whole(peek val, 0), newline));
  
  INT pop val := pop(stack);
  print(("出栈元素 pop = ", whole(pop val, 0), newline));
  print("出栈后 ");
  print stack(stack);
  print(newline);
  
  INT size := UPB stack;
  print(("栈的长度 size = ", whole(size, 0), newline));
  
  BOOL is empty := UPB stack = 0;
  print(("栈是否为空 = ", (IF is empty THEN "True" ELSE "False" FI), newline))
END

