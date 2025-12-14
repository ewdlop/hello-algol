# ALGOL 68 實現

本目錄包含《Hello 算法》中所有算法的 ALGOL 68 語言實現。

## 關於 ALGOL 68

ALGOL 68（Algorithmic Language 1968）是一種命令式編程語言，是 ALGOL 60 的後繼者。它引入了許多現代編程語言的概念，如：

- 強類型系統
- 結構化編程
- 動態數組
- 並行處理支持

## 文件結構

```
algol/
├── chapter_array_and_linkedlist/    # 數組與鏈表
├── chapter_computational_complexity/ # 計算複雜度
├── chapter_sorting/                 # 排序算法
├── utils/                           # 工具函數
└── README.md                        # 本文件
```

## 編譯和運行

ALGOL 68 有多個編譯器實現，常用的包括：

- **a68g**: GNU ALGOL 68 Genie
- **algol68toc**: ALGOL 68 to C 編譯器

### 使用 a68g 運行

```bash
a68g time_complexity.alg
```

### 使用 algol68toc 編譯

```bash
algol68toc time_complexity.alg
gcc time_complexity.c -o time_complexity
./time_complexity
```

## 注意事項

1. ALGOL 68 的語法與現代語言有較大差異，請注意：
   - 使用 `BEGIN...END` 作為代碼塊
   - 使用 `:=` 進行賦值
   - 使用 `PROC` 定義過程
   - 使用 `MODE` 定義類型

2. 本實現使用 ALGOL 68 的標準語法，但某些特性可能需要根據具體編譯器進行調整。

3. 數組使用 `FLEX[1:0]INT` 定義動態整數數組。

## 參考資源

- [ALGOL 68 官方報告](https://www.softwarepreservation.org/projects/ALGOL/report/Algol68_revised_report-AB.pdf)
- [ALGOL 68 Genie 文檔](https://jmvdveer.home.xs4all.nl/algol.html)

