class User {
  final String name;
  final String phone;

  User({required this.name, required this.phone});
}

// Map to hold contacts for each factory
Map<int, List<User>> factoryContacts = {
  1: [
    User(name: 'Ben', phone: '+60109219938'),
  ],
  2: [
    User(name: 'Testing 1', phone: '+6012345667891'),
  ],
  3: [
    User(name: 'Hello', phone: '+60123456789'),
  ],
};
