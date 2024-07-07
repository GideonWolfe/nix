{lib, config, pkgs, ... }:
{
  age.secrets = {
    #TODO: find a way to move the secret somewhere better and reference the path in a cleaner way
    test1 = {
      file = "./secrets/test/test1.age";
      path = "/home/gideon/.test1";
    };
  };
}
