abstract class CommerceState{}
class InitialState extends CommerceState{}
class ChangeBottomNavBarState extends CommerceState{}
class GetUserDataSuccessState extends CommerceState{}
class GetUserDataloadingState extends CommerceState{}
class GetUserDataFaildState extends CommerceState{
  String? message;
  GetUserDataFaildState(this.message);
}
class GetBannerSuccessState extends CommerceState{}
class GetBannerLoadingState extends CommerceState{}
class GetBannerFailureState extends CommerceState{
  String?error;
  GetBannerFailureState(this.error);
}
class GetCategorySuccessState extends CommerceState{}
class GetCategoryLoadingState extends CommerceState{}
class GetCategoryFailureState extends CommerceState{
}
class GetProductsSuccessState extends CommerceState{}
class GetProductsLoadingState extends CommerceState{}
class GetProductsFailureState extends CommerceState{}
class GetFavoritesLoadingState extends CommerceState{}
class GetFavoritesSuccessState extends CommerceState{}
class GetFavoritesFailureState extends CommerceState{}
class AddOrRemoveFromFavoritesSuccessState extends CommerceState{}
class AddOrRemoveFromFavoritesLoadingState extends CommerceState{}
class AddOrRemoveFromFavoritesFailureState extends CommerceState{}


