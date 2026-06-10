{ pkgs, ... }:

let
  pskcLanPreview = pkgs.writeShellApplication {
    name = "pskc-lan-preview";
    runtimeInputs = [
      pkgs.bash
      pkgs.coreutils
      pkgs.gawk
      pkgs.gnugrep
      pkgs.gnused
      pkgs.lsof
      pkgs.nginx
      pkgs.nodejs_24
    ] ++ pkgs.lib.optionals pkgs.stdenv.hostPlatform.isLinux [
      pkgs.iproute2
    ];
    text = builtins.readFile ./nix/pskc-lan-preview.sh;
  };
in
{
  name = "pskc-staging";

  packages = [
    pkgs.nginx
    pkgs.lsof
    pkgs.nodejs_24
    pskcLanPreview
  ] ++ pkgs.lib.optionals pkgs.stdenv.hostPlatform.isLinux [
    pkgs.iproute2
  ];

  scripts = {
    preview.exec = "pskc-lan-preview --daemon";
    preview-foreground.exec = "pskc-lan-preview";
    preview-status.exec = "pskc-lan-preview --status";
    preview-stop.exec = "pskc-lan-preview --stop";
    preview-build.exec = "PSKC_BUILD=1 pskc-lan-preview --daemon";
  };

  processes.preview.exec = "pskc-lan-preview";

  enterShell = ''
    preview_port="''${PSKC_PORT:-8090}"
    preview_auto="''${PSKC_AUTO_PREVIEW:-1}"
    preview_build="''${PSKC_AUTO_BUILD:-0}"
    preview_root="''${PSKC_SITE_ROOT:-$PWD}"

    echo "PSKC Astro shell"
    echo "  npm run dev          # Astro dev server"
    echo "  npm run build        # Build static dist/"
    echo "  pskc-lan-preview     # Foreground nginx preview"
    echo "  pskc-lan-preview --stop"
    echo "  preview              # Start daemonized local preview"
    echo "  preview-stop         # Stop daemonized local preview"
    echo "  devenv up            # Run local preview in the foreground"
    echo

    if [ "$preview_auto" = "1" ]; then
      echo "PSKC LAN preview auto-start"
      echo "  Serving existing dist/ on port $preview_port"
      if [ "$preview_build" = "1" ] || [ -f "$preview_root/dist/index.html" ]; then
        PSKC_BUILD="$preview_build" pskc-lan-preview --daemon || {
          echo "  Preview did not start. Run npm run build, then pskc-lan-preview --daemon."
        }
      else
        echo "  No dist/index.html yet. Run npm run build, then pskc-lan-preview --daemon."
        echo "  Or set PSKC_AUTO_BUILD=1 to build during shell entry."
      fi
    else
      echo "PSKC LAN preview"
      echo "  Auto-start disabled by PSKC_AUTO_PREVIEW=0"
      echo "  Start:  pskc-lan-preview --daemon"
      echo "  Local:  http://127.0.0.1:$preview_port/"
    fi
  '';
}
