{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    gcc
    gnumake
    binutils
  ];

  buildInputs = with pkgs; [
    systemc
  ];

  shellHook = ''
    # Automatically set SYSTEMC_HOME to the Nix store path
    export SYSTEMC_HOME=${pkgs.systemc}

    # Update library paths so the linker and runtime can find SystemC
    export LIBRARY_PATH="$SYSTEMC_HOME/lib:$LIBRARY_PATH"
    export LD_LIBRARY_PATH="$SYSTEMC_HOME/lib:$LD_LIBRARY_PATH"
    export CPLUS_INCLUDE_PATH="$SYSTEMC_HOME/include:$CPLUS_INCLUDE_PATH"

    echo "--- SystemC Development Environment Loaded ---"
    echo "SYSTEMC_HOME is set to $SYSTEMC_HOME"
  '';
}
