# -- BEGIN MAKEFILE --

CBIN    := c:/sw/pdl/c/bin
DIST    := dist
RELEASE := release
EXE     := bspi.exe
TARGET  := $(DIST)/$(EXE)

clean:
	@if exist "$(DIST)\*" del /Q /F "$(DIST)\*" 2>NUL
	@if exist "$(RELEASE)\*" del /Q /F "$(RELEASE)\*" 2>NUL

all: exe

exe: prepdirs
	wxpar -o "$(TARGET)" "C:/Users/user/Documents/wxPerl/wx-examples/bspi/bspi.pl" --gui

prepdirs:
	@if not exist "$(DIST)" mkdir "$(DIST)"
	@if not exist "$(RELEASE)" mkdir "$(RELEASE)"
# -- END MAKEFILE --

