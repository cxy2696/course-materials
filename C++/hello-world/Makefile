CXX ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra -Wpedantic
BUILD_DIR ?= build
TARGET := $(BUILD_DIR)/hello-world

.PHONY: all run clean

all: $(TARGET)

$(TARGET): main.cpp
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) main.cpp -o $@

run: $(TARGET)
	./$(TARGET)

clean:
	rm -rf $(BUILD_DIR)
