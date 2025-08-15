class UpdateModelGithub {
  final String repoOwner ;
  final String repoName ;
  final String branch ;

  UpdateModelGithub({
    required this.repoOwner,
    required this.repoName,
    this.branch = 'master',
});

  factory UpdateModelGithub.fromJson(Map<String, dynamic> json) => UpdateModelGithub(
    repoOwner: json['repo_owner'],
    repoName: json['repo_name'],
    branch: json['branch'],
  );

  Map<String, dynamic> toJson() => {
    'repo_owner': repoOwner,
    'repo_name': repoName,
    'branch': branch,
  };
}