// ignore_for_file: public_member_api_docs, sort_constructors_first
//

class User {
  final String name;
  final String imageUrl;

  const User({
    required this.name,
    required this.imageUrl,
  });

  static const User currentUser = User(
    name: 'Simon',
    imageUrl:
        'https://cdn.cloudflare.steamstatic.com/steamcommunity/public/images/avatars/67/674d1c270f1621498f1b419f2c68913688b54b05_full.jpg',
  );
}
