{ pkgs, lib, config, ... }:

{
  # Allow HM to manage fish config
  programs.fish = {
    enable = true;

    shellAbbrs = {
      x = "eza";
      cp = "xcp";
      v = "nvim";
      p = "python3";
      ga = "git add";
      gp = "git push";
      dc = "docker-compose";
      scope-tui =
        "scope-tui --no-ui --scale 0.15 --channels 3 pulse pipewire.monitor";
      pkg = "nix-shell -p";
    };

    #TODO there's no home manager setting for this??
    interactiveShellInit = ''
      set fish_greeting #disable greeting
      fish_vi_key_bindings
    '';
    #"	set fish_greeting #disable greeting\n	set __done_notification_command '${pkgs.libnotify}/bin/notify-send $title $message'\n	fish_vi_key_bindings\n";

    plugins = [{
      name = "done";
      src = pkgs.fishPlugins.done.src;
    }];

    functions = {

      # Fish prompt
      fish_prompt = {
        body =
          "	set -l last_status $status \n	if not set -q __fish_prompt_normal \n		set -g __fish_prompt_normal (set_color normal) \n	end \n\n	# PWD \n	set_color $fish_color_cwd \n	echo -n (prompt_pwd) \n	set_color normal \n	\n	printf '%s ' (__fish_git_prompt) \n	if not test $last_status -eq 0 \n		set_color red\n	else\n	    set_color cyan\n	end \n\n\n	# set_color cyan \n	echo -n 'λ ' \n	set_color normal 	\n";
      };

      op = { body = builtins.readFile ./fish/functions/op.fish; };

      # Vim prompt
      fish_mode_prompt = {
        body =
          "	# Do nothing if not in vi mode\n	if test \"$fish_key_bindings\" = \"fish_vi_key_bindings\"\n	  bind -M insert jk \"if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end\"\n	  bind -M insert kj \"if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end\"\n	  switch $fish_bind_mode\n	    case default\n	      set_color --bold green\n	      echo \n	      # echo  \n	      # echo \n	      # ech \n	      # echo \n	    case insert\n	      set_color --bold cyan\n	      echo \n	      # echo \n	      # echo \n	      # echo \n	      # echo \n	    case replace_one\n	      set_color --bold red\n	      echo \n	      # echo \n	    case visual\n	      set_color --bold magenta\n	      # echo \n	      echo \n	  end\n	  set_color normal\n	  printf \" \"\n	end\n";
      };

      # Handlers for command not found
      __fish_command_not_found_handler = {
        onEvent = "fish_command_not_found";
        body = "	echo \"fish: Unknown command '$argv'\"\n";
      };
      fish_command_not_found = {
        body = "__fish_default_command_not_found_handler $argv[1]";
      };

      # Print public IP
      myIp = { body = "curl ipinfo.io/ip"; };

      # IFonfig like output but with ip command
      ifconfig = { body = "ip -br -c -a"; };

      # Utility to quickly copy file to backup
      backup = {
        argumentNames = [ "filename" ];
        body = "cp $filename $filename.bak";
      };

      # Restore that backed up file
      restore = {
        argumentNames = [ "file" ];
        body = "mv $file (echo $file | sed s/.bak//)";
      };

      # Create a directory without relying on existing ones
      mkd = { body = "mkdir -pv $argv"; };

      # Better defaults for tree
      tree = { body = "command tree -C --dirsfirst $argv"; };

      # Sudo Do Last
      sdl = { body = "eval command sudo $history[1]"; };

      # Pipe journal output to Lnav
      jrnl = { body = "command journalctl $argv | lnav"; };

      # Always give DF human readable output
      df = { body = "command df -h"; };

      # cat abbreviation
      c = { body = "bat $argv"; };

      # Override Ranger configs since we can't config with home-manager-23.11
      ranger = {
        body =
          "command ranger --cmd='set preview_images true' --cmd='set preview_images_method kitty' $argv";
      };

      # Git commit shortcut
      commit = {
        body = ''
          command git commit -m "$argv"
        '';
      };

      # Build NixOS System
      bldnix = {
        body =
          "sudo nixos-rebuild switch --flake /home/${config.home.username}/nix/";
      };
      # Build Home Manager Config
      bldhome = {
        #body = "home-manager switch --flake /home/${config.home.username}/nix/";
        body = "nh home switch /home/${config.home.username}/nix/";
      };

      bldcommit = {
        body =
          "	git -C /home/${config.home.username}/nix/ add .\n	read --prompt=\"set_color green; echo -n  ; set_color normal; echo 'Commit Message: '\" COMMITMSG\n	git -C /home/${config.home.username}/nix/ commit -m $COMMITMSG\n";
      };

      bldpush = { body = "	git -C /home/${config.home.username}/nix/ push\n"; };

      # Better Youtube-dl opts
      ytdl = {
        body = ''
          command youtube-dl \
          --extract-audio \
          --add-metadata \
          --audio-format mp3 \
          -o "%(title)s.%(ext)s" \
          "$argv"
        '';
      };
      extract = {
        body = # fish
          ''
                # no arguments, write usage
                if test (count $argv) -eq 0
            	echo "Usage: extract [-option] [file ...]\n Options:\n -r, --remove    Remove archive after unpacking." >&2
            	# exit 1 # this closes the terminal...
                end

                set remove_file 0
                if test $argv[1] = "-r"; or test $argv[1] = "--remove"
            	set remove_file 1
            	set --erase argv[1]
                end

                for i in $argv[1..-1]
            	if test ! -f $i
            	    echo "extract: '$i' is not a valid file" >&2
            	    continue
            	end

            	set success 0
            	set extension (string match -r ".*(\.[^\.]*)\$" $i)[2]
            	switch $extension
            	    case '*.tar.gz' '*.tgz'
            		tar xv; or tar zxvf "$i"
            	    case '*.tar.bz2' '*.tbz' '*.tbz2'
            		tar xvjf "$i"
            	    case '*.tar.xz' '*.txz'
            		tar --xz -xvf "$i"; or xzcat "$i" | tar xvf -
            	    case '*.tar.zma' '*.tlz'
            		tar --lzma -xvf "$i"; or lzcat "$i" | tar xvf -
            	    case '*.tar'
            		tar xvf "$i"
            	    case '*.gz'
            		gunzip -k "$i"
            	    case '*.bz2'
            		bunzip2 "$i"
            	    case '*.xz'
            		unxz "$i"
            	    case '*.lzma'
            		unlzma "$i"
            	    case '*.z'
            		uncompress "$i"
            	    case '*.zip' '*.war' '*.jar' '*.sublime-package' '*.ipsw' '*.xpi' '*.apk' '*.aar' '*.whl'
            		set extract_dir (string match -r "(.*)\.[^\.]*\$" $i)[2]
            		unzip "$i" -d $extract_dir
            	    case '*.rar'
            		unrar x -ad "$i"
            	    case '*.7z'
            		7za x "$i"
            	    case '*'
            		echo "extract: '$i' cannot be extracted" >&2
            		set success 1
            	end

            	if test $success -eq 0; and test $remove_file -eq 1
            	    rm $i
            	end
                end
            #end
          '';
      };

    };

  };

}
