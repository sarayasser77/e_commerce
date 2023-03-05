abstract class CommerceState{}
class InitialState extends CommerceState{}
class ChangeBottomNavBarState extends CommerceState{}
class GetUserDataSuccessState extends CommerceState{}
class GetUserDataloadingState extends CommerceState{}
class GetUserDataFaildState extends CommerceState{
  String? message;
  GetUserDataFaildState(this.message){}
}