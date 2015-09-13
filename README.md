# "Server-Side Secret Sauce"

[Slides](slides.pdf) [and](example1) [example](example2) [code](example3) for an upcoming talk by [Danyil Bohdan](https://github.com/dbohdan).

Made using [LyX](http://www.lyx.org/), [Beamer](https://en.wikipedia.org/wiki/Beamer_%28LaTeX%29) and the [Metro](https://bitbucket.org/marczellm/beamerports) Beamer theme.

# Examples

To run the examples you will need [websocketd](http://websocketd.com/) (binaries for 64-bit Linux and OS X are included in the repository), [netcat](https://en.wikipedia.org/wiki/Netcat), [Python](https://www.python.org/) 3.2 or later and [Tcl](https://en.wikipedia.org/wiki/Tcl) 8.5 or later.

To run an example on Linux open your terminal, `cd` to that example's directory then start `run.sh`. If you are on OS X rather than Linux do the following before running any examples:

```sh
rm websocketd
ln -s websocketd-0.2.11-darwin_amd64 websocketd
```

# Building the slides PDF file

The packages installed by the `dnf install` command below should suffice to compile the presentation on [Fedora](https://en.wikipedia.org/wiki/Fedora_%28operating_system%29) version 22.

```sh
su -
dnf install lyx pgfopts texlive-euenc.noarch texlive-ifxetex texlive-pgfopts.noarch texlive-pgfplots texlive-xetex.noarch texlive-xetex-def.noarch
make # Build slides.pdf.
```

# License

Copyright (C) 2015 Danyil Bohdan. License: [Creative Commons Attribution-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-sa/4.0).

[![CC BY-SA 4.0](https://licensebuttons.net/l/by-sa/3.0/88x31.png)](https://creativecommons.org/licenses/by-sa/4.0)

The Metro theme for Beamer (`beamerthemeMetro.sty`) was created by Márton Marczell and is distributed under the [Creative Commons Attribution-ShareAlike 3.0 Unported License](https://creativecommons.org/licenses/by-sa/3.0/). [License information](https://bitbucket.org/marczellm/beamerports/src/62840a66640d6b38da8618a71c591b1ea769a345/license_information.md?at=master&fileviewer=file-view-default).

The [Web browser window](https://openclipart.org/detail/212730/web-browser) graphic by qubodup is [in the public domain](https://openclipart.org/share).
