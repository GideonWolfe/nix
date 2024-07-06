let
  gideon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJx8xzFoJ5l6XPpQ2KXjhQ6Ja0Htp4ubIFyTL5EP6Z5A gideon@hermes";
  users = [ gideon ];

  hermes = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDX+pKJEwU5uP5aHKgMXftmErxaDneZ7vyO/NSLqn/mcqfJHQ7daOzilFxupYYLvfidtFztnS8o3jscHfqqKlnevQTgPY7H7dddu537bNKhhwRx03dkxjcnTUcEIOJ1uvRB1/FZKxhcNmY/YrQb1BSCUpeCuIQPiRxu9x71RLlA5cyK0oa+bX5s8rFA3ZGVKxmD1bFGirmrNIkdh5G3eBmx8z08OhWwAy0iQAm/JuJjxEPGZgv1EUOLPBoC5MywONU8tqF7y7rwdsA1gF3snHG8XuXqLz5335/M7WKHspHS4Bzn2yao5SSwNX0C40Tbkkr+tyAoqN60+9q0eXpBCrdZi4Xdc7TlBem2vhOfmZPR0w+ESHtjPiXH9BsTRiHyKeqqA0EEfaTlQBzV/CVTs7milnY98GsWALZ/DPPkbY6K7x7Uf+42QPiXhp/AI5G6VGKPbCq6vTFZillgjDM5nu2SZHFK+WysMc1WaSE1MjsPoHryI0uz9uFA8GjtHGG5F80dMhlLmjltqnBx8du9tbt+0kJ/nO5csYnx2If3mAVSAay060J/+Y21KMTLTNNy8AMgJjnx9gZVT+2Of859v7J538zYQJTqQAk4Epqf5perxVHEwYYDKWtUpINjgAA6dlWrEja0E9ZMNMFkzKFExc5jd80NTHnyU5rENuStekHPnw== root@hermes";
  systems = [ hermes ];
in 
{
    # Should only be accessible by these users/systems
    "test1.age".publicKeys = [gideon hermes];

    age.secrets = {

        test1 = {
            file = "./test/test1.age";
        };

    };
}
