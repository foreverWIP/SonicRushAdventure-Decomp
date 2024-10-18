
WSLENV ?= no
ifeq ($(WSLENV),no)
  NOWINE = 0
  # Officially-documented method of checking for MSYS2
  # https://www.msys2.org/wiki/Porting/#detecting-version-of-msys-from-gnu-make
  msys_version := $(if $(findstring Msys, $(shell uname -o)),$(word 1, $(subst ., ,$(shell uname -r))),0)
  ifneq ($msys_version,0)
    NOWINE = 1
  endif
else
  # As of build 17063, WSLENV is defined in both WSL1 and WSL2
  # so we need to use the kernel release to detect between
  # the two.
  UNAME_R := $(shell uname -r)
  ifeq ($(findstring WSL2,$(UNAME_R)),)
    NOWINE = 1
  else
    NOWINE = 0
  endif
endif

ifeq ($(OS),Windows_NT)
  EXE := .exe
  WINE :=
  GREP := grep -P
  SED := sed -r
  SHA1SUM := sha1sum
  MKTEMP := mktemp
else
  EXE :=
  WINE := wine
  UNAME_S := $(shell uname -s)
  ifeq ($(UNAME_S),Darwin)
    GREP := grep -E
    SED := gsed -r
    SHA1SUM := shasum
    MKTEMP := gmktemp
  else
    GREP := grep -P
    SED := sed -r
    SHA1SUM := sha1sum
    MKTEMP := mktemp
  endif
endif

ifeq ($(NOWINE),1)
  WINE :=
  WINPATH := wslpath
else
  WINPATH := winepath
endif
