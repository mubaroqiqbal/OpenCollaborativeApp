part of 'home_cubit.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoadedUsers extends HomeState {

  final List<User> responseUsers;

  const HomeLoadedUsers(this.responseUsers);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is HomeLoadedUsers && o.responseUsers == responseUsers;
  }

  @override
  int get hashCode => responseUsers.hashCode;
}

class OpenCollectiveuserLoaded extends HomeState {

  final List<OpenCollectiveUser> listUsers;

  const OpenCollectiveuserLoaded(this.listUsers);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is OpenCollectiveuserLoaded && o.listUsers == listUsers;
  }

  @override
  int get hashCode => listUsers.hashCode;
}

class HomeError extends HomeState {

  final String message;
  const HomeError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is HomeError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class HomeEmptyData extends HomeState {

  final String message;
  const HomeEmptyData(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is HomeEmptyData && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}