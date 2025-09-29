# Makefile for yc5508 Homework Checker

TARGET = hw-checker
FLEX = flex
BISON = bison
CC = gcc
CFLAGS = -Wall -g

LEX_FILE = yc5508.hwchecker.l
YACC_FILE = yc5508.hwchecker.y

all: $(TARGET)

$(TARGET): lex.yy.c yc5508.hwchecker.tab.c main.c
	$(CC) $(CFLAGS) lex.yy.c yc5508.hwchecker.tab.c main.c -o $(TARGET)

lex.yy.c: $(LEX_FILE)
	$(FLEX) $(LEX_FILE)

yc5508.hwchecker.tab.c: $(YACC_FILE)
	$(BISON) -d -o yc5508.hwchecker.tab.c $(YACC_FILE)

clean:
	rm -f lex.yy.c yc5508.hwchecker.tab.c yc5508.hwchecker.tab.h $(TARGET)
