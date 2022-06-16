{config, pkgs, ...}:
{
    packageOverrides = pkgs: {
        tshort = pkgs.callPackage (builtins.toPath "${config.home.homeDirectory}/flake/pkgs/tshort") {};
    };
}
