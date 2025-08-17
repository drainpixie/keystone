{
  config,
  lib,
  ...
}: {
  options.tracker.enable = lib.mkEnableOption "track machine usage through activitywatch";

  config = lib.mkIf config.tracker.enable {
    servics.activitywatch = {
      enable = true;
    };
  };
}
