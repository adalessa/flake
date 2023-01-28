{pkgs}: {
  enable = true;
  package = pkgs.firefox-esr;
  profiles.default = {
    isDefault = true;
    name = "Default";
    settings = {
      "browser.startup.homepage" = "https://home.ad-impeldown.synology.me";
      "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
    };
  };
}
