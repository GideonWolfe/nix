{
  programs.nixvim.autoCmd = [
    # Resume last place in file
    {
        event = "BufReadPost";
        callback = {
            __raw = ''
                function()
                    vim.cmd([[
                        if line("'\"") > 0 && line("'\"") <= line("$") |
                            exe "normal! g`\"" |
                        endif
                    ]])
                end
            '';
        };
    }
  ];
}
