{ config, lib, pkgs, ... }: 

{
  # Dynamic MOTD that shows on every SSH login for fish shell
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
      
      set_color green
      echo "🚀 Welcome to ALPHA - K3s Cluster Node"
      set_color yellow
      echo "📊 System Status:"
      set_color normal
      
      # Show system info
      echo "  💻 Uptime: "(uptime -p)
      echo "  🔋 Load: "(cat /proc/loadavg | cut -d' ' -f1-3)
      set memory_info (free -h | grep '^Mem:' | awk '{printf "%s / %s (%.1f%%)", $3, $2, ($3/$2)*100}')
      echo "  💾 Memory: $memory_info"
      
      # Show k3s status
      if systemctl is-active --quiet k3s
        set_color green
        echo "  ☸️  K3s: ● Running"
        set_color normal
        if command -v kubectl >/dev/null 2>&1
          set node_count (kubectl get nodes --no-headers 2>/dev/null | wc -l)
          echo "  🌐 Cluster: $node_count nodes"
        end
      else
        set_color red
        echo "  ☸️  K3s: ● Stopped"
        set_color normal
      end
      
      # Show keepalived status
      if systemctl is-active --quiet keepalived
        if ip addr show | grep -q "192.168.0.50"
          set_color green
          echo "  🔄 Keepalived: ● Master (VIP Active)"
        else
          set_color yellow
          echo "  🔄 Keepalived: ● Backup"
        end
      else
        set_color red
        echo "  🔄 Keepalived: ● Stopped"
      end
      
      set_color normal
    end
  '';
}
