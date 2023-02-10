class AppUrl {
  static const uploadUrl = 'https://timviecnhanhnhat.vn/api/upload';
  static const connectionTimeout = 15000;
  static const receiveTimeout = 15000;
  // static const baseUrl = 'http://116.193.76.26:1608';

  static const baseUrl = 'http://116.193.76.26:1708';

  static const baseApi = '$baseUrl/api/v1';

  static const refreshToken = '$baseApi/auth/refreshToken';

  static const loginAuth = '$baseApi/login';

  static const uploadAvatar = '$baseApi/profile/avatar';
  static const profileAuth = '$baseApi/profile';
  static const profileUpdate = '$baseApi/profile/update';

  static const product = '$baseApi/products';

  static const listCategory = '$baseApi/categories';

  static const urlPhotoProduct = '$baseUrl/';

  static const getComments = '$baseApi/reviews?productId=';
  static const addComment = '$baseApi/reviews/add';
  static const getCoupons = '$baseApi/coupon/list';
  static const uploadPhotoComment = '$baseApi/reviews/upload';

  static const getListFavourites = '$baseApi/favourites?userId=';
  static const deleteFavourites = '$baseApi/favourites/delete?productId=';
  static const addFavourites = '$baseApi/favourites/add?productId=';

  static const addCart = '$baseApi/cart/add?userId=';
  static const listCart = '$baseApi/cart?userId=';
  static const deleteCart = '$baseApi/cart/delete?userId=';
  static const editCart = '$baseApi/cart/edit?userId=';

  static const productDetail = '$baseApi/products/detail';
  static const userProfile = '$baseApi/profile/';
  static const orderList = '$baseApi/order/';
  static const orderDetail = '$baseApi/order/detail';

  // Address
  static const layTinh = '$baseApi/place/provinces';
  static const layQuan = '$baseApi/place/district-by-province-id';
  static const layPhuong = '$baseApi/place/ward-by-district-id';
  static const listAddress = '$baseApi/address';
  static const addAddress = '$baseApi/address/add';
  static const updateAddress = '$baseApi/address/edit';
  static const deleteAddress = '$baseApi/address/delete';
  static const getAddressDetail = '$baseApi/address/view';
  static const resetAddressDefault = '$baseApi/address/set-default';
}
