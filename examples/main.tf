module "github-repository" {
source = "../"
  
  # Repository Configuration
  repo_name = "terraform-github-example"
  repo_description = "Test"
  repo_visibility = "public"

  # Added teams to the repository in question
  repo_teams = [
    {
        team_name = "test-terraform"
        permission = "admin"      # or maintain, push, pull, triage
    }
  ]

  # Multiple Branch Protection 
  branch_protection = {
    main = {
        enforce_admins                  = true    # true = status checks for repository administrators.
        require_signed_commits          = false   # true = requires all commits to be signed with GPG.
        required_linear_history         = false   # true = enforces a linear commit Git history, which prevents anyone from pushing merge commits to a branch
        require_conversation_resolution = true    # true = requires all conversations on code must be resolved before a pull request can be merged.
        allows_deletions                = false   # true = allows the branch to be deleted.
        allows_force_pushes             = true    # true = allows force pushes on the branch.
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
  deploy_key = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDNmXvyJzMYf7eeDSpD7oRwZfNjLhAaz4Hz5cOg01Z92IOgq1KryISJ6IB8zmG1+yEXlKauX1qj623n74Ugp3/Dz4OShBdpeoSEo8QeX9wxRCBu1KLTBdwo7OnUdko/7iduK3RTrKmA3JC89nMxiqD4B1ooAr6P3wYOYJhL7SXtWeamfSezaWp4mGtVSDTmN3Yz+Q7heEOuT50PSjOdPmFnMkKqONp3a/A2eldIG7jTDHYuzPUi6Sg7nJ62x42QX913y3k0NyNOYpy+yKcjpNcgzlTxUurnzzLJvdGQHbvYxjd86ogbQdGzSStKG9xnfVTear1HBUryW8ybEhhSELSzhNDIz1gOx4Q7PKDswwvdaEJsDyBjjAkNz5zoGGBDKD7hT7g+hIheaIbHj218xmmTRPb/wVyq81m+MAD2cYmD+fZsyhMg+eVwLdFK80XMU9flEXD2+EG4iJ/TNOtpTtxI3h4FM1gcoxPNk82R/kw8QSFUniCE+YwffUoM52r8GYE="]
}
