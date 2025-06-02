class UrlContainer {
  static const String domainUrl = 'https://estraha.maher.website';

  static const String baseUrl = '$domainUrl/api/';

  static const String socialLoginEndPoint = 'social-login';

  static const String homeEndPoint = 'home';
  static const String searchDestinationEndPoint = 'search-cities';
  static const String searchEndPoint = 'hotel/search';
  static const String filterByCityEndPoint = 'hotel/filter-by-city';
  static const String filterPramEndPoint = 'hotel/filter-parameters';
  static const String hotelDetailEndPoint = 'hotel/detail/';
  static const String popularHotelEndPoint = 'popular-hotels';
  static const String featuredHotelEndPoint = 'featured-hotels';
  static const String popularCityEndPoint = 'popular-cities';
  static const String bookingRequestEndPoint = 'booking-request/send';
  static const String bookingHistoryEndPoint = 'booking/history';
  static const String bookingDetailsEndPoint = 'booking/detail';
  static const String paymentHistoryEndPoint = 'payment/history';
  static const String bookingRequestHistoryEndPoint = 'booking-request/history';
  static const String cancelBookingEndPoint = 'booking-request/delete';
  static const String socialLogin = 'social-login';
  static const String notificationEndPoint = 'push-notifications';
  static const String countryFlagImageLink =
      'https://flagpedia.net/data/flags/h24/{countryCode}.webp';

  static const String imageUrl = '$domainUrl/assets/images';

  static const String dashBoardEndPoint = 'dashboard';
  static const String depositHistoryUrl = 'deposit/history';
  static const String depositMethodUrl = 'payment/methods';
  static const String depositInsertUrl = 'payment/insert';

  static const String registrationEndPoint = 'register';
  static const String loginEndPoint = 'login';
  static const String logoutUrl = 'logout';
  static const String deleteAccountEndPoint = 'delete-account';
  static const String forgetPasswordEndPoint = 'password/email';
  static const String passwordVerifyEndPoint = 'password/verify-code';
  static const String resetPasswordEndPoint = 'password/reset';
  static const String verify2FAUrl = 'verify-g2fa';

  static const String otpVerify = 'otp-verify';
  static const String otpResend = 'otp-resend';
  static const String verifyEmailEndPoint = 'verify-email';
  static const String verifySmsEndPoint = 'verify-mobile';
  static const String resendVerifyCodeEndPoint = 'resend-verify/';
  static const String authorizationCodeEndPoint = 'authorization';
  static const String dashBoardUrl = 'dashboard';
  static const String transactionEndpoint = 'transactions';

  static const String addWithdrawRequestUrl = 'withdraw-request';
  static const String withdrawMethodUrl = 'withdraw-method';
  static const String withdrawRequestConfirm = 'withdraw-request/confirm';
  static const String withdrawHistoryUrl = 'withdraw/history';
  static const String withdrawStoreUrl = 'withdraw/store/';
  static const String withdrawConfirmScreenUrl = 'withdraw/preview/';
  static const String kycFormUrl = 'kyc-form';
  static const String kycSubmitUrl = 'kyc-submit';
  static const String generalSettingEndPoint = 'general-setting';
  static const String privacyPolicyEndPoint = 'policies';
  static const String getProfileEndPoint = 'user-info';
  static const String updateProfileEndPoint = 'profile-setting';
  static const String profileCompleteEndPoint = 'user-data-submit';
  static const String changePasswordEndPoint = 'change-password';
  static const String countryEndPoint = 'get-countries';

  static const String twoFactor = "twofactor";
  static const String twoFactorEnable = "twofactor/enable";
  static const String twoFactorDisable = "twofactor/disable";

  static const String deviceTokenEndPoint = 'add-device-token';
  static const String languageUrl = 'language/';

  //support ticket
  static const String communityGroupsEndPoint = 'community-groups';
  static const String supportMethodsEndPoint = 'support/method';
  static const String supportListEndPoint = 'ticket';
  static const String storeSupportEndPoint = 'ticket/create';
  static const String supportViewEndPoint = 'ticket/view';
  static const String supportReplyEndPoint = 'ticket/reply';
  static const String supportCloseEndPoint = 'ticket/close';
  static const String supportDownloadEndPoint = 'ticket/download';
  static const String supportImagePath = '$domainUrl/assets/support/';

  static const String faqEndPoint = 'faq';
}
