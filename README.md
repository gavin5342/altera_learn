# Altera_learn

I have created these materials to help training on Altera® EDA software.  The material assumes some familiarity with:

- FPGA basics
- SystemVerilog

For now, all material is in SystemVerilog.

Each section is organized into presentation material for introduction and a lab.

## Prerequisites

- Quartus® Prime Pro software installed on a computer
  - [Quartus download](https://www.altera.com/products/development-tools/quartus)
  - Ubuntu 24.04 has been used for the initial release
- License for Quartus Prime Pro Software
  - A 30 day evaluation license is available from first installation of the software, as shown in the [installation and licensing guide]( https://docs.altera.com/r/docs/683472/25.3/altera-fpga-software-installation-and-licensing/evaluating-the-quartus-prime-software)
  - A 90 day evaluation license may be generated through the [self service license centre](https://www.altera.com/SSLC)

## Viewing

View the slides through [pages](https://gavin5342.github.io/altera_learn/)

## Updating

The slides are authored in markdown and exported as reveal.js.

### Windows

run:

```
build_mermaid.bat
build_slides.bat
```

Then commit all changes and push.  Github pages will automatically update from main branch.

Requires node, mermaid, pandoc.

### Linux

TBD

As mermaid is rendered first it makes sense to render your mermaid first so you can then see it inline if you're using an editor that renders your markdown for you like Typora or ghostwriter.

## Preview on local computer

```
cd <repo root>
python3 -m http.server --directory docs
```

Open browser, goto `https://localhost:8000`

## License

This repository is licensed under the MIT License.

The license applies to:

- Training slides and documentation (Markdown)

- Example HDL code and Quartus lab material

You are free to reuse, modify, and redistribute the material, including for commercial and training purposes, provided that the copyright notice and license are included.



## Disclaimer

This repository contains example material for use with Altera Quartus Prime.  Quartus and Altera are trademarks of Altera Corporation. This project is not endorsed by Altera.

See also [altera-trademarks](https://www.altera.com/privacy/altera-trademarks)