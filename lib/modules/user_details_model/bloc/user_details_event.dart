part of 'user_details_bloc.dart';

sealed class UserDetailsEvent {
  const UserDetailsEvent();
}

final class UserDetailsOpened extends UserDetailsEvent {
  const UserDetailsOpened();
}

final class UserDetailsFetched extends UserDetailsEvent {
  const UserDetailsFetched();
}
