class Strings {
  Strings._();

// base url of app
  static const String baseUrl =
      'https://getbitetime.myshopify.com/api/2021-04/graphql.json';
// api access token
  static const String accessToken = 'cda4fb2c7736fc030e88e093ed5e1aae';

//////######################
// get started screen
  static const String getStartButtonKey = 'get_start_button';
  static const String getStartButton = 'Get started';
// sign In screen
//
// email
  static const String signIn = 'SIGN IN';
  static const String emailKey = 'email';
  static const String emailTextHint = 'Email';
  static const String emailText = 'Email*';
  //
  //password
  static const String passwordKey = 'password';
  static const String passwordTextHint = 'Password';
  static const String passwordText = 'Password*';
  //
  // sign in button
  static const String signInButtonKey = 'login_button';
  static const String signInButton = 'Sign in';
  // forgot password
  static const forgotPasswordButton = 'Forgot password?';
  static const donthaveAcc = "Don't have an account? ";
  static const createAcc = 'Create account';
  //###########################
  //validator error
  static const String emailIsEmpty = "Enter email address";
  static const String validEmail = 'Enter a valid email address';
  static const String passwordIsEmpty = 'Enter password';
  static const String validpassword = 'Password length must be 6 character';

  //@@@@@@@@@@@@@@@@@@@@@
  //register Page Text
  static const String signUpText = 'SIGN UP';
  static const String firstNameHint = 'First name';
  static const String lastNameHint = 'Last name';
  static const String firstName = 'First name*';
  static const String lastName = 'Last name*';
  static const String submit = 'Submit';
  static const String privacyText =
      'By clicking create account, you agree to our terms of service and privacy policy.';
  static const String alreadyAccount = 'Already have an account?';
  static const String signInButtonInSignUp = 'Sign in';
  //#######################
  //validator error
  static const String fNmaeIsEmpty = "Enter first name";
  static const String lNameIsEmpty = "Enter last name";
  //###########################

  //Add Address
  static const String labelCon = "Company (optional)";
  static const String labelConHint = "Company";
  static const String addressCon = "Address*";
  static const String address2Con = "Address 2";
  static const String addressConHint = "Address";
  static const String address2ConHint = "Address2";
  static const String cityCon = "City*";
  static const String cityConHint = "City";
  static const String selectedState = "SelectedState";
  static const String zipCon = "Zip";
  static const String zipConHint = "Zip";
  static const String phoneCon = "Phone (optional)";
  static const String phoneConHint = "Phone Number";
  static const dynamic hraders = {
    'Accept': 'application/json',
    'X-Shopify-Storefront-Access-Token': 'cda4fb2c7736fc030eh88e093ed5e1aae',
    'Content-Type': 'application/json',
    'Authorization':
        'Basic ZmNmN2MyYzI3MzAyZTk2MDVkZmM2ZmRjYmE4MjUxMjU6c2hwcGFfhZjMxMTQyZTI2MGM4MmIzZjQ1ZDg1N2Q2YzI4MjgwYTY=',
  };
}
