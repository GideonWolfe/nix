#!/usr/bin/env -S nix shell nixpkgs#fish --command fish

# no arguments or too many, write usage
if test (count $argv) -eq 0; or test (count $argv) -gt 1
    echo "Usage: op [file ...]" >&2
end


# its a loop but only one arg should be there...
for i in $argv[1..-1]
    # make sure argument is a file
    if test ! -f $i
        echo "op: '$i' is not a valid file" >&2
        continue
    end

    set success 0
    set extension (string match -r ".*(\.[^\.]*)\$" $i)[2]

    switch $extension
        case '*.json'
            fx "$i"; or cat "$i" | jqp
        case '*.mp3' '*.wav'
            asak play "$i"
        case '*.pdf'
            tdf "$i"
        case '*.md'
            frogmouth "$i"; or glow "$i"
        case '*.epub' '*.epub3' '*.mobi' '*..azw' '*.azw3' '*.fb2'
            epy "$i"
        case '*.csv' '*.tsv' '*.xlsx'
            sc-im "$i"
        case '*.png' '*.jpg' '*.jpeg' '*.gif' '*.tiff'
            kitten icat "$i"
        case '*.sqlite3'
            dblab --db "$i" --driver sqlite
        case '*.pcap'
            termshark -p "$i"
            # If we don't have a dedicated TUI viewer, fall back to xdg-open
        case '*'
            echo "op: '$i' does not have TUI viewer, trying xdg-open" >&2
            xdg-open "$i"
            set success 1
    end
end
