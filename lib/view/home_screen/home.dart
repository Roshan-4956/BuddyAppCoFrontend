import 'package:flutter/material.dart';

class ProfileCard {
  final String name;
  final int age;
  final String description;
  final String cityOfOrigin;
  final int yearsInCity;
  final String whatILove;
  final String occupation;
  final List<String> interests;
  final String imageUrl;

  ProfileCard({
    required this.name,
    required this.age,
    required this.description,
    required this.cityOfOrigin,
    required this.yearsInCity,
    required this.whatILove,
    required this.occupation,
    required this.interests,
    required this.imageUrl,
  });
}

class home extends StatefulWidget {
  final List<ProfileCard> profiles;

  const home({super.key, required this.profiles});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final PageController _pageController = PageController(
    viewportFraction: 0.9,
    keepPage: true,
  );

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.profiles.length,
      itemBuilder: (context, index) {
        final profile = widget.profiles[index];
        return Container(
          height: (MediaQuery.of(context).size.height) * .576,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),

            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // shadow color
                spreadRadius: 2, // how wide the shadow spreads
                blurRadius: 8, // softness of the shadow
                offset: const Offset(2, 4), // horizontal & vertical movement
              ),
            ], // Rounded corners
          ),

          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile image
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(profile.imageUrl),
                  ),
                ),
                const SizedBox(height: 12),

                // Name + Age
                Center(
                  child: Text(
                    "${profile.name}, Age ${profile.age}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Description
                Center(
                  child: Text(
                    profile.description,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 12),

                // Interests
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  alignment: WrapAlignment.center,
                  children: profile.interests
                      .map(
                        (interest) => Chip(
                          label: Text(interest),
                          backgroundColor: Colors.grey.shade200,
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 12),

                // City + Years lived
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _infoTile("City of Origin", profile.cityOfOrigin),
                    _infoTile(
                      "Years lived in this city",
                      "${profile.yearsInCity}",
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // What I love
                _infoTile("What I love about this city", profile.whatILove),
                const SizedBox(height: 12),

                // Occupation
                _infoTile("Occupation", profile.occupation),

                const Spacer(),

                // Footer
                Center(
                  child: Text(
                    "Tap to learn more",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _infoTile(String title, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
