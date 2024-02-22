part of 'user_details_bloc.dart';

sealed class UserDetailsState extends Equatable {
  final bool isLoading;

  const UserDetailsState({this.isLoading = true});

  @override
  List<Object?> get props => [];
}

final class UserDetailsInitial extends UserDetailsState {
  const UserDetailsInitial();
  @override
  bool get isLoading => true;
}

final class UserDetailsLoading extends UserDetailsState {
  const UserDetailsLoading();

  @override
  bool get isLoading => true;
}

final class UserDetailsReady extends UserDetailsState {
  final UserModel user;

  const UserDetailsReady({required this.user});

  @override
  bool get isLoading => false;
}
