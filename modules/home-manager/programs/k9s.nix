{
  programs.k9s = {
    enable = true;
    settings = {
      k9s = {
        liveViewAutoRefresh = true;
        skipLatestRevCheck = false;
        logger = {
          textWrap = true;
          sinceSeconds = -1; # -1 means tail
          buffer = 5000;
        };
        ui = {
          crumbsless = true;
          logoless = true;
          reactive = true;
          noIcons = false;
        };
      };
    };
    aliases = {
      aliases = {
        dp = "apps/v1/deployments";
        sec = "v1/secrets";
        jo = "batch/v1/jobs";
        cr = "rbac.authorization.k8s.io/v1/clusterroles";
        crb = "rbac.authorization.k8s.io/v1/clusterrolebindings";
        ro = "rbac.authorization.k8s.io/v1/roles";
        rb = "rbac.authorization.k8s.io/v1/rolebindings";
        np = "networking.k8s.io/v1/networkpolicies";
      };
    };
  };
}
