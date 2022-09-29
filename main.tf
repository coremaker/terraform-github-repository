resource "github_repository" "coremaker_repo" {
  name         = var.repo_name
  description  = var.repo_description

  visibility   = var.repo_visibility
}


resource "github_team_repository" "coremaker_team_repo" {
  repository = github_repository.coremaker_repo.name
  count = "${length(var.teams)}"

  team_id = var.teams[count.index].team_name
  permission = var.teams[count.index].permission
}

resource "github_branch_protection" "branch_protect" {
  repository_id = github_repository.coremaker_repo.name

  for_each = var.branch_protection
  pattern                         = each.key
  enforce_admins                  = each.value.enforce_admins
  require_signed_commits          = each.value.require_signed_commits
  required_linear_history         = each.value.required_linear_history
  require_conversation_resolution = each.value.require_conversation_resolution
  allows_deletions                = each.value.allows_deletions
  allows_force_pushes             = each.value.allows_force_pushes
  blocks_creations                = each.value.blocks_creations

  dynamic "required_status_checks" {
    for_each = each.value.required_status_checks

    content {
      strict   = required_status_checks.value.strict
      contexts = required_status_checks.value.contexts
    }
  }

  dynamic "required_pull_request_reviews" {
    for_each = each.value.required_pull_request_reviews

    content {
      dismiss_stale_reviews             = required_pull_request_reviews.value.dismiss_stale_reviews
      required_approving_review_count   = required_pull_request_reviews.value.required_approving_review_count
    }
  }

}

resource "github_repository_deploy_key" "example_repository_deploy_key" {
  title      = "Repository keys"
  repository = github_repository.coremaker_repo.name
  for_each = toset(var.deploy_key)
  key        = each.value
  read_only  = "false"
}