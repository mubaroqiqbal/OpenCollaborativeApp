import 'package:credibook_test_app/data/model/open_collective_user.dart';
import 'package:flutter/material.dart';
import 'package:credibook_test_app/base_var/const_color.dart';
import 'package:credibook_test_app/view/detail/components/body.dart';

class DetailsScreen extends StatefulWidget {
  final OpenCollectiveUser user;

  const DetailsScreen({Key key, this.user}) : super(key: key);

  @override
  _DetailsScreen createState() => _DetailsScreen(user: user);
}

class _DetailsScreen extends State<DetailsScreen>{
  final OpenCollectiveUser user;

  _DetailsScreen({Key key, this.user});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: buildAppBar(context),
      body: Body(user: user),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: appBarColor,
      centerTitle: false,
      elevation: 0,
      titleSpacing: 0,
      leading: IconButton(icon:Icon(Icons.arrow_back_ios), color: textColor,
        onPressed:() => Navigator.pop(context),
      ),
      title: Text(
        "Detail User",
        style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
      ),
    );
  }
}
