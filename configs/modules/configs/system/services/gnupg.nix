{
    programs.gnupg = {
        agent = {
            enable = true;
        };
    };

    # Enable hardware support for GPG smartcards
    hardware.gpgSmartcards.enable = true;
}
