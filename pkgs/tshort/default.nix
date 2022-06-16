{ buildGoModule, fetchFromGitHub }:

buildGoModule {
  name = "tshort";
  src = fetchFromGitHub {
    owner = "adalessa";
    repo = "tshort";
    rev = "eb0d30fbfe15abf2d2c84fe8ceecb9f6bde8bb2f";
  };
  vendorSha256 = null;
  subPackages = [ "." ];
}
