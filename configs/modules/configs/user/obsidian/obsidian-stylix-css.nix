{ pkgs, lib, config, ... }:

with config.lib.stylix.colors;

{
  home.file.obsidian-stylix-css = {
    enable = true;
    # THIS VALUE NEEDS TO CHANGE TO YOUR VAULT (relative to your home dir)
#target = "test/obsidian/.obsidian/snippets/obsidian-stylix-css.css";
    target = "notes/gideon/.obsidian/snippets/obsidian-stylix-css.css";

    text = ''
        :root {
            --dark0-hard_x:     ${base01-rgb-r},${base01-rgb-g},${base01-rgb-b}; 
            --dark0-hard:       rgb(var(--dark0-hard_x));
            --dark0_x:          ${base01-rgb-r},${base01-rgb-g},${base01-rgb-b}; 
            --dark0:            rgb(var(--dark0_x));
            --dark0-soft_x:     ${base00-rgb-r},${base00-rgb-g},${base00-rgb-b}; 
            --dark0-soft:       rgb(var(--dark0-soft_x));
            --dark1_x:          ${base01-rgb-r},${base01-rgb-g},${base01-rgb-b}; 
            --dark1:            rgb(var(--dark1_x));
            --dark2_x:          ${base02-rgb-r},${base02-rgb-g},${base02-rgb-b}; 
            --dark2:            rgb(var(--dark2_x));
            --dark3_x:          ${base03-rgb-r},${base03-rgb-g},${base03-rgb-b}; 
            --dark3:            rgb(var(--dark3_x));
            --dark4_x:          ${base03-rgb-r},${base03-rgb-g},${base03-rgb-b}; 
            --dark4:            rgb(var(--dark4_x));
            --gray_x:           ${base04-rgb-r},${base04-rgb-g},${base04-rgb-b}; 
            --gray:             rgb(var(--gray_x));

            --light0-hard_x:    ${base05-rgb-r},${base05-rgb-g},${base05-rgb-b}; 
            --light0-hard:      rgb(var(--light0-hard_x));
            --light0_x:         ${base05-rgb-r},${base05-rgb-g},${base05-rgb-b}; 
            --light0:           rgb(var(--light0_x));
            --light0-soft_x:    ${base04-rgb-r},${base04-rgb-g},${base04-rgb-b}; 
            --light0-soft:      rgb(var(--light0-soft_x));
            --light1_x:         ${base03-rgb-r},${base03-rgb-g},${base03-rgb-b}; 
            --light1:           rgb(var(--light1_x));
            --light2_x:         ${base04-rgb-r},${base04-rgb-g},${base04-rgb-b}; 
            --light2:           rgb(var(--light2_x));
            --light3_x:         ${base05-rgb-r},${base05-rgb-g},${base05-rgb-b}; 
            --light3:           rgb(var(--light3_x));
            --light4_x:         ${base06-rgb-r},${base06-rgb-g},${base06-rgb-b}; 
            --light4:           rgb(var(--light4_x));

            --bright-red_x:     ${base08-rgb-r},${base08-rgb-g},${base08-rgb-b}; 
            --bright-red:       rgb(var(--bright-red_x));
            --bright-green_x:   ${base0B-rgb-r},${base0B-rgb-g},${base0B-rgb-b}; 
            --bright-green:     rgb(var(--bright-green_x));
            --bright-yellow_x:  ${base0A-rgb-r},${base0A-rgb-g},${base0A-rgb-b}; 
            --bright-yellow:    rgb(var(--bright-yellow_x));
            --bright-blue_x:    ${base0D-rgb-r},${base0D-rgb-g},${base0D-rgb-b}; 
            --bright-blue:      rgb(var(--bright-blue_x));
            --bright-purple_x:  ${base0E-rgb-r},${base0E-rgb-g},${base0E-rgb-b}; 
            --bright-purple:    rgb(var(--bright-purple_x));
            --bright-pink_x:    ${base0F-rgb-r},${base0F-rgb-g},${base0F-rgb-b}; 
            --bright-pink:      rgb(var(--bright-pink_x));
            --bright-aqua_x:    ${base0C-rgb-r},${base0C-rgb-g},${base0C-rgb-b}; 
            --bright-aqua:      rgb(var(--bright-aqua_x));
            --bright-orange_x:  ${base09-rgb-r},${base09-rgb-g},${base09-rgb-b}; 
            --bright-orange:    rgb(var(--bright-orange_x));

            --neutral-red_x:    ${base08-rgb-r},${base08-rgb-g},${base08-rgb-b}; 
            --neutral-red:      rgb(var(--neutral-red_x));
            --neutral-green_x:  ${base0B-rgb-r},${base0B-rgb-g},${base0B-rgb-b}; 
            --neutral-green:    rgb(var(--neutral-green_x));
            --neutral-yellow_x: ${base0A-rgb-r},${base0A-rgb-g},${base0A-rgb-b}; 
            --neutral-yellow:   rgb(var(--neutral-yellow_x));
            --neutral-blue_x:   ${base0D-rgb-r},${base0D-rgb-g},${base0D-rgb-b}; 
            --neutral-blue:     rgb(var(--neutral-blue_x));
            --neutral-purple_x: ${base0E-rgb-r},${base0E-rgb-g},${base0E-rgb-b}; 
            --neutral-purple:   rgb(var(--neutral-purple_x));
            --neutral-pink_x:   ${base0F-rgb-r},${base0F-rgb-g},${base0F-rgb-b}; 
            --neutral-pink:     rgb(var(--neutral-pink_x));
            --neutral-aqua_x:   ${base0C-rgb-r},${base0C-rgb-g},${base0C-rgb-b}; 
            --neutral-aqua:     rgb(var(--neutral-aqua_x));
            --neutral-orange_x: ${base09-rgb-r},${base09-rgb-g},${base09-rgb-b}; 
            --neutral-orange:   rgb(var(--neutral-orange_x));

            --faded-red_x:      ${base08-rgb-r},${base08-rgb-g},${base08-rgb-b}; 
            --faded-red:        rgb(var(--faded-red_x));
            --faded-green_x:    ${base0B-rgb-r},${base0B-rgb-g},${base0B-rgb-b}; 
            --faded-green:      rgb(var(--faded-green_x));
            --faded-yellow_x:   ${base0A-rgb-r},${base0A-rgb-g},${base0A-rgb-b}; 
            --faded-yellow:     rgb(var(--faded-yellow_x));
            --faded-blue_x:     ${base0D-rgb-r},${base0D-rgb-g},${base0D-rgb-b}; 
            --faded-blue:       rgb(var(--faded-blue_x));
            --faded-purple_x:   ${base0E-rgb-r},${base0E-rgb-g},${base0E-rgb-b}; 
            --faded-purple:     rgb(var(--faded-purple_x));
            --faded-pink_x:     ${base0F-rgb-r},${base0F-rgb-g},${base0F-rgb-b}; 
            --faded-pink:       rgb(var(--faded-pink_x));
            --faded-aqua_x:     ${base0C-rgb-r},${base0C-rgb-g},${base0C-rgb-b}; 
            --faded-aqua:       rgb(var(--faded-aqua_x));
            --faded-orange_x:   ${base09-rgb-r},${base09-rgb-g},${base09-rgb-b}; 
            --faded-orange:     rgb(var(--faded-orange_x));
        }

        body {
            --link-decoration:                underline;
            --link-decoration-hover:          underline;
            --link-external-decoration:       none;
            --link-external-decoration-hover: underline;

            --tag-decoration:                 none;
            --tag-decoration-hover:           underline;
            --tag-padding-x:                  .5em;
            --tag-padding-y:                  .2em;
            --tag-radius:                     .5em;

            --tab-font-weight:                600;
            --bold-weight:                    600;

            --checkbox-radius:                4px;

            --embed-border-left: 3px solid var(--interactive-accent);

        }

        .theme-dark
        {
            --color-red-rgb:                 var(--neutral-red_x);
            --color-red:                     var(--neutral-red);
            --color-purple-rgb:              var(--neutral-purple_x);
            --color-purple:                  var(--neutral-purple);
            --color-green-rgb:               var(--neutral-green_x);
            --color-green:                   var(--neutral-green);
            --color-cyan-rgb:                var(--neutral-aqua_x);
            --color-cyan:                    var(--neutral-aqua);
            --color-blue-rgb:                var(--faded-blue_x);
            --color-blue:                    var(--faded-blue);
            --color-yellow-rgb:              var(--neutral-yellow_x);
            --color-yellow:                  var(--neutral-yellow);
            --color-orange-rgb:              var(--neutral-orange_x);
            --color-orange:                  var(--neutral-orange);
            --color-pink-rgb:                var(--bright-pink_x);
            --color-pink:                    var(--bright-pink);
            --color-accent:                  var(--neutral-purple);

            --background-primary:            var(--dark0);
            --background-primary-alt:        var(--dark0);
            --background-secondary:          var(--dark0-hard);
            --background-secondary-alt:      var(--dark1);
            --background-modifier-border:    var(--dark2);
            --background-modifier-border-hover:    var(--neutral-blue);
            --background-modifier-border-focus:    var(--neutral-blue);

            /* tooltip background */
            --background-modifier-message:   var(--dark0) !important;

            /* text input backgrounds */
            --background-modifier-form-field: var(--dark0) !important;


            --cursor-line-background:        rgba(var(--dark1_x), 0.5);

            --text-normal:                   var(--light0);
            --text-faint:                    var(--light1);
            --text-muted:                    var(--light2);
            --text-on-accent:                var(--dark0);

            --link-url:                      var(--neutral-green);

            --h1-color:                      var(--neutral-red);
            --h2-color:                      var(--neutral-yellow);
            --h3-color:                      var(--neutral-green);
            --h4-color:                      var(--neutral-aqua);
            --h5-color:                      var(--neutral-blue);
            --h6-color:                      var(--neutral-purple);

            --hr-color:                      var(--neutral-orange);

            --text-highlight-bg:             var(--neutral-yellow);
            --text-highlight-fg:             var(--dark0-hard);

            --text-accent:                   var(--neutral-orange);
            --text-accent-hover:             var(--bright-aqua);

            --tag-color:                     var(--bright-aqua);
            --tag-background:                var(--dark2);
            --tag-background-hover:          var(--dark1);

            --titlebar-text-color-focused:   var(--bright-red);

            --inline-title-color:            var(--bright-yellow);

            --bold-color:                    var(--neutral-yellow);
            --italic-color:                  var(--neutral-yellow);

            --checkbox-color:                var(--neutral-green);
            --checkbox-color-hover:          var(--neutral-yellow);
            --checkbox-border-color:         var(--light4);
            --checkbox-border-color-hover:   var(--light4);
            --checklist-done-color:          rgba(var(--neutral-green), 0.5);

            --table-header-background:       rgba(var(--dark0_x), 0.2);
            --table-header-background-hover: var(--dark2);
            --table-row-even-background:     rgba(var(--dark2_x), 0.2);
            --table-row-odd-background:      rgba(var(--dark2_x), 0.4);
            --table-row-background-hover:    var(--dark2);

            --text-selection:                rgba(var(--neutral-blue_x), 0.6);
            --flashing-background:           rgba(var(--neutral-red_x), 0.3);

            --code-normal:                   var(--bright-blue);
            --code-background:               var(--dark1);

            --interactive-normal:            var(--neutral-blue);
            --interactive-accent:            var(--neutral-purple);
            --interactive-hover:             var(--neutral-green);

            --mermaid-note:                  var(--neutral-blue);
            --mermaid-actor:                 var(--dark2);
            --mermaid-loopline:              var(--neutral-blue);
            --mermaid-exclude:               var(--dark4);
            --mermaid-seqnum:                var(--dark0);

            --icon-color:                    var(--bright-green);
            --icon-color-hover:              var(--bright-red);
            --icon-color-focused:            var(--bright-blue);

            --nav-item-color:                var(--light0);
            --nav-item-color-hover:          var(--bright-red);
            --nav-item-color-active:         var(--bright-aqua);
            --nav-file-tag:                  rgba(var(--neutral-yellow_x), 0.9);

            --graph-line:                    var(--light2);
            --graph-node:                    var(--light3);
            --graph-node-tag:                var(--neutral-red);
            --graph-node-attachment:         var(--neutral-green);

            --calendar-hover:                var(--bright-red);
            --calendar-background-hover:     var(--dark1);
            --calendar-week:                 var(--neutral-orange);
            --calendar-today:                var(--neutral-orange);

            --dataview-key:                  var(--text-faint);
            --dataview-key-background:       rgba(var(--faded-red_x), 0.5);
            --dataview-value:                var(--text-faint);
            --dataview-value-background:     rgba(var(--neutral-green_x), 0.3);

            --tab-text-color-focused-active:         var(--neutral-yellow);
            --tab-text-color-focused-active-current: var(--bright-red);

            --divider-color: var(--neutral-blue);
            --divider-color-hover: var(--neutral-purple);

            --dropdown-background: var(--neutral-orange);
            --dropdown-background-hover: var(--neutral-yellow);
           
            --slider-thumb-border-color: var(--neutral-green);
            --slider-track-background: var(--neutral-green);

            --scrollbar-bg: transparent;
            --scrollbar-thumb-bg: var(--neutral-green);
            --scrollbar-active-thumb-bg: var(--neutral-blue);

            /* TESTING */
            --mer-text: #${base05};
            --mer-rect-1: #${base01};
            --mer-rect-base: #${base00};
            --mer-rect-2: #${blue};
            --mer-poly-1: #${base00};
            --mer-poly-start: #${blue};
            --mer-poly-end: #${red};
            --mer-circle-1: #${base00};
            --mer-clust-rect: #${base00};
            --mer-rect-entity: #${base07};
            --mer-clust-rect-2: #${base01};
            --mer-req-box: #${base00};
            --mer-labl-box: #${base07};
            --mer-stat-rect: #${yellow};
            --mer-rect-note: #${base00};
            --mer-attr-bx-o: #${base07};
            --mer-attr-bx-e: #${base06};

            --mer-node-pt: #${base00};
            --mer-fork-jn: #${blue};
            --mer-node-lbl: #${base00};

            --mer-rel-box: #${orange};
            --label-bg-col: #${blue};
            --mer-task-text: #${red};
            --mer-task-text2: #${base01};
            --mer-label-txt: #${base00};
            --mer-excl-range: #${base04};
            --mer-legd-txt: #${base05};
            --mer-loop-txt: #${orange};
            --mer-req-title: #${base05};
            --mer-mer-div: #${base05};
            --mer-actor0: #${red};
            /* TESTING */

        }

        table
        {
            border: 1px solid var(--neutral-orange) !important;
            border-collapse: collapse;
        }

        thead
        {
            border-bottom: 2px solid var(--background-modifier-border) !important;
        }
          
        th
        {
            font-weight: 600 !important;
            border: 1px solid var(--background-secondary) !important;
        }

        td
        {
            border-left: 1px solid var(--background-secondary) !important;
            border-right: 1px solid var(--background-secondary) !important;
            border-bottom: 1px solid var(--background-secondary) !important;
        }

        .markdown-rendered tbody tr:nth-child(even)
        {
            background-color: var(--table-row-even-background) !important;
        }

        .markdown-rendered tbody tr:nth-child(odd)
        {
            background-color: var(--table-row-odd-background) !important;
        }

        .markdown-rendered tbody tr:nth-child(even):hover,
        .markdown-rendered tbody tr:nth-child(odd):hover
        {
            background-color: var(--table-row-background-hover) !important;
        }

        .markdown-rendered mark
        {
            background-color: var(--text-highlight-bg);
            color: var(--text-highlight-fg);
        }

        .markdown-rendered mark a
        {
            color: var(--red) !important;
            font-weight: 600;
        }

        .search-result-file-matched-text
        {
            color: var(--text-highlight-fg) !important;
        }

        .cm-hashtag-begin:hover, .cm-hashtag-end:hover
        {
            color: var(--text-accent);
            /* background-color: var(--tag-background-hover); */
            text-decoration: underline;
        }

        input[type=checkbox]
        {
            border: 1px solid var(--checkbox-color);
        }

        input[type=checkbox]:checked
        {
            background-color: var(--checkbox-color);
            box-shadow: inset 0 0 0 2px var(--background-primary);
        }

        input[type=checkbox]:checked:after
        {
            display: none;
        }

        code[class*="language-"],
        pre[class*="language-"]
        {
            line-height: var(--line-height-tight) !important;
        }

        .cm-url
        {
            color: var(--link-url) !important;
        }

        .cm-url:hover
        {
            color: var(--text-accent-color) !important;
        }

        /* Keep highlight/marks the same between viewer and editor. */
        .cm-highlight
        {
            color: var(--text-highlight-fg) !important;
        }

        /* Keep inline code the same between viewer and editor. */
        .cm-inline-code
        {
            border-radius: var(--radius-s);
            font-size: var(--code-size);
            padding: 0.1em 0.25em;
        }

        .cm-line .cm-strong
        {
            color: var(--bold-color) !important;
        }

        /*
         * Keep list bullet padding the same between viewer and editor.
         * This is annoying with the cursor in the editor as there is a gap.
         */
        /*
        .cm-formatting-list
        {
            padding-right: 4px !important;
        }
        */

        /*
         * Keep sub-list indenting the same between viewer and editor.
         * This assumes --list-indent is default at 2em.
         */
        /*
        .cm-indent 
        {
            text-indent: 1em !important;
        }
        */


        .calendar .week-num
        {
            color: var(--calendar-week) !important;
        }

        .calendar .today
        {
            color: var(--calendar-today) !important;
        }

        .calendar .week-num:hover,
        .calendar .day:hover
        {
            color: var(--calendar-hover) !important;
            background-color: var(--calendar-background-hover) !important;
        }

        .markdown-embed-title
        {
            color: var(--yellow);
            font-weight: 600 !important;
        }

        .cm-active
        {
            background-color: var(--cursor-line-background) !important;
        }

        .nav-file-tag
        {
            color: var(--nav-file-tag) !important;
        }

        .is-flashing
        {
            background-color: var(--flashing-background) !important;
        }

        .dataview.inline-field-key
        {
            border-top-left-radius: var(--radius-s);
            border-bottom-left-radius: var(--radius-s);
            padding-left: 4px;
            font-family: var(--font-monospace);
            font-size: var(--font-smaller);
            color: var(--dataview-key) !important;
            background-color: var(--dataview-key-background) !important;
        }

        .dataview.inline-field-value
        {
            border-top-right-radius: var(--radius-s);
            border-bottom-right-radius: var(--radius-s);
            padding-right: 4px;
            font-family: var(--font-monospace);
            font-size: var(--font-smaller);
            color: var(--dataview-value) !important;
            background-color: var(--dataview-value-background) !important;
        }

        .suggestion-highlight
        {
            color: var(--bright-red);
        }

        .tooltip
        {
            border: 1px solid var(--neutral-orange) !important;
            color: var(--text-normal) !important;
        }
        .tooltip .tooltip-arrow {
          border-bottom: 1px solid var(--neutral-orange) !important;
        }
        .tooltip.mod-right .tooltip-arrow {
          border-right: 1px solid var(--neutral-orange) !important;
        }
        .tooltip.mod-left .tooltip-arrow {
          border-left: 1px solid var(--neutral-orange) !important;
        }
        .tooltip.mod-top .tooltip-arrow {
          border-top: 1px solid var(--neutral-orange) !important;
        }


        body {
            --callout-border-width: 1px;
            --callout-border-opacity: 0.4;
            /* Order as defined in app.css */
            --callout-default: var(--neutral-blue_x);
            --callout-note: var(--neutral-blue_x);
            --callout-summary: var(--neutral-aqua_x);
            --callout-info: var(--neutral-blue_x);
            --callout-todo: var(--neutral-blue_x);
            --callout-important: var(--neutral-aqua_x);
            --callout-tip: var(--neutral-aqua_x);
            --callout-success: var(--neutral-green_x);
            --callout-question: var(--neutral-yellow_x);
            --callout-warning: var(--neutral-orange_x);
            --callout-fail: var(--neutral-red_x);
            --callout-error: var(--neutral-red_x);
            --callout-bug: var(--neutral-red_x);
            --callout-example: var(--neutral-purple_x);
            --callout-quote: var(--gray_x);
        }

        .callout {
            background-color: rgba(var(--callout-color), 0.2);
        }

        .canvas-control-item {
            background-color: var(--dark0);
            color: var(--neutral-purple);
        }
        .canvas-control-item:hover {
            background-color: var(--dark0);
            color: var(--neutral-blue);
        }


        /* Mermaid theme */

        .mermaid path.pieCircle {
          stroke: transparent !important;
        }

        .mermaid g>g>circle {
          fill: var(--color-blue) !important;
        }

        .mermaid .node path {
          fill: var(--mer-node-pt) !important;
          stroke: var(--neutral-yellow) !important;
        }

        .mermaid text :not(.tag-label, tspan) {
          fill: var(--mer-text) !important;
        }

        .mermaid text {
          fill: var(--mer-text) !important;
        }
        /* text in actor boxes */
        .mermaid text.actor>tspan {
          /* fill: var(--mer-text) !important; */
          fill: var(--neutral-blue) !important;
        }

        .mermaid text.pieTitleText {
          font-size: revert !important;
        }

        .mermaid text.titleText {
          fill: var(--text-normal) !important;
        }

        .mermaid text:is(.taskTextOutsideRight, .taskTextOutsideLeft) {
          fill: var(--mer-task-text2) !important;
        }

        .mermaid .legend text {
          /* fill: var(--mer-legd-txt) !important; */
          fill: var(--neutral-aqua) !important;
        }

        .theme-dark .mermaid rect.req.reqBox {
          fill: var(--mer-req-box) !important;
        }

        .mermaid rect.note {
          fill: var(--mer-rect-note) !important;
          stroke: var(--neutral-aqua) !important;
        }

        .mermaid rect.er.attributeBoxOdd {
          fill: var(--mer-attr-bx-o) !important;
        }

        .mermaid rect.er.attributeBoxEven {
          fill: var(--mer-attr-bx-e) !important;
        }

        .mermaid rect.activation0 {
          fill: var(--mer-poly-1) !important;
        }

        .mermaid rect :not(.task) {
          fill: var(--mer-rect-2) !important;
        }

        .mermaid rect.er.entityBox {
          fill: var(--mer-rect-entity) !important;
        }

        .mermaid .node rect {
          fill: var(--mer-rect-base) !important;
        }

        .mermaid .cluster rect {
          fill: transparent !important;
          stroke: var(--neutral-green) !important;
          stroke-width: 3 !important;
        }

        .mermaid .statediagram-cluster rect {
          fill: var(--mer-clust-rect-2) !important;
          stroke: var(--neutral-blue) !important;
          stroke-width: 3 !important;
        }

        .mermaid .statediagram-note rect {
          fill: var(--mer-stat-rect) !important;
          stroke: var(--neutral-orange) !important;
          /* stroke-width: 3 !important; */
        }

        .mermaid :is(rect.req.reqBox, rect.actor) {
          fill: transparent !important;
          stroke: var(--neutral-purple) !important;
        }

        .mermaid polygon.label-container {
          fill: var(--mer-poly-1) !important;
          stroke: var(--neutral-orange) !important;
        }

        .mermaid polygon.state-start,
        .mermaid .node circle.state-start {
          fill: var(--mer-poly-start) !important;
        }
        .mermaid .orange>* {
            fill: var(--dark0) !important;
            stroke: var(--neutral-orange) !important;
            stroke-width: 4px !important;
        }

        .mermaid polygon.state-end,
        .mermaid .node circle.state-end {
          fill: var(--mer-poly-end) !important;
        }


        .mermaid circle {
          fill: var(--mer-circle-1) !important;
          stroke: var(--neutral-yellow) !important;
        }

        .mermaid circle.pieOuterCircle {
          stroke: transparent !important;
        }

        .mermaid .node .fork-join {
          fill: var(--mer-fork-jn) !important;
          stroke: #${base07} !important;
        }

        .mermaid .node .label {
          color: var(--mer-node-lbl) !important;
          fill: var(--mer-node-lbl) !important;
        }

        .mermaid .edgeLabel,
        .mermaid .label text,
        .mermaid span {
          color: var(--mer-label-txt) !important;
        }

        .mermaid :not(span.nodeLabel) :is(.cluster span) {
          color: var(--text-normal) !important;
        }

        .mermaid .loopText>tspan {
          fill: var(--mer-loop-txt) !important;
        }

        .mermaid .exclude-range {
          fill: var(--mer-excl-range) !important;
        }

        .mermaid .label {
          background: var(--label-bg-col) !important;
        }

        .mermaid .edgeLabel {
          color: var(--text-normal) !important;
        }

        .mermaid .taskText {
          fill: var(--mer-task-text) !important;
        }

        .mermaid .labelBox {
          fill: var(--mer-labl-box) !important;
        }

        .mermaid .req-title-line {
          stroke: var(--mer-req-title) !important;
        }

        .mermaid .divider {
          stroke: var(--mer-mer-div) !important;
        }

        .mermaid .nodeLabel {
          color: var(--text-normal) !important;
          border-radius: 4px;
        }

        .theme-dark .mermaid path:is(.flowchart-link, .transition) {
          stroke: var(--text-normal) !important;
        }

        .theme-dark .mermaid path:is(.relationshipLine) {
          stroke: var(--neutral-green) !important;
        }

        .mermaid circle:is(.actor-0, .actor-1, .actor-2, .actor-3) {
          fill: var(--mer-actor0) !important;
        }




        /* fixed colors */
        /* gantt */
        .theme-dark .mermaid rect:is(.done0, .done1, .done2, .done3) {
          fill: #${base04} !important;
        }

        .mermaid circle.face {
          fill: #${yellow} !important;
        }


        .edgeLabel p {
            background-color: var(--dark0) !important;
        }

        .mermaid path#node-undefined>tspan {
          fill: var(--mer-node-lbl) !important;
        }

        .theme-dark .mermaid .lineWrapper line {
          stroke: #${base05} !important;
        }

        .theme-dark .mermaid .slice {
          fill: var(--mer-node-lbl) !important;
          text-shadow: 0 0 #${base05} !important;
        }

        .theme-dark .mermaid tspan.text-inner-tspan {
          fill: var(--mer-node-lbl) !important;
        }

        .mermaid g:is(.taskWrapper, .eventWrapper) text {
          fill: var(--mer-node-lbl) !important;
        }

        .mermaid .quadrant text {
          fill: var(--mer-node-lbl) !important;
        }

        .mermaid text.sequenceNumber {
          stroke: var(--mer-node-lbl) !important;
        }

        .mermaid text.tag-label {
          fill: var(--mer-node-lbl) !important;
        }

        .mermaid .gitTitleText {
          transform: translateY(-10px);
        }

        /* change an arrow color in git logs */
        .mermaid path.arrow.arrow0 {
          stroke: var(--neutral-green) !important;
        }
        .mermaid path.arrow.arrow1 {
          stroke: var(--neutral-blue) !important;
        }
        .mermaid path.arrow.arrow2 {
          stroke: var(--neutral-red) !important;
        }
        /* branch labels in git log */
        .mermaid rect.branchLabelBkg.label0 {
            fill: var(--neutral-green) !important;
        }
        .mermaid rect.branchLabelBkg.label1 {
            fill: var(--neutral-blue) !important;
        }
        .mermaid rect.branchLabelBkg.label2 {
            fill: var(--neutral-red) !important;
        }
        /* text on git branch labels TODO might change other stuff? */
        .mermaid tspan.row {
              fill: var(--dark0) !important;
        }
        .mermaid .commit-label-bkg {
            fill: #${base07} !important;
            opacity: 0.5;
        }
        .mermaid .commit-label {
            fill: var(--mer-text) !important;
        }
        .mermaid .commit-highlight-inner {
            /* stroke: var(--neutral-purple) !important; */
            fill: var(--dark0) !important;
        }
        .mermaid .commit-highlight-outer {
            stroke: var(--neutral-blue) !important;
            fill: var(--dark0) !important;
        }
        /*
        .mermaid .commit-highlight0.commit-highlight-outer {
            fill: transparent !important;
        }
        */
        .mermaid .branch {
            stroke: var(--mer-text) !important;
        }
        .mermaid .tag-label-bkg {
            fill: transparent !important;
            stroke: var(--neutral-orange);
        }
        .mermaid text.tag-label {
            fill: var(--mer-text) !important;
        }


        .mermaid .noteText>tspan {
          stroke: var(--neutral-green) !important;
        }

        /* line colors for sequence diagrams */
        .mermaid .messageLine0 {
          stroke: var(--neutral-blue) !important;
        }
        .mermaid .messageLine1 {
          stroke: var(--neutral-green) !important;
        }
        .mermaid .messageLine2 {
          stroke: var(--neutral-purple) !important;
        }
        .mermaid .actor-line {
          stroke: var(--neutral-orange) !important;
        }


         /* XY graph settings */
        .mermaid svg[aria-roledescription="xychart"] {

          /* add spacious Obsidian background */
          padding: 1rem 2rem 1rem 1rem;
          background-color: var(--background-secondary);

          & g.main {

            /* hide Mermaid background */
            & rect.background {
              opacity: 0;
            }

            & g.plot {

              /* bar chart */
              & rect {
                fill: var(--color-blue) !important;
              }

              /* line chart */
              & path {
                stroke: var(--color-red) !important;
              }
            }

            /* choose color for axes */
            & g.bottom-axis,
            & g.left-axis {

              & path,
              & g.label text,
              & g.title text {
                stroke: var(--text-faint) !important;
              }
            }

            /* no ticks on bottom axis */
            & g.bottom-axis g.ticks{
                display: none;
            }  
          }
        }

        /* get rid of the stupid fucking filter they put on everything */
        .mermaid > svg {
         filter: none !important; 
        }

        /* style for text input boxes */
        textarea, input.metadata-input-text, input[type='date'], input[type='datetime-local'],
        input[type='text'], input[type='search'], input[type='email'],
        input[type='password'], input[type='number'] {
            background: var(--background-modifier-form-field);
            color: var(--text-normal);
            outline: none;
        }

        /* style when text boxes are clicked */
        textarea:active, input.metadata-input-text:active,
        input[type='date']:active, input[type='datetime-local']:active,
        input[type='text']:active, input[type='search']:active,
        input[type='email']:active, input[type='password']:active,
        input[type='number']:active, textarea:focus, input.metadata-input-text:focus,
        input[type='date']:focus, input[type='datetime-local']:focus,
        input[type='text']:focus, input[type='search']:focus,
        input[type='email']:focus, input[type='password']:focus,
        input[type='number']:focus, textarea:focus-visible,
        input.metadata-input-text:focus-visible,
        input[type='date']:focus-visible,
        input[type='datetime-local']:focus-visible,
        input[type='text']:focus-visible,
        input[type='search']:focus-visible,
        input[type='email']:focus-visible, input[type='password']:focus-visible, input[type='number']:focus-visible {
          box-shadow: 0 0 0 2px var(--neutral-purple);
        }


        /* make button text dark */
        button:not(.clickable-icon) {
            color: var(--dark0);
        }

        /* make dropdown text dark */
        select, .dropdown {
            color: var(--text-normal);
        }

    '';

  };
}
