{
  config,
  pkgs,
  unstable,
  ...
}:
{
  home.packages = [
    unstable.cliamp
  ];

}
