# terraform-github-repository

This is the Terraform Github Module used to create repositories, add existing teams to it with specific permissions, set branch protections to desired branches and add deploy keys.


# Resources

| Name | Type |
|------|------|
| [github_repository](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [github_team_repository](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_repository) | resource |
| [github_branch_protection](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection) | resource |
| [github_repository_deploy_key](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_deploy_key) | resource |

# Usage Example
```
module "github-repository" {
source = "github.com/coremaker/terraform-github-repository.git?ref=DOP-50-terraform-github-repository-Module"
  
  # Repository Configuration
  repo_name = "terraform-github-example"
  repo_description = "Test"
  repo_visibility = "public"

  # Added teams to the repository in question
  teams = [
    {
        team_name = "test-terraform"
        permission = "admin"
    }
  ]

  # Multiple Branch Protection 
  branch_protection = {
    main = {
        enforce_admins                  = true    # true = status checks for repository administrators.
        require_signed_commits          = false   # true = requires all commits to be signed with GPG.
        required_linear_history         = false   # true = enforces a linear commit Git history, which prevents anyone from pushing merge commits to a branch
        require_conversation_resolution = true   # true = requires all conversations on code must be resolved before a pull request can be merged.
        allows_deletions                = false    # true = allows the branch to be deleted.
        allows_force_pushes             = true   # true = allows force pushes on the branch.
        blocks_creations                = false   # true = blocks creating the branch.
        required_status_checks = [{
          strict       = true     # Require branches to be up to date before merging. Defaults to false
        }]
        required_pull_request_reviews = [{
          dismiss_stale_reviews             = true  # Dismiss approved reviews automatically when a new commit is pushed. Defaults to false
          require_code_owner_reviews        = false # Require an approved review in pull requests including files with a designated code owner. Defaults to false.
          required_approving_review_count   = "2"   # Require x number of approvals to satisfy branch protection requirements
        }]
    }
  }
}
```
