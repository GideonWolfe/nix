{ config, options, ... }: {

  age = {
    identityPaths = [
      "${config.home.homeDirectory}/nix/configs/users/gideon/configs/ssh/keys/agenix-test"
    ];    
    # identityPaths = options.age.identityPaths.default ++ [
    #   "${config.home.homeDirectory}/nix/configs/users/gideon/configs/ssh/keys/agenix-test"
    # ];
    secrets = {
      #TODO: find a way to move the secret somewhere better and reference the path in a cleaner way
      test1 = {
        file = ./secrets/test/test1.age;
        # path = ${config.home.homeDirectory}/.test1;
        path = "/home/gideon/.test1";
      };
    };
  };
}
