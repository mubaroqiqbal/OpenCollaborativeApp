import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:github/github.dart';
import 'package:credibook_test_app/data/data_repository.dart';
import 'package:credibook_test_app/data/model/open_collective_user.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final DataRepository _dataRepository;
  static int dataLength=0;

  HomeCubit(this._dataRepository) : super(HomeInitial());

  Future<void> getUsers(int page) async {
    try {
      final data = await _dataRepository.getUser(page);

      if(data.length<=0){
        emit(HomeEmptyData("Data Tidak Ditemukan"));
      }else{
        emit(HomeLoadedUsers(data));
      }
    } on GitHubError{
      emit(HomeError("Terjadi kesalahan, silahkan coba beberapa saat lagi"));
    } on SocketException {
      emit(HomeError("Please Check Your Internet Or Try Again Later"));
    } on Exception catch(e){
      emit(HomeError(e.toString().replaceFirst("Exception: ", "")));
    }
  }

  Future<void> getUsersHttp() async {
    try {
      final data = await _dataRepository.getUserHttp();

    } on GitHubError{
      emit(HomeError("Terjadi kesalahan, silahkan coba beberapa saat lagi"));
    } on SocketException {
      emit(HomeError("Please Check Your Internet Or Try Again Later"));
    } on Exception catch(e){
      emit(HomeError(e.toString().replaceFirst("Exception: ", "")));
    }
  }

  Future<void> getOpenCollectiveUser() async {
    try {
      emit(HomeLoading());
      final data = await _dataRepository.getListOpenCollectiveUser();

      if(data.length<=0){
        emit(HomeEmptyData("Data Tidak Ditemukan"));
      }else{
        emit(OpenCollectiveuserLoaded(data));
      }

    } on GitHubError{
      emit(HomeError("Terjadi kesalahan, silahkan coba beberapa saat lagi"));
    } on SocketException {
      emit(HomeError("Please Check Your Internet Or Try Again Later"));
    } on Exception catch(e){
      emit(HomeError(e.toString().replaceFirst("Exception: ", "")));
    }
  }

  Future<void> finish() async{
    emit(HomeInitial());
  }

}