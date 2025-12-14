COMMENT
  File: simple_hash.alg
  Created Time: 2024-12-14
  Author: hello-algo
  ALGOL 68 implementation of simple hash functions
COMMENT

BEGIN
  INT modulus := 1000000007;
  
  COMMENT 加法哈希 COMMENT
  PROC add hash = (STRING key) INT:
  BEGIN
    INT hash := 0;
    FOR i FROM 1 TO UPB key DO
      hash +:= ABS key[i]
    OD;
    hash MOD modulus
  END;
  
  COMMENT 乘法哈希 COMMENT
  PROC mul hash = (STRING key) INT:
  BEGIN
    INT hash := 0;
    FOR i FROM 1 TO UPB key DO
      hash := (31 * hash + ABS key[i]) MOD modulus
    OD;
    hash
  END;
  
  COMMENT 异或哈希 COMMENT
  PROC xor hash = (STRING key) INT:
  BEGIN
    INT hash := 0;
    FOR i FROM 1 TO UPB key DO
      hash := hash XOR ABS key[i]
    OD;
    hash MOD modulus
  END;
  
  COMMENT 旋转哈希 COMMENT
  PROC rot hash = (STRING key) INT:
  BEGIN
    INT hash := 0;
    FOR i FROM 1 TO UPB key DO
      BEGIN
        INT left shift := hash * 16;
        INT right shift := hash OVER 16;
        hash := (left shift XOR right shift XOR ABS key[i]) MOD modulus
      END
    OD;
    hash
  END;
  
  COMMENT Driver Code COMMENT
  STRING key := "Hello 算法";
  
  INT hash := add hash(key);
  print(("加法哈希值为 ", whole(hash, 0), newline));
  
  hash := mul hash(key);
  print(("乘法哈希值为 ", whole(hash, 0), newline));
  
  hash := xor hash(key);
  print(("异或哈希值为 ", whole(hash, 0), newline));
  
  hash := rot hash(key);
  print(("旋转哈希值为 ", whole(hash, 0), newline))
END

