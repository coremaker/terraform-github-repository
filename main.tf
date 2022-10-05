# Repository configuration module
resource "github_repository" "repository_creation" {
  name        = var.repo_name
  description = var.repo_description
  auto_init   = true

  visibility = var.repo_visibility
}

# Add teams to the given repository
resource "github_team_repository" "repository_teams" {
  count      = length(var.repo_teams)
  repository = github_repository.repository_creation.name

  team_id    = var.repo_teams[count.index].team_name
  permission = var.repo_teams[count.index].permission
}

# Give branch protection for multiple branches inside the repository
resource "github_branch_protection" "repository_branch_protection" {
  for_each                        = var.branch_protection
  repository_id = github_repository.repository_creation.node_id

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
      strict = required_status_checks.value.strict
    }
  }

  dynamic "required_pull_request_reviews" {
    for_each = each.value.required_pull_request_reviews

    content {
      dismiss_stale_reviews           = required_pull_request_reviews.value.dismiss_stale_reviews
      require_code_owner_reviews      = required_pull_request_reviews.value.require_code_owner_reviews
      required_approving_review_count = required_pull_request_reviews.value.required_approving_review_count
    }
  }
}

# Deploy keys for repository auth
resource "github_repository_deploy_key" "repository_deploy_key" {
  for_each   = toset(var.deploy_key)
  title      = "Repository keys"
  repository = github_repository.repository_creation.name
  key        = each.value
  read_only  = "false"
}
