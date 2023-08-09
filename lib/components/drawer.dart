import 'package:flutter/material.dart';
import 'package:uniplay/components/my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  // final void Function()? onSignOut;
  const MyDrawer(
      {super.key,
      required this.onProfileTap}); // depois colocar required this.onSignOut

  @override
  Widget build(BuildContext context) {
    // barra da esquerda
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        children: [
          // header
          const DrawerHeader(
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 60,
            ),
          ),

          // home list tile
          MyListTile(
            icon: Icons.home,
            text: 'H O M E',
            onTap: () => Navigator.pop(context),
          ),

          // profile list tile
          MyListTile(
            icon: Icons.person_2,
            text: 'P R O F I L E',
            onTap: onProfileTap,
          ),

          // logout list tile
          /*
          MyListTile(
            icon: Icons.person_2,
            text: 'L O G O U T',
            onTap: onSignOut,
          )
          */
        ],
      ),
    );
  }
}
