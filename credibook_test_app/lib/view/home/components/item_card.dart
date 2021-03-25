import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:credibook_test_app/base_var/const_color.dart';
import 'package:credibook_test_app/data/model/open_collective_user.dart';

class ItemCard extends StatelessWidget {
  final OpenCollectiveUser user;
  final Function press;

  const ItemCard({
    Key key,
    this.user,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: defaultPadding),
        child: Container(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              child: user.image!=null?
              Image.network(user.image) :
              Container(
                color: Colors.grey,
              ),
            ),
            title: Text(user.name??"No Name"),
            //subtitle: Text(user.bio??""),
          ),
        )
      ),
    );
  }
}
