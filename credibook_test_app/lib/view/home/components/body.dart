import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:credibook_test_app/base_var/const_color.dart';
import 'package:credibook_test_app/bloc/home_cubit.dart';
import 'package:credibook_test_app/view/detail/detail_screen.dart';
import 'package:credibook_test_app/view/home/bloc_builder/home_bloc_builder.dart';
import 'package:credibook_test_app/view/home/components/item_card.dart';
import 'package:credibook_test_app/view/home/home.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ScrollController _controller = new  ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
  }

  _scrollListener() {
    try{
      if (_controller.offset >= _controller.position.maxScrollExtent-10 &&
          !_controller.position.outOfRange) {
        debugPrint("reach the bottom");

        if(Home.currentPage<=(Home.listLength/20).ceil()){

          Home.currentPage++;

          setState(() {});
        }
      }
    } catch (e, s) {
      debugPrint("error = "+e.toString());
      debugPrint("error = "+s.toString());
    }
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: BlocBuilder(
              cubit: HomeBlocBuilder.homeCubit,
              builder: (BuildContext context, HomeState state){

                if(state is OpenCollectiveuserLoaded){

                  if(state.listUsers.length>0){
                    Home.listLength=state.listUsers.length;
                  }

                  return ListView.builder(
                      controller: _controller,
                      itemCount: (state.listUsers.length/(state.listUsers.length/20)).ceil()*Home.currentPage,
                      itemBuilder: (context, index) {
                        return index<state.listUsers.length?
                        ItemCard(
                          user: state.listUsers[index],
                          press: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                  user: state.listUsers[index],
                                ),
                              )),
                        ) : Container();
                      }
                  );
                }
                if(state is HomeLoading){

                  return Center(
                    child: CircularProgressIndicator(),
                  );

                }

                return Container();
              })
        ),
      ],
    );
  }
}
