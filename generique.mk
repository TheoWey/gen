# https://www.youtube.com/@formation-video/playlists
# Directory control
PROJDIR := $(realpath $(CURDIR)/..)
OBJDIR   = build/obj
BUILDDIR = build
SRCDIR   = src
INCDIR   = include

# Source and header files
SRC_CC    = $(wildcard $(SRCDIR)/*.cc)
SRC_C     = $(wildcard $(SRCDIR)/*.c)
SRC       = $(SRC_CC) $(SRC_C)
HEADER_H  = $(wildcard $(INCDIR)/*.h)
HEADER_HH = $(wildcard $(INCDIR)/*.hh)
HEADER    = $(HEADER_H) $(HEADER_HH)
OBJ_CC    = $(SRC_CC:$(SRCDIR)/%.cc=$(OBJDIR)/%.o)
OBJ_C     = $(SRC_C:$(SRCDIR)/%.c=$(OBJDIR)/%.o)
OBJ       = $(OBJ_CC) $(OBJ_C)

# Compilers and flags
CXX         = g++ -Wno-unknown-pragmas
CC          = gcc -Wno-unknown-pragmas
DEBUG_FLAGS = -Wall -g -I$(INCDIR)
OPT_FLAGS1  = -Wall -O1 -I$(INCDIR)
OPT_FLAGS2  = -Wall -O2 -I$(INCDIR)
OPT_FLAGS3  = -Wall -O3 -I$(INCDIR)

TARGET = prog.exe

# Create the build directory if it doesn't exist
create_build_dir:
	@if not exist "$(BUILDDIR)" mkdir "$(BUILDDIR)"
# Create the object directory if it doesn't exist
create_obj_dir:
	@if not exist "$(OBJDIR)" mkdir "$(OBJDIR)"

# Default rule
all: FLAGS = $(OPT_FLAGS1)
all: create_build_dir create_obj_dir $(BUILDDIR)/$(TARGET)

# Debug build
debug: FLAGS = $(DEBUG_FLAGS)
debug: clean create_build_dir create_obj_dir $(BUILDDIR)/$(TARGET)

# Optimized builds
release1: FLAGS = $(OPT_FLAGS1)
release1: create_build_dir create_obj_dir $(BUILDDIR)/$(TARGET)

release2: FLAGS = $(OPT_FLAGS2)
release2: create_build_dir create_obj_dir $(BUILDDIR)/$(TARGET)

release3: FLAGS = $(OPT_FLAGS3)
release3: create_build_dir create_obj_dir $(BUILDDIR)/$(TARGET)

# Compile .cc files
$(OBJDIR)/%.o: $(SRCDIR)/%.cc $(HEADER)
	$(CXX) $(FLAGS) -o $@ -c $< 

# Compile .c files
$(OBJDIR)/%.o: $(SRCDIR)/%.c $(HEADER)
	$(CC) $(FLAGS) -o $@ -c $<

# Link the target executable
$(BUILDDIR)/$(TARGET): $(OBJ)
	$(CXX) $(FLAGS) -o $@ $^ 

# Clean rule
clean:
	@if exist "$(BUILDDIR)" (rmdir /S /Q "$(BUILDDIR)")
