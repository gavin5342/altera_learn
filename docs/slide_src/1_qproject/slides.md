# 1. Quartus Prime Pro project management

![quartus](../../assets/quartus-software-badge-blue.jpg)

---

## Agenda



Tips for project organization outside of the Quartus Prime Pro software

1. Quartus Prime Pro GUI
2. Quartus Prime Pro compilation flow
3. Source files and directives
4. Artifact organization and naming
5. Settings files and settings editors

::: notes

Quartus Prime Pro is the EDA software for targeting current Altera devices

- Arria 10
- Cyclone 10 GX
- Stratix 10
- All Agilex families

Quartus Prime Standard is used for older families including:

- Cyclone / Arria / Stratix / MAX families other than those above

This training will only cover Quartus Prime Pro software.

This training also assumes that Quartus Prime Pro software is already installed on your computer.

:::



---

## FPGA design flow

![FPGA flow](../../images/flow.png){width=30%}



::: notes

These are the high level activities in designing and deploying an FPGA.  Depending on the size of the project, you might choose to design some modules in isolation first and integrate later.

Quartus Prime Pro software provides

:::

---

## Outside Quartus Prime Pro software

- Version control ![git](https://git-scm.com/images/logos/downloads/Git-Logo-2Color.svg)
- CI/CD services (cloud or on-prem)
  - [github](https://github.com/) ![github](../../images/GitHub_Invertocat_Black.svg)
  - [gitlab ](https://gitlab.com/) ![gitlab](../../images/gitlab-logo-500-rgb.svg)
- CI/CD 
  - [jenkins](https://www.jenkins.io/) ![jenkins](https://ftp.halifax.rwth-aachen.de/jenkins/art/jenkins-logo/96x96/logo.png)
- Others
  - [FuseSoc](https://fusesoc.readthedocs.io/en/stable/index.html)

::: notes

The Software does not provide any integration with version control or CI/CD functions, though does not preclude their use.  I will cover some good ways to work to make separation of source and artifacts easier for CI/CD / .gitignore files

:::

---

## Installation

- Check [operating system and hardware requirements](https://www.altera.com/design/guidance/software/os-support)
- Download installer from [download page](https://www.altera.com/downloads/fpga-development-tools/quartus-prime-pro-edition-design-software-version-26-1-windows)
  - Version and operating system can be selcted using drop down menus: ![select](C:\Users\gavin.lofts\AppData\Roaming\Typora\typora-user-images\image-20260421125756433.png)
  - Quartus Prime Installer allow the files required to be configured prior to download and installation
- Installation
  - cmd line only available - especially suitable for headless and Dockerfile.  An example that builds a docker image is provided [here](https://github.com/gavin5342/altera_example/blob/main/questa_docker/README.md)
  - GUI shows you which components are available.  It's easy to update your installation later if you need to add families or features
    ![installer](../../images/installer_gui.png){width=40%}

---

# Exploring the software through the GUI

- Demo

::: notes

This section is intended to be live demo in the session.

Cover each part of ![window](../../images/quartus_window.png)

- toolbar
- menus
- tools -> Customize...
- right lick tools for large icons
- unpin / pin
- dock / undock
- Go through the menus
- Look in Settings and Device menus
- Add an assignment and see the effect in the tcl console

:::

---

## Comparison to other tools

#### File names

| Quartus file extension | usage                                     | other tools equivalent |
| ---------------------- | ----------------------------------------- | ---------------------- |
| .qpf                   | Project file                              | .ldf .xpr              |
| .qsf                   | Settings file                             | .lpf .xdc              |
| .qip                   | Quartus IP file - a group of source files |                        |
| .ip                    | Quartus IP file (IP-XACT)                 | .xml                   |
| .stp                   | SignalTap (logic analyser) file           | .rvl .ltx              |
| .qsys                  |                                           |                        |

### Setting names

- **Assignments -> Settings**

  **Compiler Settings -> Advanced Settings**

| Quartus setting               | usage                                | other tools equivalent |
| ----------------------------- | ------------------------------------ | ---------------------- |
| Fitter Initial Placement Seed | Affects randomized initial placement | cost table             |



---

## Scripted flow

- The GUI is good for getting started and exploring what's possible.
- It's more reliable to compile from a script for production
- Recompiling a design with unchanged sources on the same compute architecture will produce the same artifacts
  - Changing any source file will change (even non-functional changes like port list order)
  - Change Fitter Initial Placement seed to deliberately change initial placement and change artifact
  - Change in operating system (eg Windows -> Ubuntu) could change result
- **Recommendation** as your design gets ready for integration, define a CI job and use docker to ensure software versions and OS/OS settings can be used.  Altera builds docker images for the Quartus software available from [docker hub](https://hub.docker.com/u/alterafpga)
  - You may also want to build your own.  A starter guide is provided [here](https://github.com/gavin5342/altera_example/tree/main/questa_docker)

---

## Scripted flow pt 2

- Consider .qsys and .ip files source files.  The generated hdl does _not_ need to be checked in.
- `ip-generate` used to generate `.ip` files
  - Not required if Quartus compile flow is run first. Required if you want to run simulation first or in parallel with Quartus compilation
- `qsys-generate` used to generate `.qsys` files
  - Not required if Quartus compile flow is run first. Required if you want to run simulation first or in parallel with Quartus compilation
- Both hdl generation tools like to generate in-place which is awkward for version control.  My suggestion is to use a generated folder with symbolic links
- When all hdl is generated, compile using `quartus_sh --flow compile <project>`

---

## Levels of preservation

- Design Partitions allow you to freeze part of your design by the hierarchy that you define in your design entry.
- Design Partitions may be constrained to an area of the FPGA using LogicLock regions
- The Signal Tap Logic Analyzer may use Design Partitions to preserve all fitter results and then add the Signal Tap analyzer
- Design Partitions and LogicLock regions are the foundation of Partial Reconfiguration where part of a design may be reconfigured (eg change protocol for attached HSSI transceiver)
- Design partitions may be exported as `.qdb` files.  A `.qdb` can be included in a project as a source file
- Initial content of RAM may be modified without changing fitter placement and routing by using **Update Memory Initialization File** option
- 

## Programming files

The assembler produces a `.sof` (Software object file) - this file can be used with the Altera programmer to program the FPGA through the JTAG interface.

The **File -> Programming File Generator** or `quartus_pfg` can be used to make files in other formats:

- `.rbf` (raw binary file) is a flat binary file intended for use with an external master to send configuration data to the FPGA.
- `.rpd` (raw programming data) is a flat binary file used to program a QSPI flash for Active Serial configuration using an external programmer
- `.jic` (JTAG indirect configuration) is a file used with Quartus programmer to program a QSPI flash using JTAG and a JTAG-QSPI bridge in the FPGA
- `.pof` (Programmer object file) is used to program a flash when the pins are directly connected to the Altera programming file
- `.hexout`[Intel HEX](https://developer.arm.com/documentation/101655/0961/OHX51-User-s-Guide/Intel-HEX-File-Format) format text file