return {
  'rmagatti/auto-session',
  enabled = true,

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config   lazy = false,
  opts = {
    suppressed_dirs = { '~/', '~/IdeaProjects', '~/Downloads', '~/Desktop' },
  },
}
