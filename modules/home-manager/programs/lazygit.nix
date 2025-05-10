{
  programs.lazygit = {
    enable = true;
    settings = {
      promptToReturnFromSubprocess = false;

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
          subprocess = true;
        }
        {
          key = "U";
          command = # bash
            ''gh pr update-branch {{.SelectedLocalBranch.Name}}'';
          context = "localBranches";
          subprocess = true;
        }
        {
          key = "U";
          command = # bash
            ''gh pr update-branch {{.SelectedRemoteBranch.Name}}'';
          context = "remoteBranches";
          subprocess = true;
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
