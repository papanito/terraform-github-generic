variable "repositories" {
  description = <<EOT
A map of repository configurations where the key represents the repository name.

General Options:
- description: (Required) A description of the repository.
- archived: (Optional) Set to true to archive the repository. Defaults to false.
- default_branch: (Optional) The name of the default branch. Defaults to 'main'.
- is_template: (Optional) Whether this is a template repository. Defaults to false.
- allow_forks: (Optional) Only is relvena for organizations, shall be not set for personal repos
- homepage_url: (Optional) URL of a page describing the project.
- topics: (Required) The list of topics to set on the repository.
- vulnerability_alerts: (Optional) Whether to enable security alerts for vulnerable dependencies. Defaults to true.

Access Settings (access object):
- visibility: (Optional) Can be 'public', 'private', or 'internal'. Overrides 'private'.
- private: (Optional) Whether the repository is private. Defaults to false.
- has_issues: (Optional) Enable the GitHub Issues features. Defaults to true.
- has_discussions: (Optional) Enable GitHub Discussions. Defaults to false.
- has_projects: (Optional) Enable the GitHub Projects features.
- has_wiki: (Optional) Enable the GitHub Wiki features. Defaults to true.

Merge Settings (merge_settings object):
- allow_auto_merge: (Optional) Allow auto-merging pull requests. Defaults to false.
- allow_merge_commit: (Optional) Allow merge commits. Defaults to false.
- allow_rebase_merge: (Optional) Allow rebase merges. Defaults to true.
- allow_squash_merge: (Optional) Allow squash merges. Defaults to false.
- allow_update_branch: (Optional) Suggest updating PR branches. Defaults to false.
- merge_commit_message: (Optional) Message for merge commits: 'PR_BODY', 'PR_TITLE', or 'BLANK'.
- merge_commit_title: (Optional) Title for merge commits: 'PR_TITLE' or 'MERGE_MESSAGE'.
- squash_merge_commit_message: (Optional) Message for squash: 'PR_BODY', 'COMMIT_MESSAGES', or 'BLANK'.
- squash_merge_commit_title: (Optional) Title for squash: 'PR_TITLE' or 'COMMIT_OR_PR_TITLE'.
EOT
  type = map(object({
    description  = string
    archived     = optional(bool, false)
    is_template  = optional(bool, false)
    homepage_url = optional(string, null)
    allow_forks  = optional(bool, null)
    access = optional(object({
      visibility      = optional(string)
      private         = optional(bool, false)
      has_issues      = optional(bool, true)
      has_discussions = optional(bool, false)
      has_projects    = optional(bool, false)
      has_wiki        = optional(bool, true)
    }), {}) # Default to empty object to allow using defaults
    merge_settings = optional(object({
      allow_auto_merge            = optional(bool, false)
      allow_merge_commit          = optional(bool, false)
      allow_rebase_merge          = optional(bool, true)
      allow_squash_merge          = optional(bool, false)
      allow_update_branch         = optional(bool, false)
      merge_commit_message        = optional(string, "PR_TITLE")
      merge_commit_title          = optional(string, "MERGE_MESSAGE")
      squash_merge_commit_message = optional(string, "COMMIT_MESSAGES")
      squash_merge_commit_title   = optional(string, "COMMIT_OR_PR_TITLE")
    }))
    default_branch       = optional(string, "main")
    topics               = list(string)
    vulnerability_alerts = optional(bool, true)
    }
  ))
}
