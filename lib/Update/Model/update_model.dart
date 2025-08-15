class UpdateModelGithub {
  final String repoOwner ;
  final String repoName ;
  final String branch ;

  UpdateModelGithub({
    required this.repoOwner,
    required this.repoName,
    this.branch = 'master',
});

}