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
class GetCartsLoadingState extends CommerceState{}
class GetCartsSuccessState extends CommerceState{}
class GetCartsFailureState extends CommerceState{}
class AddOrRemoveFromFavoritesSuccessState extends CommerceState{}
class AddOrRemoveFromFavoritesLoadingState extends CommerceState{}
class AddOrRemoveFromFavoritesFailureState extends CommerceState{}
class AddOrRemoveFromCartSuccessState extends CommerceState{}
class AddOrRemoveFromCartLoadingState extends CommerceState{}
class AddOrRemoveFromCartFailureState extends CommerceState{}
class FilterProductsSuccessState extends CommerceState{}
class ChangePasswordSuccessState extends CommerceState{}
class ChangePasswordLoadingState extends CommerceState{}
class FailedToChangePasswordState extends CommerceState{}

class UpdateUserDataSuccessState extends CommerceState{}
class UpdateUserDataLoadingState extends CommerceState{}
class FailedToUpdateUserDataState extends CommerceState{}



