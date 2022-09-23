resource "github_repository" "example" {
  name        = var.repo_name
  description = var.repo_description

  visibility = var.repo_visibility
}


resource "github_team" "some_team" {
  count = "${length(var.teams)}"
  name = var.teams[count.index].team_name
}

resource "github_team_repository" "some_team_repo" {
  repository = github_repository.example.name
  count = "${length(var.teams)}"

  team_id = github_team.some_team[count.index].id
  permission = var.teams[count.index].permission
}