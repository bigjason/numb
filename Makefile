CFLAGS=-g -O2 -Wall -Wextra -Isrc -DNDEBUG $(OPTFLAGS)
LIBS=-ldl $(OPTLIBS)
PREFIX?=/usr/local

SOURCES=$(wildcard src/**/*.c src/*.c)
OBJECTS=$(patsubst %.c,%.o,$(SOURCES))

TEST_SRC=$(wildcard tests/*_tests.c)
TESTS=$(patsubst %.c,%,$(TEST_SRC))

TARGET=build/numb.a
EXE_TARGET=$(patsubst %.a,%,$(TARGET))

# The Target Build
all: $(TARGET) $(EXE_TARGET)

dev: CFLAGS=-g -Wall -Isrc -Wall -Wextra $(OPTFLAGS)
dev: all

$(TARGET): CFLAGS += -fPIC
$(TARGET): build $(OBJECTS)
	ar rcs $@ $(OBJECTS)
	ranlib $@

$(EXE_TARGET): $(TARGET) $(OBJECTS)
	$(CC) -o $(EXE_TARGET) $(OBJECTS)

build:
	@mkdir -p build
	@mkdir -p bin

# The Cleaner
clean:
	rm -rf build $(OBJECTS)
	rm -f tests/tests.log
	find . -name "*.gc*" -exec rm {} \;
	rm -rf `find . -name "*.dSYM" -print`
