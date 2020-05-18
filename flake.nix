{
  description = "Flake for xontribs (xonsh packages)";

  inputs = {
    apt-tabcomplete = { url = "github:DangerOnTheRanger/xonsh-apt-tabcomplete"; flake = false; };
    autoxsh = { url = "github:Granitas/xonsh-autoxsh"; flake = false; };
    avox = { url = "github:astronouth7303/xontrib-avox"; flake = false; };
    base16-shell = { url = "github:ErickTucto/xontrib-base16-shell"; flake = false; };
    direnv = { url = "github:74th/xonsh-direnv"; flake = false; };
    docker-tabcomplete = { url = "github:xsteadfastx/xonsh-docker-tabcomplete"; flake = false; };
    fzf-widgets = { url = "github:shahinism/xontrib-fzf-widgets"; flake = false; };
    hist-navigator = { url = "github:jnoortheen/xontrib-hist-navigator"; flake = false; };
    histcpy = { url = "github:con-f-use/xontrib-histcpy"; flake = false; };
    kitty = { url = "github:scopatz/xontrib-kitty"; flake = false; };
    output-search = { url = "github:anki-code/xontrib-output-search"; flake = false; };
    pipeliner = { url = "github:anki-code/xontrib-pipeliner"; flake = false; };
    powerline = { url = "github:santagada/xontrib-powerline"; flake = false; }; # use pypi xontrib-powerline2
    prompt-bar = { url = "github:anki-code/xontrib-prompt-bar"; flake = false; };
    prompt-vi-mode = { url = "github:t184256/xontrib-prompt-vi-mode"; flake = false; };
    pyenv = { url = "github:dyuri/xontrib-pyenv"; flake = false; };
    readable-traceback = { url = "github:6syun9/xontrib-readable-traceback"; flake = false; };
    schedule = { url = "github:astronouth7303/xontrib-schedule"; flake = false; };
    scrapy-tabcomplete = { url = "github:Granitas/xonsh-scrapy-tabcomplete"; flake = false; };
    ssh-agent = { url = "github:dyuri/xontrib-ssh-agent"; flake = false; };
    vox-tabcomplete = { url = "github:Granitosaurus/xonsh-vox-tabcomplete"; flake = false; };
    xo = { url = "github:scopatz/xo"; flake = false; };
    z = { url = "github:astronouth7303/xontrib-z"; flake = false; };
  };

  outputs = inputs@{ self, nixpkgs, ... }: {

    overlay = final: prev: let
      inherit (prev) system;
    in rec {
      xontribs = self.packages.${system};
    };

    packages = nixpkgs.lib.genAttrs [ "x86_64-linux" "i686-linux" "aarch64-linux" "x86_64-darwin" ] (system: let 
      pkgs = nixpkgs.legacyPackages.${system};
      buildXontrib = args@{ name, src, ... }: pkgs.python3Packages.buildPythonPackage (args // rec {
        pname = "xonsh-${args.name}";
        version = src.rev;
        name = "${pname}-${version}";
      });
      buildXontribPoem = args@{ name, src, ... }: pkgs.poetry2nix.mkPoetryApplication (args // rec {
        pname = "xonsh-${args.name}";
        version = src.rev;
        name = "${pname}-${version}";
      });
    in with pkgs.python3Packages; {
      apt-tabcomplete = buildXontrib { name = "apt-tabcomplete"; src = inputs.apt-tabcomplete; };
      autoxsh = buildXontrib { name = "autoxsh"; src = inputs.autoxsh; };
      avox = buildXontrib { name = "avox"; src = inputs.avox; };
      base16-shell = buildXontrib { name = "base16-shell"; src = inputs.base16-shell; };
      direnv = buildXontrib { name = "direnv"; src = inputs.direnv; };
      docker-tabcomplete = buildXontrib { name = "docker-tabcomplete"; src = inputs.docker-tabcomplete; };
      fzf-widgets = buildXontrib { name = "fzf-widgets"; src = inputs.fzf-widgets; };
      hist-navigator = buildXontribPoem { name = "hist-navigator"; src = inputs.hist-navigator; };
      histcpy = buildXontrib { name = "histcpy"; src = inputs.histcpy; propagatedBuildInputs = [ pyperclip ]; };
      kitty = buildXontrib { name = "kitty"; src = inputs.kitty; };
      output-search = buildXontrib { name = "output-search"; src = inputs.output-search; };
      pipeliner = buildXontrib { name = "pipeliner"; src = inputs.pipeliner; };
      powerline = buildXontrib { name = "powerline"; src = inputs.powerline; };
      prompt-bar = buildXontrib { name = "prompt-bar"; src = inputs.prompt-bar; };
      prompt-vi-mode = buildXontrib { name = "prompt-vi-mode"; src = inputs.prompt-vi-mode; };
      pyenv = buildXontrib { name = "pyenv"; src = inputs.pyenv; };
      readable-traceback = buildXontrib { name = "readable-traceback"; src = inputs.readable-traceback; };
      schedule = buildXontrib { name = "schedule"; src = inputs.schedule; };
      scrapy-tabcomplete = buildXontrib { name = "scrapy-tabcomplete"; src = inputs.scrapy-tabcomplete; };
      ssh-agent = buildXontrib { name = "ssh-agent"; src = inputs.ssh-agent; };
      vox-tabcomplete = buildXontrib { name = "vox-tabcomplete"; src = inputs.vox-tabcomplete; };
      xo = buildXontrib { name = "xo"; src = inputs.xo; };
      z = buildXontrib { name = "z"; src = inputs.z; };
    });

  };
}
