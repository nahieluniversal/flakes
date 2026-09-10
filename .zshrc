# Portable Zsh configuration derived from this repository's flake setup.
# Works on Linux/macOS and degrades gracefully when optional tools are missing.

# -------- Environment (from Home Manager sessionVariables) --------
export TERM="${TERM:-alacritty}"
if [[ "$OSTYPE" == linux* ]]; then
  export XDG_CURRENT_DESKTOP="${XDG_CURRENT_DESKTOP:-Hyprland:KDE}"
  export XDG_SESSION_DESKTOP="${XDG_SESSION_DESKTOP:-Hyprland}"
  export XDG_MENU_PREFIX="${XDG_MENU_PREFIX:-}"

  # Build a sane XDG_DATA_DIRS without hardcoding a username.
  typeset -a _xdg_data_parts
  _xdg_data_parts=(
    "$HOME/.local/share/flatpak/exports/share"
    "/var/lib/flatpak/exports/share"
    "$HOME/.nix-profile/share"
    "/etc/profiles/per-user/${USER}/share"
    "/nix/var/nix/profiles/default/share"
    "/run/current-system/sw/share"
  )

  typeset -a _xdg_existing_parts
  for _part in "${_xdg_data_parts[@]}"; do
    [[ -d "$_part" ]] && _xdg_existing_parts+=("$_part")
  done

  if (( ${#_xdg_existing_parts[@]} > 0 )); then
    export XDG_DATA_DIRS="${(j/:/)_xdg_existing_parts}"
  fi
  unset _xdg_data_parts _xdg_existing_parts _part
fi

# -------- Oh My Zsh (theme/plugins from flake) --------
export ZSH="${ZSH:-$HOME/.oh-my-zsh}"
ZSH_THEME="agnoster"
plugins=(git docker docker-compose kubectl kubectx)
if [[ -r "$ZSH/oh-my-zsh.sh" ]]; then
  source "$ZSH/oh-my-zsh.sh"
fi

# -------- Helpers for flake-local commands --------
_flakes_repo_dir() {
  local candidate
  for candidate in "$FLAKES_DIR" "$HOME/flakes" "$PWD"; do
    [[ -n "$candidate" && -f "$candidate/flake.nix" ]] && {
      printf '%s\n' "$candidate"
      return 0
    }
  done
  return 1
}

# -------- Aliases/functions derived from shellAliases --------
alias ncg='sudo nix-collect-garbage -d'

futaba() {
  if [[ "$OSTYPE" != linux* ]] || ! command -v nixos-rebuild >/dev/null 2>&1; then
    echo "futaba: nixos-rebuild is only available on NixOS/Linux." >&2
    return 1
  fi

  local repo host
  repo="$(_flakes_repo_dir)" || {
    echo "futaba: no flake repo found (set FLAKES_DIR)." >&2
    return 1
  }
  host="${FLAKES_HOST:-$(hostname -s 2>/dev/null || echo laptop)}"

  sudo nixos-rebuild switch --flake "${repo}/#${host}" --max-jobs 2
}

hms() {
  if ! command -v home-manager >/dev/null 2>&1; then
    echo "hms: home-manager is not installed." >&2
    return 1
  fi

  local repo host hm_user
  repo="$(_flakes_repo_dir)" || {
    echo "hms: no flake repo found (set FLAKES_DIR)." >&2
    return 1
  }
  host="${FLAKES_HOST:-laptop}"
  hm_user="${HM_USER:-$USER}"

  home-manager switch --flake "${repo}/modules/hosts/${host}/home-manager#${hm_user}"
}

upd() {
  local repo
  repo="$(_flakes_repo_dir)" || {
    echo "upd: no flake repo found (set FLAKES_DIR)." >&2
    return 1
  }
  command -v nix >/dev/null 2>&1 || {
    echo "upd: nix is not installed." >&2
    return 1
  }

  (
    cd "$repo" || return
    nix flake update && futaba
  )
}

# -------- Interactive shell extra (from shellInit) --------
if [[ $- == *i* ]] && command -v fastfetch >/dev/null 2>&1; then
  fastfetch
fi
