import 'dart:async';

import 'package:flutter/material.dart';
import 'package:credibook_test_app/base_var/const_color.dart';
import 'package:credibook_test_app/view/home/bloc_builder/home_bloc_builder.dart';
import 'package:credibook_test_app/view/home/components/body.dart';

class Home extends StatefulWidget {

  static int listLength=0;
  static int currentPage=1;

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home>{
  final StreamController<bool> streamController = StreamController<bool>.broadcast();

  @override
  void initState() {
    super.initState();

    HomeBlocBuilder.homeCubit.getOpenCollectiveUser();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0,
        titleSpacing: 0,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: GestureDetector(
            onTap: (){
            },
            child: Text(
              "Open Collective User List",
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontWeight: FontWeight.bold, color: textColor),
            ),
          ),
        ),
      ),
      backgroundColor: bgColor,
      body: Body(),
    );
  }

}
