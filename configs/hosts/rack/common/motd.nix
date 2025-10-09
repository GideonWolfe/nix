{ config, lib, pkgs, ... }: 

{
  users.motd = ''
    ╭─────────────────────────────────────────────────────────────────╮
    │                  🚀 K3s Cluster Infrastructure                   │
    ╰─────────────────────────────────────────────────────────────────╯
    
    ┌─ Cluster Information ────────────────────────────────────────────┐
    │ 🌐 Floating IP: ${config.custom.world.hosts.cluster.ip}         │
    │ 🔗 Node: ${config.networking.hostName}                          │
    │ 📅 Last Boot: $(systemctl show -p ActiveEnterTimestamp multi-user.target | cut -d= -f2 | cut -d' ' -f1-2)
    │ ⏰ Uptime: $(uptime -p)                                          │
    └──────────────────────────────────────────────────────────────────┘
    
    ┌─ Service Status ─────────────────────────────────────────────────┐
    │ 🔄 Keepalived: $(systemctl is-active keepalived 2>/dev/null || echo "inactive")                           │
    │    ├─ VIP Status: $(ip addr show | grep -q "${config.custom.world.hosts.cluster.ip}" && echo "🟢 MASTER" || echo "🔵 BACKUP")     │
    │                                                                  │
    │ ⚙️  K3s: $(systemctl is-active k3s 2>/dev/null || echo "inactive")                                        │
    │    ├─ Role: $(ps aux | grep -q 'k3s server' && echo "server" || echo "agent")                           │
    │    ├─ Nodes: $(${pkgs.kubectl} get nodes --no-headers 2>/dev/null | wc -l || echo "0") online                    │
    │    └─ Pods: $(${pkgs.kubectl} get pods --all-namespaces --no-headers 2>/dev/null | grep -c Running || echo "0") running │
    │                                                                  │
    │ 🔥 Firewall: $(systemctl is-active firewall 2>/dev/null || echo "inactive")                              │
    │ 📡 SSH: $(systemctl is-active sshd 2>/dev/null || echo "inactive")                                        │
    └──────────────────────────────────────────────────────────────────┘
    
    ┌─ System Resources ───────────────────────────────────────────────┐
    │ 💾 Memory: $(free -h | awk 'NR==2{printf "%.1f/%.1fGB (%.0f%%)", $3/1024, $2/1024, $3*100/$2}')           │
    │ 💽 Disk: $(df -h / | awk 'NR==2{printf "%s/%s (%s)", $3, $2, $5}')                                         │
    │ 🌡️  Load: $(uptime | grep -oE 'load average: [0-9.,]+ [0-9.,]+ [0-9.,]+' | cut -d' ' -f3-)                │
    │ 🔌 Network: $(ip route | grep default | awk '{print $5}') ($(ip addr show $(ip route | grep default | awk '{print $5}') | grep -oE 'inet [0-9.]+' | cut -d' ' -f2)) │
    └──────────────────────────────────────────────────────────────────┘
  '';
  
  # Install required packages for the MOTD commands
  environment.systemPackages = with pkgs; [
    kubectl
    kubernetes-helm
  ];
}
