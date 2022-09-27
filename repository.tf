resource "github_repository" "coremaker_repo" {
  name        = var.repo_name
  description = var.repo_description

  visibility = var.repo_visibility
}

resource "github_team" "coremaker_team" {
  count = "${length(var.teams)}"
  name = var.teams[count.index].team_name
}

resource "github_team_repository" "coremaker_team_repo" {
  repository = github_repository.coremaker_repo.name
  count = "${length(var.teams)}"

  team_id = github_team.coremaker_team[count.index].id
  permission = var.teams[count.index].permission
}

resource "github_branch_protection" "branch_protect" {
  repository_id = github_repository.coremaker_repo.name

  pattern          = "main"
  enforce_admins   = true
  allows_deletions = true

  required_pull_request_reviews {
    dismiss_stale_reviews  = true
    required_approving_review_count = 2
  }

}

resource "github_repository_deploy_key" "example_repository_deploy_key" {
  title      = "Repository key"
  repository = github_repository.coremaker_repo.name
  for_each = toset(var.deploy_key)
  key        = each.value
  read_only  = "false"
}