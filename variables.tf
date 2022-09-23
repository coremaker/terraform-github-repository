variable "token" {
    default = ""
}

variable "owner" {
  description = "GitHub owner used to configure the provider"
  type        = string
  default     = "coremaker"
}

variable "repo_name" {
    description = "GitHub Repository Name"
    default = "terraform-github-example"
}

variable "repo_description" {
    default = ""
}

variable "repo_visibility" {
    default = "public"
}

variable "teams" {
  type = list(object({
    team_name  = string
    permission = string
  }))
  default = [
    {
        team_name = "team1"
        permission = "admin"
    },
    {
        team_name = "team2"
        permission = "write"
    }
  ]
}
