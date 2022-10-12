<!--- Provide a general summary of your changes in the Title above -->

Changed the name of the resources in main.tf. Updated variables with their respective types. Repositioned for_each argument. Created pull request template

<!--- Describe your changes in detail -->

As suggested by Cosmin, we gave better and more meaningful names to the resources. Updated the majority of the variables in order to give them their respective type (string). Repositioned for_each argument to be located at the beggining of the resource, for better visibility. Created a pull_request_template file.

<!--- What types of changes does your code introduce? Put an x in all the boxes that apply -->
<!-- Please try to limit your pull request to one type, submit multiple pull requests if needed -->

- [X] Bugfix (non-breaking change which fixes an issue)
- [ ] Feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to change)
- [X] Refactoring (no functional changes, formatting, renaming)
- [ ] Other (please describe):

TODOs

<!--- Please ensure all of these TODOs are completed before asking for a review. Remove where unapplicable. -->

- [X] Ensure the branch is named correctly with the ticket number. (eg: DOP-2222)
- [X] Update the docs.
- [X] Update varible types.
- [X] Format terraform code.
- [X] Give terraform resources meaningful names.
- [X] Introduced pull_request_template file.
- [X] Examples directory.
- [X] Deploy keys example.
- [X] Terraform pre-commit with tflint.

Other information

<!-- Any other information that is important to this PR not covered earlier. -->

Adding reviewers:
@coremaker/devops
