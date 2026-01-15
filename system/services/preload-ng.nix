{...}: {
  services.preload-ng = {
    enable = true;

    settings = {
      cycle = 15;
      sortStrategy = 0;

      memTotal = -5;
      memFree = 70;
      memCached = 10;
      memBuffers = 50;

      mapPrefix = "/nix/store/;/run/current-system/;!/";
      exePrefix = "/nix/store/;/run/current-system/;!/";
    };
  };
}
