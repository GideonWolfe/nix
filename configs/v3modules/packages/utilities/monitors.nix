{ config, lib, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [

    # Monitors
    atop # system/process monitor
    btop
    htop # system/process monitor
    gotop # system/process monitor
    iotop # IO monitor
    ioping # IO latency monitor
    dnstop # DNS traffic monitor
    bandwhich # bandwidth monitor
    jnettop
    netscanner # network scanner
    wavemon # network monitor
    flent # Advanced network tester CLI and GUI
    netperf # util to measure network performance (required by flent)
    http-getter # (required by flent)
    trippy
    ktop # kubernetes monitor
    kernelshark # GUI kernel monitor
    sysdig # advanced system tracing tool
    kmon # TUI kernel monitor
    glances # system/process monitor
    bmon # bandwidth monitor
    nload # network load monitor
    oha # HTTP monitor/tester
    nmon # system monitor
    powertop # power analyzer (intel laptops)
    lm_sensors # hardware sensors
    hddtemp # display hard disk temps
    pkgtop # TUI package monitor
    cpupower-gui # GUI for tweaking CPU
    hardinfo2 # GUI for devices/hardware
    hwinfo # get info about hardware
    resources # hardware monitoring GUI
    zenith # another TUI system monitor

    libgtop # library for system monitoring (used by hyprpanel)

  ];
}
