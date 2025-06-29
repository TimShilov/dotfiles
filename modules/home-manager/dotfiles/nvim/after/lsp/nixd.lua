return {
  cmd = { 'nixd' },
  filetypes = { 'nix' },
  settings = {
    nixd = {
      nixpkgs = { expr = 'import <nixpkgs> { }' },
      options = {
        nix_darwin = {
          expr = '(builtins.getFlake "${config.home.homeDirectory}/dotfiles").darwinConfigurations.${config.home.hostname}.options',
        },
      },
    },
  },
}
