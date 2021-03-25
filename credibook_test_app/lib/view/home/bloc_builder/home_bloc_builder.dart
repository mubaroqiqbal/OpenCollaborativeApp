import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:credibook_test_app/bloc/home_cubit.dart';
import 'package:credibook_test_app/data/data_repository.dart';

class HomeBlocBuilder{

  static final homeCubit = HomeCubit(DataRepository.getRepository());

  static HomeBlocBuilder instance(){
    HomeBlocBuilder instance = HomeBlocBuilder();
    return instance;
  }

  Widget buildResult(){
    return BlocBuilder(
        cubit: homeCubit,
        builder: (BuildContext context, HomeState state){
          if(state is HomeLoadedUsers){
            return Column(
              children: List.generate(state.responseUsers.length, (index) =>
                  GestureDetector(
                    onTap: (){
                      _onWidgetDidBuild((){
                        //Navigator.of(context).push(MaterialPageRoute(builder: (builder) => DetailUser(state.responseUsers[index])));
                      });
                      homeCubit.finish();
                    },
                    child: Container(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: state.responseUsers[index].avatarUrl!=null?
                          Image.network(state.responseUsers[index].avatarUrl) :
                          Container(
                            color: Colors.grey,
                          ),
                        ),
                        title: Text(state.responseUsers[index].login??"-"),
                        subtitle: Text(state.responseUsers[index].bio??""),
                      ),
                    ),
                  )
              ),
            );
          }

          if(state is HomeLoading){

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 100),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            );

          }

          if(state is HomeError){

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 100),
                  child: Image.asset("images/ilustrasi-error.png"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Text("Terjadi Kesalahan, silahkan coba beberapa saat lagi"),
                )
              ],
            );

          }

          if(state is HomeEmptyData){

            return Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 100),
                  child: Image.asset("images/empty-state.png"),
                )
              ],
            );

          }

          return Container();
        }
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

}