CC := gcc
ifneq ($(msys_version),0)
CFLAGS := -O3 -Wno-unused-result -D__MSYS__
else
CFLAGS := -O3 -Wno-unused-result
endif

.PHONY: all clean

all: romextract
	@:

romextract: romextract.c rom.c archiveExtract.c fileNameTable.c compression.c stringUtils.c
	$(CC) $(CFLAGS) -o $@ $^

clean:
	$(RM) romextract romextract.exe
