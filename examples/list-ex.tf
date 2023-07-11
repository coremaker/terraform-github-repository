variable "github_repositories" {
  type = list(object({
    name        = string
    description = optional(string, "")
    visibility  = optional(string, "public")
    teams = optional(list(object({
      team_name  = string
      permission = string
    })))
    branch_protection = optional(map(object({
      enforce_admins                  = optional(bool, true)
      require_signed_commits          = optional(bool, false)
      required_linear_history         = optional(bool, false)
      require_conversation_resolution = optional(bool, true)
      allows_deletions                = optional(bool, false)
      allows_force_pushes             = optional(bool, true)
      blocks_creations                = optional(bool, false)
      required_status_checks = optional(list(object({
        strict = optional(bool, true) # Require branches to be up to date before merging. Defaults to false
      })), [{ strict = true }])
      required_pull_request_reviews = optional(list(object({
        dismiss_stale_reviews           = optional(bool, true)
        require_code_owner_reviews      = optional(bool, false)
        required_approving_review_count = optional(number, 2)
      })), [{ dismiss_stale_reviews = true, require_code_owner_reviews = false, required_approving_review_count = 2 }])
    })))
    deploy_key = optional(list(string), [])
  }))
  default = []
  # Value example
  # value = [
  #   {
  #     name = "repo1"
  #     visibility = "private"
  #     teams = [
  #       {
  #         team_name = "dev"
  #         permission = "read"
  #       }
  #     ]
  #     branch_protection = {
  #       main = {}
  #     }
  #   }
  # ]
  description = "Manage github repositories"
}

locals {
  repos = {
    for name in var.github_repositories :
    name.name => name
  }
}

module "github_repository_list" {
  source   = "../"
  for_each = local.repos

  # Repository Configuration
  repo_name        = each.key
  repo_description = each.value["description"]
  repo_visibility  = each.value["visibility"]

  # Added teams to the repository in question
  repo_teams = each.value["teams"]

  # Multiple Branch Protection 
  branch_protection = each.value["branch_protection"]
  deploy_key        = each.value["deploy_key"]
}
