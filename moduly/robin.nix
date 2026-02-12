# Můj uživatelský účet

{pkgs, ...}:
  users.users.robin = {
    isNormalUser = true;
    description = "Robin Volf";
    extraGroups = [
      "networkmanager"
      "wheel" # Chcu sudo
    ];
    hashedPassword = "$y$j9T$CXo6N5TREXTi.QLsqIJ8G/$JOIvMeKRSluiwlVGStmvTNsTNneO37bSQDFCt9cd8Z8"; # Doufám, že toto je neverzovatelné xd
    openssh.authorizedKeys.keys = [
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBIQYzKYSgupG/+DqyyuckdvyiXHE18hHdYI8PsI2Mq/l3IurBsDEkifkHRdDEBW35fIclxfPzuIjrNVh2YnFBFA= robin@t14-laptop"
    ];
    shell = pkgs.fish; # Můj osobní shell
  };
}
