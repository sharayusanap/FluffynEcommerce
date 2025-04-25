class User {
  final String name;
  final String email;
  final String phoneNumber;
  final String address;
  final String avatarUrl;

  User({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.avatarUrl,
  });

  // Create a mock user for the profile page
  factory User.mock() {
    return User(
      name: 'John Doe',
      email: 'john.doe@example.com',
      phoneNumber: '+1 (555) 123-4567',
      address: '123 Main St, Anytown, USA',
      avatarUrl:
          'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y',
    );
  }
}
