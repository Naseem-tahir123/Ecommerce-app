import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.amber,
      leading: IconButton(
        onPressed: () {},
        icon: const Column(
          children: [
            Icon(
              Icons.qr_code_scanner,
              size: 18,
            ),
            Text(
              "Scan",
              style: TextStyle(fontSize: 8),
            ),
          ],
        ),
      ),
      title: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          hintText: 'Search products...',
          hintStyle: const TextStyle(color: Colors.grey),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        ),
        onChanged: (value) {
          // Add your search logic here
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: const Column(
            children: [
              Icon(Icons.monetization_on),
              Text('Coins', style: TextStyle(fontSize: 10)),
            ],
          ),
          onPressed: () {
            // Add your coins icon onPressed logic here
          },
          color: Colors.black,
        ),
        IconButton(
          icon: const Column(
            children: [
              Icon(Icons.account_balance_wallet),
              Text('Wallet', style: TextStyle(fontSize: 10)),
            ],
          ),
          onPressed: () {
            // Add your wallet icon onPressed logic here
          },
          color: Colors.black,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
