slides.pdf: slides.lyx
	lyx -e pdf4 slides.lyx # Export to PDF using XeTeX.
clean:
	rm slides.pdf
.POSIX:
.PHONY: clean .POSIX
