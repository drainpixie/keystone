{vimUtils}:
vimUtils.buildVimPlugin {
  name = "alabaster";

  src = builtins.fetchGit {
    url = "https://github.com/p00f/alabaster.nvim";
    ref = "main";
    rev = "7c2f32bfb233365a320446553ae6cfc0674d02d9";
  };

  patches = [./alabaster.patch];
}
