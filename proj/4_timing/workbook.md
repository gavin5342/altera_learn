# Timing Analysis exercises

These exercises assume some familiarity with SDC constraints.

Further basic information on IO timing constraints can be found at the [Timing Analyzer Cookbook](https://docs.altera.com/r/docs/683081/22.2/quartus-prime-timing-analyzer-cookbook/quartus-prime-timing-analyzer-cookbook)

## Added hold timing

There are often times where the Quartus software has made decisions to meet timing according to your constraints and design, but one or both are not optimal

- Open [hold_ex1](./hold_ex1)

- Run full compilation

- Review Timing Analyzer report **Compilation Report -> Timing Analyzer**

  - Confirm no violations

- Review **Fitter -> Route Stage -> Estimated Delay** report

  - identify paths that have added delay

- Analyse these paths in Timing Analyzer

  - Open Timing Analyzer ![icon](../../docs/images/timing_analyzer_icon.png)

  - Report timing on path identified above using **Report Timing...** Task

    - click **Show Routing** checkbox

    - Change **Report panel name** to something meaningful to you

    - Set Analysis type to **Hold**

    - Set **Targets -> To** to path of interest ie `[get_keepers out_ex1*]`

    - Press **OK**

    - Note command in tcl window: `report_timing -to [get_keepers out_ex1*] -hold -npaths 10 -extra_info none -detail full_path -show_routing -panel_name {Hold timing lab}`

    - Go to statistics tab, notice the smoking gun

      - clock skew
      - data delay

    - Cause and effect: Clock Skew -> Data Delay

    - Right click path in **Summary of Paths**
      ![path](../../docs/images/timing_summary_of_paths.png)

    - **Locate Path -> Chip Planner**

    - Double click the path in **Locate History**

      ![locate path](../../docs/images/locate_path.png)

    - Press the Expand Connections button: ![icon](../../docs/images/expand_con.png)

      - Get a feel for what 3ns looks like

    - Unfold the path in Locate History and right click on each segment to enable **Show Physical Routing**
      ![show physical routing](../../docs/images/show_phys_routing.png)

- Return to Quartus Prime Pro window

- Navigate to Files Tab in Project Navigator
  ![navigator](../../docs/images/project_nav.png)

- Double click **the_pll.ip**
  - The **IP Parameter Editor opens**
  - Scroll down to **Compensation**
  - Change mode from **direct ** to **normal**
- Click **Generate HDL**
- Press **Generate**
- Run full compilation flow in Quartus Prime Pro Window.