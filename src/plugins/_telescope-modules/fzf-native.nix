{ pkgs, config, lib }:
with lib;
let
  cfg = config.programs.nixneovim.plugins.telescope.extensions.fzf-native;
in
{
  options.programs.nixneovim.plugins.telescope.extensions.fzf-native = {
    enable = mkEnableOption "Enable fzf-native";

    fuzzy = mkOption {
      type = types.nullOr types.bool;
      description = "Whether to fuzzy search. False will do exact matching";
      default = null;
    };
    overrideGenericSorter = mkOption {
      type = types.nullOr types.bool;
      description = "Override the generice sorter";
      default = null;
    };
    overrideFileSorter = mkOption {
      type = types.nullOr types.bool;
      description = "Override the file sorter";
      default = null;
    };
    caseMode = mkOption {
      type = types.nullOr (types.enum [ "smart_case" "ignore_case" "respect_case" ]);
      default = null;
    };
  };

  config =
    let
      configuration = {
        fuzzy = cfg.fuzzy;
        override_generic_sorter = cfg.overrideGenericSorter;
        override_file_sorter = cfg.overrideFileSorter;
        case_mode = cfg.caseMode;
      };
    in
    mkIf cfg.enable {
      programs.nixneovim.extraPlugins = [ pkgs.vimPlugins.telescope-fzf-native-nvim ];

      programs.nixneovim.plugins.telescope.enabledExtensions = [ "fzf" ];
      programs.nixneovim.plugins.telescope.extensionConfig."fzf" = configuration;
    };
}
