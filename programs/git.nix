{config}: {
  enable = true;
  userName = "Ariel D'Alessandro";
  userEmail = "dalessandro.ariel@gmail.com";
  extraConfig = {
    init = {defaultBranch = "main";};
    branch = {autosetuprebase = "always";};
    pull = {rebase = true;};
  };
}
