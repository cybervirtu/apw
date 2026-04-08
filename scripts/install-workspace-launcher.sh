#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
APW_ROOT="$(cd "$SCRIPT_DIR/.." && pwd -P)"
WORKSPACE_PARENT="$(cd "$APW_ROOT/.." && pwd -P)"
WORKSPACE_APW_HOME="$WORKSPACE_PARENT/.apw"
WORKSPACE_BIN="$WORKSPACE_APW_HOME/bin"
WORKSPACE_ENV_ZSH="$WORKSPACE_APW_HOME/env.zsh"
WORKSPACE_LAUNCHER="$WORKSPACE_BIN/apw"
FRAMEWORK_WRAPPER="$APW_ROOT/apw"

usage() {
    cat <<EOF
Usage:
  ./scripts/install-workspace-launcher.sh

What it does:
  - creates a workspace-scoped apw launcher under $WORKSPACE_BIN
  - writes a zsh-friendly PATH snippet to $WORKSPACE_ENV_ZSH
  - keeps the APW framework repo as the single source of the real wrapper

After it finishes:
  1. source the printed env.zsh path in your current shell
  2. add the same source line to ~/.zshrc for future shells
  3. run apw help from the workspace parent, APW root, or a downstream project
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
    usage
    exit 0
fi

if [[ "${1:-}" != "" ]]; then
    echo "Error: install-workspace-launcher.sh does not accept extra arguments."
    usage
    exit 1
fi

if [[ ! -x "$FRAMEWORK_WRAPPER" ]]; then
    echo "Error: Missing executable APW wrapper at $FRAMEWORK_WRAPPER"
    exit 1
fi

mkdir -p "$WORKSPACE_BIN"

quoted_apw_root="$(printf '%q' "$APW_ROOT")"
quoted_framework_wrapper="$(printf '%q' "$FRAMEWORK_WRAPPER")"
quoted_workspace_bin="$(printf '%q' "$WORKSPACE_BIN")"

cat >"$WORKSPACE_LAUNCHER" <<EOF
#!/usr/bin/env bash

set -euo pipefail

APW_FRAMEWORK_ROOT=$quoted_apw_root
APW_FRAMEWORK_WRAPPER=$quoted_framework_wrapper

if [[ ! -x "\$APW_FRAMEWORK_WRAPPER" ]]; then
    echo "APW launcher is installed, but the framework wrapper is missing:"
    echo "  \$APW_FRAMEWORK_WRAPPER"
    echo
    echo "Fix:"
    echo "  cd \$APW_FRAMEWORK_ROOT"
    echo "  ./scripts/install-workspace-launcher.sh"
    exit 1
fi

exec "\$APW_FRAMEWORK_WRAPPER" "\$@"
EOF

chmod +x "$WORKSPACE_LAUNCHER"

cat >"$WORKSPACE_ENV_ZSH" <<EOF
# Source this from ~/.zshrc or your current shell to expose the workspace-scoped APW launcher.
WORKSPACE_APW_BIN=$quoted_workspace_bin

case ":\$PATH:" in
    *":\$WORKSPACE_APW_BIN:"*) ;;
    *) export PATH="\$WORKSPACE_APW_BIN:\$PATH" ;;
esac
EOF

echo "Installed workspace APW launcher:"
echo "  $WORKSPACE_LAUNCHER"
echo
echo "Created zsh PATH snippet:"
echo "  $WORKSPACE_ENV_ZSH"
echo
echo "For this shell right now, run:"
printf '  source %q\n' "$WORKSPACE_ENV_ZSH"
echo
echo "For future zsh shells, add this line to ~/.zshrc:"
printf '  source %q\n' "$WORKSPACE_ENV_ZSH"
echo
echo "Then verify the canonical entrypoint from the workspace parent, APW root, or a downstream project:"
echo "  apw help"
echo
echo "If apw is not resolvable yet, source the env.zsh file above and re-run apw help."
