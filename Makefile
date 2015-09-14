example1 = chart1.svg example1/index.html example1/run.sh example1/screenshot-alert.png
example2 = chart2.svg example2/fizzbuzzer.py example2/index.html example2/run.sh example2/screenshot-fizzbuzz.png example2/screenshot-fizzbuzz-2.png
example2 = chart3.svg example3/client.svg example3/index.html example3/never-mind.svg example3/run.sh example3/screenshot-chat.png example3/server.svg

slides.pdf: slides.lyx recipe.svg party-like-its-1999.png $(example1) $(example2) $(example3)
	lyx -e pdf4 slides.lyx # Export to PDF using XeTeX.
clean:
	rm slides.pdf
.POSIX:
.PHONY: clean .POSIX
