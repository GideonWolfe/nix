{ config, lib, pkgs, inputs, ... }:

{
  home.packages = [
    pkgs.tenere # llm TUI
    pkgs.llm # LLM CLI
    pkgs.tgpt # LLM CLI
    inputs.nix-ai-tools.packages.${pkgs.system}.crush
    pkgs.open-interpreter # BUG: crashing
    pkgs.cherry-studio
    #pkgs.open-webui # NOTE: this is a big one, maybe enable conditionally
    pkgs.aichat
    pkgs.shell-gpt # CLI for ChatGPT
    # Also big (3gb)
    #pkgs.alpaca # GTK LLM GUI
    #(pkgs.alpaca.override { ollama = pkgs.ollama-rocm; })
    #pkgs.lmstudio # LLM GUI # also big!
  ];
}
