# Server Services

Each directory in the `server_services` directory represents a standalone service that can be spun up on a nix system, ideally just by importing the relevant `.nix` file within the child directory.

The goal is to make these services as host-agnostic as possible, utilizing global variables to maintain a more robust source of truth. For example, if my ZNC instance on my self-hosted box goes down, I can easily import `znc.nix` on a fresh or pre-existing NixOS VPS, and get back up and running.