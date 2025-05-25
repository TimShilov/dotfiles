{
  programs.lazygit = {
    enable = true;
    settings = {
      promptToReturnFromSubprocess = false;
      git = {
        paging = {
          colorArg = "always";
          pager = "diff-so-fancy";
        };
      };

      customCommands = [
        {
          key = "X";
          prompts = [
            {
              type = "input";
              title = "Commit";
              initialValue = "";
            }
          ];
          command = # bash
            ''git commit -m "{{index .PromptResponses 0}}" --no-verify'';
          context = "global";
          output = "log";
        }
        {
          key = "U";
          command = # bash
            ''gh pr update-branch {{.SelectedLocalBranch.Name}}'';
          context = "localBranches";
          output = "log";
        }
        {
          key = "U";
          command = # bash
            ''gh pr update-branch {{.SelectedRemoteBranch.Name}}'';
          context = "remoteBranches";
          output = "log";
        }
      ];

      gui = {
        showFileTree = false;
        mouseEvents = false;
        nerdFontsVersion = "3";
        filterMode = "fuzzy";
      };
    };
  };
}
