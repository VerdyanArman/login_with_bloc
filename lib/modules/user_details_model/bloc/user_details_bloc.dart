import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login/isar/db.dart';
import 'package:login/user_model.dart';

part 'user_details_event.dart';
part 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  final String email;

  UserDetailsBloc({required this.email}) : super(const UserDetailsInitial()) {
    on<UserDetailsOpened>(_opened);
    on<UserDetailsFetched>(_fetched);
  }

  void _opened(UserDetailsOpened event, Emitter<UserDetailsState> emit) {
    emit(const UserDetailsLoading());
  }

  void _fetched(
      UserDetailsFetched event, Emitter<UserDetailsState> emit) async {
    emit(const UserDetailsLoading());

    final user = await DB.getUser(email);

    emit(UserDetailsReady(user: user));
  }
}
