variable "repo_name" {
  type = string
  description = "GitHub Repository Name"
  default     = ""
}

variable "repo_description" {
  type = string
  default = ""
}

variable "repo_visibility" {
  type = string
  default = ""
}

variable "repo_teams" {
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
      strict = bool # Require branches to be up to date before merging. Defaults to false
    }))
    required_pull_request_reviews = list(object({
      dismiss_stale_reviews           = bool   
      require_code_owner_reviews      = bool   
      required_approving_review_count = number 
    }))

  }))
  description = "Branch protections for branches as keys of the object"
}

variable "deploy_key" {
  type = list(string)

  default = []
}
