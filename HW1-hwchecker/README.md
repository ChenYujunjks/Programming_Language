**Elementary Math Homework Checker**
Author: Yujun Chen (NetID: yc5508)

---

### Files Included

- `yc5508.hwchecker.l` – Flex scanner
- `yc5508.hwchecker.y` – Bison grammar and parser (contains `main()` and `yyerror()`)
- `Makefile` – Build script for the parser

---

### Build Instructions

To build the parser:

```bash
make
```

This will generate the executable named `hw-checker`.

To clean up generated files:

```bash
make clean
```

---

### Run Instructions

The program reads from standard input. Example:

```bash
./hw-checker < input1.txt
```

---

### Features Implemented

- Sequential line numbering check (must be 1:, 2:, …)
- Support for +, -, \*, / with correct precedence and associativity
- Comparison operators `<`, `>`, `=` with proper precedence
- Parentheses for grouping
- Floor division (round down toward −∞)
- Division by zero → prints `Error: Division by Zero` and continues to next line
- Variables or mixed `=` with `<`/`>` → syntax error, program exits
- Syntax errors → prints `Error: syntax error` and exits immediately
