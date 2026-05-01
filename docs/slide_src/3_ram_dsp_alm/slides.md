# Agilex hardware + optimization

![badge](../../images/agilex-product-badge-blue-3000.png)

---

## Terminology

| Term      | detail                                                     | equivalent in other FPGAs |
| --------- | ---------------------------------------------------------- | ------------------------- |
| core      | logic, RAM and DSP                                         | Logic resources, fabric   |
| periphery | IO, transceiver, PLL                                       |                           |
| ALM       | variable input LUT + registers                             | SLICE, LE, PFU            |
| ALUT      | LUT part of ALM                                            | LUT                       |
| LAB       | collection of ALMs + routing                               | CLB                       |
| M20K      | block RAM                                                  | BRAM / URAM, EBR          |
| MLAB      | small RAM made from a LAB                                  | SLICEM                    |
| DSP block | hard block for fixed/floating point/complex multiplication | DSP48                     |

---

## ALM

::: columns

::: column

- configurable LUT
  - combinations of 8 input signals to 4+4; 5+3; 5+4; 5+5; single 6 input LUT
  - 8 input LUT extended mode - not all functions are supported.  Multiplexers preferred.
  - Adder with LUT combinations above
- 4 registers
- Differences/implications from other families
  - Can pack 4-wide input functions per reg or pair of reg (Logic Element like)
  - If everything were 6-input LUT optimised, ALUT vs reg resource usage may not follow

:::

::: column

![alm](../../images/alm_pic.png)

:::

:::

::: notes

The nuances of LUT widths and equations matters for logic that you _really_ want to optimise.  If you are in this mode of working, you probably want to check at regular intervals using the technology map viewer + resource property editor that your synthesis results match your intent.

:::

---

## LAB

::: columns

::: column

- block of 10 ALMs
- LAB wide ctrl signals
  - 2x clk
  - 2x clk_ph (delayed clocks)
  - 2x clr (async)
  - 2x clkena
  - 1x synclr
- May be reconfigured as MLAB = 640b arranged as 32x20

:::

::: column

![lab](../../images/lab_pic.png)

:::

:::

---

## Routing

::: columns

::: column

- local interconnect connects to different length wires (with different delays)
- Only really a consideration for tightly packed designs
- Evaluate usage with chip planner

:::

::: column

![routing](../../images/routing_pic.png)

::: 

:::

---



## RAM Basics

- Packed vs unpacked in verilog
  - LRM describes intent, but use packed for memory word width and unpacked for addresses.  
  - If you accidentally define your RAM with packed address dimensions, you will see a large increase in reg usage
- - 
- byte enables
  - 8 wide for 16, 32 bit data width
  - 5 wide for 10 bit data width
  - 10 wide for 20, 40 bit data width
- Mixed port combinations may be realised (eg write 32 bit wide, read 8 bit wide)
- - 

---

## RAM dual port

- Dual port vs single port

  - Single port - one clock, read port and write port use the same clock.
  - Simple dual port - two clocks but still one read port, one write port.
  - True dual port - two clocks, read and write ports for each clock.
    **Agilex devices do not have native support for TDP RAMs, including them may impact your performance**
    eg for -6S speed grade; simple dual-port = 415MHz, true-dual-port = 335MHz - check [datasheet](https://docs.altera.com/r/docs/848370/current/agilextm-3-fpgas-and-socs-device-data-sheet)

- Read during write

  - MLAB = undefined

  - M20K = old data

  - Inferring new data behaviour can lead to extra bypass logic insertion

  - even with defined rdw behaviour, the `(* ramstyle = "no_rw_check" *)` attribute will remove extra passthrough logic.
    _Recommend an assertion that read during write doesn't occur if `no_rw_check` is in use_

---

## Inference recommendations

::: columns

::: column

- Right click on Quartus text editor and select Inset Template to get examples of inference patters that work

:::

::: column

![template](../../images/qedit_template.png)

:::

:::

---



