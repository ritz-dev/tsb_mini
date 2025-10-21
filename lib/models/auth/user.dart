class User {
  final String slug;
  final String name;
  final String email;
  final String token;

  User({
    required this.slug,
    required this.name,
    required this.email,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final userData = json['data'];
    return User(
      slug: userData['slug'] ?? '',
      name: userData['name'] ?? '',
      email: userData['email'] ?? '',
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slug': slug,
      'name': name,
      'email': email,
      'token': token,
    };
  }
}
