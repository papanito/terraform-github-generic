resource "github_repository" "repositories" {
  for_each = {
    for key, value in var.repositories : key => value
  }

  name         = each.key
  description  = each.value.description
  homepage_url = try(each.value.homepage_url, "https://gitlab.com/papanito/${each.key}")
  archived     = try(each.value.archived, false)
  topics       = try(each.value.topics, [])

  visibility      = try(each.value.access.visibility, "private")
  has_discussions = try(each.value.access.has_discussions, false)
  has_issues      = try(each.value.access.has_issues, false)
  has_projects    = try(each.value.access.has_projects, false)
  has_wiki        = try(each.value.access.has_wiki, false)

  allow_auto_merge            = try(each.value.merge_settings.allow_auto_merge, false)
  allow_merge_commit          = try(each.value.merge_settings.allow_merge_commit, false)
  allow_rebase_merge          = try(each.value.merge_settings.allow_rebase_merge, true)
  allow_squash_merge          = try(each.value.merge_settings.allow_squash_merge, false)
  allow_update_branch         = try(each.value.merge_settings.allow_update_branch, false)
  merge_commit_message        = try(each.value.merge_settings.merge_commit_message, "PR_TITLE")
  merge_commit_title          = try(each.value.merge_settings.merge_commit_title, "MERGE_MESSAGE")
  squash_merge_commit_message = try(each.value.merge_settings.squash_merge_commit_message, "COMMIT_MESSAGES")
  squash_merge_commit_title   = try(each.value.merge_settings.squash_merge_commit_title, "COMMIT_OR_PR_TITLE")

  auto_init              = false
  delete_branch_on_merge = false
  is_template            = false
  vulnerability_alerts   = each.value.vulnerability_alerts
  #default_branch = try(each.value.default_branch, "main")

  security_and_analysis {
    secret_scanning {
      status = "disabled"
    }
    secret_scanning_push_protection {
      status = "disabled"
    }
  }
}
