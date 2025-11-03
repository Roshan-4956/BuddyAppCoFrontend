import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class appBarr extends StatefulWidget implements PreferredSizeWidget {
  final String Name;
  final String Location;

  const appBarr({super.key, required this.Name, required this.Location});

  @override
  State<appBarr> createState() => _appBarrState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _appBarrState extends State<appBarr> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      // leading: SizedBox(height: 0, width: 0,),
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hi ${widget.Name}!",
            style: TextStyle(
              fontFamily: "Rethink Sans",
              fontSize: 36,
              fontVariations: [
                FontVariation('wght', 1000), // Set weight to 1000 if supported
              ],
              color: Color(0xFF1E1E1E),
              height: 1.07,
            ),
          ),
          GestureDetector(
            child: Row(
              children: [
                Image.asset('assets/homepage/locIcon.png', scale: 4),
                Padding(padding: EdgeInsets.symmetric(horizontal: 3)),
                Text(
                  "Buddies in ${widget.Location}",
                  style: TextStyle(
                    fontFamily: "Rethink Sans",
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    height: 1.07,
                    color: Color(0xFF424242),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white.withOpacity(.000001),
      actions: [
        GestureDetector(
          onTap: () => GoRouter.of(context).go('/wallet'),
          child: Padding(
            padding: EdgeInsets.only(right: 8),
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: Image.asset('assets/homepage/walletIcon.png', scale: 4),
            ),
          ),
        ),
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          child: Image.asset('assets/homepage/notifIcon.png', scale: 4),
        ),
        Padding(
          padding: EdgeInsets.only(right: 20, left: 10),
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: Image.asset('assets/homepage/profilePic.png'),
          ),
        ),
      ],
    );
  }
}
