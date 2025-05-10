return {
  cmd = { 'nixd' },
  filetypes = { 'nix' },
  settings = {
    nixd = {
      nixpkgs = { expr = 'import <nixpkgs> { }' },
      options = {
        nix_darwin = {
          expr = '(builtins.getFlake "/Users/tim.shilov/dotfiles").darwinConfigurations."client-Tim-Shilov".options',
        },
      },
    },
  },
}
