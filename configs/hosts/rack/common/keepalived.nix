{ lib, inputs, config, ... }: 

{
  services.keepalived = {
    enable = true;

    openFirewall = true;

    vrrpInstances.k3s = {
      interface = "eno1";                # replace with your real NIC
      virtualRouterId = 51;              # arbitrary number, must be same on all nodes
      virtualIps = [ {addr = "${config.custom.world.hosts.cluster.ip}/24";} ]; # the shared floating IP

      # Priority decides who is preferred MASTER
      # higher number = more preferred
      priority = 100;  # set highest on the "primary" node
      state = "BACKUP"; # all should be BACKUP for auto election

    #   authentication = {
    #     authType = "PASS";
    #     authPass = "supersecret";        # shared password, must match on all nodes
    #   };
    };
  };
}
