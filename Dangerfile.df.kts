import systems.danger.kotlin.*

danger(args) {

    val allSourceFiles = git.modifiedFiles + git.createdFiles

    onGitHub {
        if(git.createdFiles.any { it.endsWith("_test.dart")} ) {
            message("Thanks for adding unit tests")
        } else {
            warn("Please add unit tests for all files")
        }

        // Big PR Check
        if ((pullRequest.additions ?: 0) - (pullRequest.deletions ?: 0) > 300) {
            warn("Big PR, try to keep changes smaller if you can")
        }

        // Work in progress check
        if (pullRequest.title.contains("WIP", false)) {
            warn("PR is a Work in Progress")
        }
    }
}