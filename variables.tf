variable "repo_name" {
  description = "GitHub Repository Name"
  default     = ""
}

variable "repo_description" {
  default = ""
}

variable "repo_visibility" {
  default = ""
}

variable "teams" {
  type = list(object({
    team_name  = string
    permission = string
  }))
}

variable "branch_protection" {
  type = map(object({
    enforce_admins                  = bool # true = status checks for repository administrators.
    require_signed_commits          = bool # true = requires all commits to be signed with GPG.
    required_linear_history         = bool # true = enforces a linear commit Git history, which prevents anyone from pushing merge commits to a branch
    require_conversation_resolution = bool # true = requires all conversations on code must be resolved before a pull request can be merged.
    allows_deletions                = bool # true = allows the branch to be deleted.
    allows_force_pushes             = bool # true = allows force pushes on the branch.
    blocks_creations                = bool # true = blocks creating the branch.
    required_status_checks = list(object({
      strict = bool # Require branches to be up to date before merging. Defaults to false
    }))
    required_pull_request_reviews = list(object({
      dismiss_stale_reviews           = bool   # Dismiss approved reviews automatically when a new commit is pushed. Defaults to false
      require_code_owner_reviews      = bool   # Require an approved review in pull requests including files with a designated code owner. Defaults to false.
      required_approving_review_count = number # Require x number of approvals to satisfy branch protection requirements
    }))

  }))
  description = "Branch protections for selected branches in repository"
}

variable "deploy_key" {
  type = list(string)

  default = []
}
