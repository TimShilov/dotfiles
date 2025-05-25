{
  lib,
  ...
}:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;

    # uncomment for shell profiling
    # zprof.enable = true;

    syntaxHighlighting.enable = true;
    autocd = true;
    sessionVariables = {
      LANG = "en_GB.UTF-8";
      MANPAGER = "nvim +Man! '+set relativenumber'";
    };
    shellAliases = {
      nixswitch = "sudo darwin-rebuild switch --flake ~/dotfiles/.#";
      nixup = "pushd ~/dotfiles; nix flake update; nixswitch; popd";
      nixclean = "nix-collect-garbage --delete-older-than 14d";

      cat = "bat";
      dcw = "~/dotfiles/scripts/docker-compose-watch.sh";
      gr = "cd $(git rev-parse --show-toplevel)";
      gs = "git status";
      k = "~/dotfiles/scripts/kubernetes.sh";
      p = "pet exec";
      tt = "taskwarrior-tui";
      v = "nvim";
    };
    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      share = false;
      save = 10000;
      size = 10000;
    };
    initContent = lib.mkMerge [
      (lib.mkBefore # bash
        ''
          export PATH="$HOME/.asdf/shims:$PATH"
        ''
      )

      # bash
      ''
        function gc() {
            local branches branch
            branches=$(git branch --all | grep -v HEAD) &&
                branch=$(echo "$branches" |
                    fzf-tmux -d $((2 + $(wc -l <<<"$branches"))) +m) &&
                git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
        }

        function rgr() {
          local git_root
          git_root=$(git rev-parse --show-toplevel 2>/dev/null) || { echo "Not a git repository"; return 1; }

          pushd "$git_root" >/dev/null || return
          {
            "$@"
          } always {
            popd >/dev/null
          }
        }

        function sc() {
            if cat package.json >/dev/null 2>&1; then
                selected_script=$(cat package.json | jq .scripts | sed '1d;$d' | fzf --cycle --height 80% --header="Press ENTER to run the script. ESC to quit.")

                if [[ -n "$selected_script" ]]; then
                    script_name=$(echo "$selected_script" | awk -F ': ' '{gsub(/"/, "", $1); print $1}' | awk '{$1=$1};1')

                    print -s "npm run "$script_name
                    npm run $script_name
                else
                    echo "Exit: You haven't selected any script"
                fi
            else
                echo "Error: There's no package.json"
            fi
        }
      ''
    ];
  };
}
