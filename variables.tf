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
        enforce_admins                  = bool
        require_signed_commits          = bool
        required_linear_history         = bool
        require_conversation_resolution = bool
        allows_deletions                = bool
        allows_force_pushes             = bool
        blocks_creations                = bool
        required_status_checks = list(object({
          strict       = bool
          contexts     = set(string)
        }))
        required_pull_request_reviews = list(object({
          dismiss_stale_reviews             = bool
          required_approving_review_count   = number
        }))

  }))
  default     = {
    main = {
        enforce_admins                  = true
        require_signed_commits          = false
        required_linear_history         = false
        require_conversation_resolution = false
        allows_deletions                = true
        allows_force_pushes             = false
        blocks_creations                = false
        required_status_checks = [{
          strict       = false
          contexts     = [""]
        }]
        required_pull_request_reviews = [{
          dismiss_stale_reviews             = true
          required_approving_review_count   = "2"
        }]
    }
  }
  description = "Branch protections for selected branched in repository"
}

variable "deploy_key" {
  type = list(string)

  default = [
    "ssh-rsa AAA...",
    "ssh-rsa BBB..."
  ]
}
