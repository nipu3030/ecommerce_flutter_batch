abstract class UserEvent {}

class LoginUserEvent extends UserEvent{
  String email,password;
  LoginUserEvent({required this.password,required this.email});
}

class RegisterUserEvent extends UserEvent{
  String email,name,mobNo,password;
  RegisterUserEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.mobNo
});
}


class FetchUserDetails extends UserEvent{}