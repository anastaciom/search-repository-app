class Repository {
  final int id;
  final String name;
  final String? description;
  final int stars;
  final String url;
  final String? avatarUrl;

  Repository({
    required this.id,
    required this.name,
    required this.description,
    required this.stars,
    required this.url,
    required this.avatarUrl,
  });

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      stars: json['stargazers_count'],
      url: json['html_url'],
      avatarUrl: json['owner']['avatar_url'],
    );
  }
}
