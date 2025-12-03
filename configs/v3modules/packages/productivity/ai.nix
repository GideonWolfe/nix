{ config, lib, pkgs, inputs, ... }:

{
  home.packages = [
    pkgs.tenere # llm TUI
    pkgs.llm # LLM CLI
    pkgs.tgpt # LLM CLI
    pkgs.lmstudio # LLM GUI
    inputs.nix-ai-tools.packages.${pkgs.system}.crush
    pkgs.open-interpreter # BUG: crashing
    pkgs.cherry-studio
    pkgs.open-webui
    pkgs.aichat
    pkgs.shell-gpt # CLI for ChatGPT
    #pkgs.alpaca # GTK LLM GUI
    (pkgs.alpaca.override { ollama = pkgs.ollama-rocm; })
  ];
}
