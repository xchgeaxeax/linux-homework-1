# 编译参数
CC := gcc
CFLAGS := -Wall -Wextra

# 目录路径
SRC_DIR := src
INC_DIR := include
LIB_DIR := lib
OBJ_DIR := $(LIB_DIR)/obj

# 文件列表
SRC_FILES := $(wildcard $(SRC_DIR)/*.c)
OBJ_FILES := $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRC_FILES))
LIB_FILE := $(LIB_DIR)/libcal.a
EXECUTABLE := main

# 默认目标
all: $(EXECUTABLE)

# 构建目标文件
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c -I$(INC_DIR) $< -o $@

# 生成静态库
$(LIB_FILE): $(OBJ_FILES)
	ar rcs $@ $^

# 编译可执行程序
$(EXECUTABLE): $(LIB_FILE)
	$(CC) $(CFLAGS) -L$(LIB_DIR) -lcal -o $@

# 清理中间文件和可执行文件
clean:
	rm -f $(OBJ_DIR)/*.o $(EXECUTABLE) $(LIB_FILE)

# 提交到远程仓库
git:
	git add .
	git commit -m "Initial commit"
	git push origin master

.PHONY: all clean git
