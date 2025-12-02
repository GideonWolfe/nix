{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  xdg.configFile.ghidra-theme = {
    enable = true;
    # THIS VALUE NEEDS TO CHANGE TO YOUR VAULT (relative to your home dir)
    #target = "test/obsidian/.obsidian/snippets/obsidian-stylix-css.css";
    target = "ghidra/stylix.theme";

    text = ''
      // General Theme Info
      name = Stylix
      lookAndFeel = Flat Dark
      useDarkDefaults = true

      // Decompiler Colors
      color.fg.decompiler.comment = ${base04}
      color.fg.decompiler.constant = ${base09}
      color.fg.decompiler.function.name = ${base0D}
      color.fg.decompiler.keyword = ${base0E}
      color.fg.decompiler.type = ${base0E}
      color.fg.decompiler.variable = ${base05}
      color.fg.decompiler.parameter = ${base08}
      color.fg.decompiler.global = ${base0A}

      // Listing Colors
      color.fg.listing.bytes = ${base0D}
      color.fg.listing.comment.auto = ${base04}
      color.fg.listing.comment.eol = ${base04}
      color.fg.listing.comment.plate = ${base04}
      color.fg.listing.comment.post = ${base04}
      color.fg.listing.comment.pre = ${base04}
      color.fg.listing.comment.ref.repeatable = ${base08}
      color.fg.listing.comment.repeatable = ${base08}
      color.fg.listing.constant = ${base09}
      color.fg.listing.ext.entrypoint = color.fg
      color.fg.listing.ext.ref.resolved = ${base0E}
      color.fg.listing.function.name = ${base0D}
      color.fg.listing.function.param.dynamic = ${base08}
      color.fg.listing.label.local = ${base0D}
      color.fg.listing.label.primary = ${base0A}
      color.fg.listing.mnemonic = ${base0E}
      color.fg.listing.mnemonic.override = color.fg
      color.fg.listing.underline = ${base08}
      color.fg.listing.xref = ${base0B}
      color.fg.listing.xref.read = ${base08}
      color.fg.listing.ext.ref.unresolved = ${base0D}
      color.fg.listing.label.non.primary = ${base05}
      color.fg.listing.register = ${base0D}
      color.fg.listing.function.variable = ${base05}
      color.fg.listing.block.start = ${base0A}
      color.fg.listing.function.tag = ${base0A}
      color.fg.listing.tabs.text.selected = ${base03}

      // Function Call Graph colors
      color.bg.plugin.functiongraph.vertex.group = ${base0E}
      color.bg.plugin.functiongraph = ${base06}
      color.bg.plugin.functiongraph.edge.jump.conditional = ${base0B}
      color.bg.plugin.functiongraph.edge.jump.highlight = ${base0A}
      color.bg.plugin.functiongraph.edge.fall.through = ${base09}
      color.bg.plugin.functiongraph.edge.fall.through.highlight = ${base08}
      color.bg.plugin.functiongraph.edge.jump.unconditional = ${base0D}
      color.bg.plugin.functiongraph.edge.jump.unconditional.highlight = ${base0C}

      // Program Graph colors
      color.bg.plugin.programgraph.edge.entry = ${base03}
      color.bg.plugin.programgraph.edge.fall.through = ${base0D}
      color.bg.plugin.programgraph.edge.jump.unconditional = ${base0B}
      color.bg.plugin.programgraph.edge.call.unconditional = ${base09}
      color.bg.plugin.programgraph.edge.terminator = ${base0E}
      color.bg.plugin.programgraph.edge.jump.terminator = ${base0E}
      color.bg.plugin.programgraph.edge.indirection = ${base07}
      color.bg.plugin.programgraph.edge.jump.conditional = ${base0A}
      color.bg.plugin.programgraph.edge.jump.conditional = ${base08}
      color.bg.plugin.programgraph.edge.call.conditional = ${base09}
      color.bg.plugin.programgraph.edge.conditional.terminator = ${base0E}
      color.bg.plugin.programgraph.edge.call.conditional.terminator = ${base0E}
      color.bg.plugin.programgraph.edge.jump.computed = ${base0C}
      color.bg.plugin.programgraph.edge.call.computed = ${base0C}
      color.bg.plugin.programgraph.edge.call.computed.terminator = ${base0E}
      color.bg.plugin.programgraph.edge.call.conditional.computed = ${base0E}
      color.bg.plugin.programgraph.edge.jump.conditional.computed = ${base0E}
      color.bg.plugin.programgraph.edge.jump.callother.override = ${base08}
      color.bg.plugin.programgraph.edge.read = ${base0B}
      color.bg.plugin.programgraph.edge.write = ${base08}
      color.bg.plugin.programgraph.edge.read.write = ${base0A}
      color.bg.plugin.programgraph.edge.data.unknown = ${base04}
      color.bg.plugin.programgraph.edge.external.ref = ${base0E}
      color.bg.plugin.programgraph.edge.read.indirect = ${base0B}
      color.bg.plugin.programgraph.edge.write.indirect = ${base0F}
      color.bg.plugin.programgraph.edge.read.write.indirect = ${base07}
      color.bg.plugin.programgraph.edge.data.indirect = ${base09}
      color.bg.plugin.programgraph.edge.param = ${base0C}
      color.bg.plugin.programgraph.edge.thunk = ${base0D}
      color.bg.plugin.programgraph.edge.default = ${base08}
      color.bg.plugin.programgraph.vertex.default = ${base08}
      color.bg.plugin.programgraph.vertex.body = ${base0D}
      color.bg.plugin.programgraph.vertex.entry = ${base09}
      color.bg.plugin.programgraph.vertex.exit = ${base0E}
      color.bg.plugin.programgraph.vertex.switch = ${base0F}
      color.bg.plugin.programgraph.vertex.external = ${base0B}
      color.bg.plugin.programgraph.vertex.bad = ${base08}
      color.bg.plugin.programgraph.vertex.instruction = ${base0C}
      color.bg.plugin.programgraph.vertex.data = ${base0F}
      color.bg.plugin.programgraph.vertex.entry.nexus = ${base0A}
      color.bg.plugin.programgraph.vertex.entry.stack = ${base0B}

      color.bg.selection = ${base02}
      color.bg.undefined = ${base02}
      color.bg.highlight = ${base0E}
      color.bg.header.active = ${base0E}
      color.fg.header.active = ${base01}
      color.bg.header.inactive = ${base02}

      color.palette.highlight.transparent.yellow = ${base03}

      color.bg.filterfield = ${base02}
      color.fg.filterfield = ${base05}

      color.fg.interpreterconsole.error = ${base08}
      color.fg.consoletextpane = ${base05}

      color.fg.listing.flow.arrow.selected = ${base0A}
      color.fg.listing.flow.arrow.active = ${base0B}
      color.fg.listing.flow.arrow.inactive = ${base08}

      color.bg = [color]system.color.bg.view

      color.bg.plugin.overview.address.function = ${base0E}
      color.bg.plugin.overview.address.instruction = ${base0D}
      color.bg.plugin.overview.address.data = ${base0A}
      color.bg.plugin.overview.address.undefined = ${base08}
      color.bg.plugin.overview.address.uninitialized = ${base05}
      color.bg.plugin.overview.address.external.ref = ${base09}

      color.bg.plugin.bookmark.note = ${base0E}
      color.bg.plugin.bookmark.default = ${base0B}
      color.bg.plugin.bookmark.info = ${base0A}
      color.bg.plugin.bookmark.warning = ${base09}
      color.bg.plugin.bookmark.analysis = ${base0D}
      color.bg.plugin.bookmark.error = ${base08}

      color.bg.listing.highlighter.default = ${base03}
      color.bg.listing.highlighter.scoped.read = ${base0E}
      color.bg.listing.highlighter.scoped.write = ${base0B}

      [color]system.color.bg.view = ${base00}
      [color]system.color.fg.view = ${base05}
      [color]system.color.bg.border = ${base01}
      [color]system.color.bg.control = ${base00}
      [color]system.color.bg.tooltip = ${base01}
      [color]system.color.bg.selected.view = ${base02}
      [color]system.color.fg.control = ${base05}
      [color]system.color.fg.disabled = ${base02}
      [color]system.color.fg.selected.view = ${base05}
      [color]system.color.fg.tooltip = ${base05}


      [color]laf.palette.color.04 = ${base0E}        // Primary button bg
      [color]laf.palette.color.08 = ${base0F}         // Primary button hover bg
      [color]laf.palette.color.09 = ${base0F}     // Primary button click bg
      [color]laf.palette.color.10 = ${base01}       // Secondary button hover bg
      [color]laf.palette.color.14 = ${base01}        // Secondary button click bg
      [color]laf.palette.color.16 = ${base01}        // Tab bar edge
      [color]laf.palette.color.31 = ${base04}     // Menubar shortcut keys fg
      [color]laf.palette.color.33 = ${base04}     // Dropdown select arrow
      [color]laf.palette.color.59 = ${base03}     // File menu selection inactive bg
      [color]laf.palette.color.60 = ${base04}     // Toolbar border
      [color]laf.palette.color.61 = ${base02}     // Menubar item hover bg
      [color]laf.palette.color.86 = ${base0E}        // Selected tab accent
      [color]laf.palette.color.71 = ${base0E}
      [color]laf.palette.color.72 = ${base03}
      [color]laf.palette.color.73 = ${base03}
      [color]laf.palette.color.69 = ${base0E}
      [color]laf.palette.color.62 = ${base03}
      [color]laf.palette.color.63 = ${base0E}
      [color]laf.palette.color.32 = ${base00}         // Menubar bg color
      [color]laf.palette.color.20 = ${base02}
      [color]laf.palette.color.82 = ${base02}     // Resize border indicator
      [color]laf.palette.color.85 = ${base00}         // Tab selected bg

      [color]laf.color.TextArea.caretForeground = [color]${base06}
      [color]laf.color.TextField.caretForeground = [color]${base06}
      [color]laf.color.Button.default.foreground = [color]${base00}
      [color]laf.color.ProgressBar.background = [color]${base01}
      [color]laf.color.ProgressBar.foreground = [color]${base0E}
      [color]laf.color.ProgressBar.selectionBackground = [color]${base00}
      [color]laf.color.ProgressBar.selectionForeground = [color]${base00}
    '';

  };
}
