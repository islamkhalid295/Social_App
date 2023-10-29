class AppStates  {}

class InitState extends AppStates {}

class LoginSucssesState extends AppStates {}

class LoginErorrState extends AppStates {
  var error;

  LoginErorrState(this.error);
}

class RegisterSucssesState extends AppStates {}

class RegisterErorrState extends AppStates {
  var error;

  RegisterErorrState(this.error);
}

class CreateUserLodingState extends AppStates {}

class CreateUserSucssesState extends AppStates {}

class CreateUserErorrState extends AppStates {
  var error;

  CreateUserErorrState(this.error);
}

class LodingState extends AppStates {}

class LodingGetProfileState extends AppStates {}

class GetProfileDataSucssesState extends AppStates {}

class GetProfileDataErorrState extends AppStates {
  var error;

  GetProfileDataErorrState(this.error);
}

class LodingGetUserState extends AppStates {}

class GetUserDataSucssesState extends AppStates {}

class GetUserDataErorrState extends AppStates {
  var error;

  GetUserDataErorrState(this.error);
}

class NavBarChangeState extends AppStates {}

class updateProfileDataLodingState extends AppStates {}

class updateProfileDataSuccessState extends AppStates {}

class updateProfileDataErrorState extends AppStates {}

class RemovePostImageState extends AppStates {}

class GetPostImageLodingState extends AppStates {}

class GetPostImageSuccessState extends AppStates {}

class GetPostImageErrorState extends AppStates {}

class AddNewPostLodingState extends AppStates {}

class AddNewPostSuccessState extends AppStates {}

class AddNewPostErrorState extends AppStates {}

