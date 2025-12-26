{ config, lib, pkgs, ... }: 

{
  # Dynamic MOTD that shows on every SSH login for fish shell
  # Edit this according to the node role
  # Change logo, add service status checks, etc
  programs.fish.interactiveShellInit = ''
    # Only show MOTD for SSH sessions, not local logins
    if set -q SSH_CLIENT; or set -q SSH_TTY
      set_color cyan
      echo "⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
      echo "⠀⠀⠀⠀⠀⣠⣶⣿⣿⣿⣿⣿⣿⣿⣦⣄⠀⠀⠀⠀⢀⣤⣤⣄⠀⠀⠀⠀⠀⠀"
      echo "⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡄⠀⢠⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀"
      echo "⠀⠀⣰⣿⣿⣿⣿⣿⠟⠉⠉⠉⠻⣿⣿⣿⣿⣿⣦⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀"
      echo "⠀⢠⣿⣿⣿⣿⡿⠁⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠀⠀⠀⠀⠀⠀"
      echo "⠀⣾⣿⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀"
      echo "⢀⣿⣿⣿⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀"
      echo "⢸⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀"
      echo "⠈⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀"
      echo "⠀⢿⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⢀⡀⠀⠀"
      echo "⠀⠘⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⣿⣄⣀⣠⣾⣿⣿⣷⡀"
      echo "⠀⠀⠹⣿⣿⣿⣿⣿⣦⣀⣀⣀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁"
      echo "⠀⠀⠀⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃⠈⢿⣿⣿⣿⣿⣿⣿⣿⠟⠁⠀"
      echo "⠀⠀⠀⠀⠀⠙⠿⣿⣿⣿⣿⣿⣿⡿⠟⠋⠀⠀⠀⠀⠉⠛⠛⠟⠛⠋⠀⠀⠀⠀"
      echo "⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
      set_color normal
    end
  '';
}
