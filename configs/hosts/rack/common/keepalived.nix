{ lib, inputs, ... }: 

{
  services.keepalived = {
    enable = true;

    vrrpInstances.k3s = {
      interface = "eno1";                # replace with your real NIC
      virtualRouterId = 51;              # arbitrary number, must be same on all nodes
      #virtualIps = [ "192.168.0.50/24" ]; # the shared floating IP
      virtualIps = [ {addr = "192.168.0.50/24";} ]; # the shared floating IP

      # Priority decides who is preferred MASTER
      # higher number = more preferred
      priority = 200;  # set highest on the "primary" node
      state = "BACKUP"; # all should be BACKUP for auto election

    #   authentication = {
    #     authType = "PASS";
    #     authPass = "supersecret";        # shared password, must match on all nodes
    #   };
    };
  };
}
