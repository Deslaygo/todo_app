import 'package:flutter/material.dart';
import 'package:todo_app/utils/app_assets.dart';

class HeaderHome extends StatelessWidget {
  final String currentDate;
  const HeaderHome({Key? key, this.currentDate = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            currentDate,
            style: Theme.of(context).textTheme.headline1,
          ),
          CircleAvatar(
            backgroundColor: Colors.grey[100],
            radius: 32,
            child: Image.asset(
              AppAssets.defaultUser,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}
