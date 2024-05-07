---
title: Flutter backend - mobile authentication
description: Flutter backend - mobile authentication
---
ユーザー認証に関する知識を学習します。

はじめにいろんな認証の仕組みについて概要を把握しましょう。

その後、スマホアプリで必要になる、OAuth、JWTについて学びます。

スマホアプリは、ログイン後の認証状態をトークンで連携するのが一般的ですが、
Flutterでトークンを保存する際にも使われるshared_preferencesプラグインを試します。

__ここで学ぶこと__
1. システム認証（Web・アプリ）の種類
2. OAuth、JWT
3. OAuth関連のコード例
4. [shared_preferencesプラグイン](https://docs.flutter.dev/cookbook/persistence/key-value)を使ったハンズオン

---

## 1 システム認証（Web・アプリ）の種類
システム認証（Web・アプリ）を把握しましょう

- [記事1 今さら聞けない認証方法まとめ](https://qiita.com/Marusoccer/items/1c597dd91f4446509b61)


## 2 OAuth、JWT
OAuth
- [記事2 OAuthとは？その仕組みを徹底解説〜便利と危険は裏返し〜](https://www.tdk.com/ja/tech-mag/knowledge/147)

- [記事3 ユーザー認証とは？ウェブやAPIでの認証の仕組みや設計を解説します](https://applis.io/posts/how-to-authenticate-user)

## 3 OAuthを使ったログイン処理のコード例
以降で実際によくあるサンプルコードを記載します。GitHub Copilotが提示したものですのであくまでご参考として。

### 3.1 Google

1. **Create a project in the Google Cloud Console:**
   - Go to the [Google Cloud Console](https://console.cloud.google.com/).
   - Create a new project.
   - Enable the Google Sign-In API for your project.
   - Create OAuth client ID credentials for your project. You'll need the client ID and client secret for your app.

2. **Install the Google Sign-In Flutter plugin:**
   - Add the `google_sign_in` package to your `pubspec.yaml` file:
     ```yaml
     dependencies:
       flutter:
         sdk: flutter
       google_sign_in: ^5.2.1
     ```
   - Run `flutter pub get` to fetch the package.

3. **Implement Google Sign-In in your app:**
   - Import the `google_sign_in` package in your Dart file:
     ```dart
     import 'package:google_sign_in/google_sign_in.dart';
     ```
   - Create a new instance of `GoogleSignIn`:
     ```dart
     final GoogleSignIn googleSignIn = GoogleSignIn();
     ```
   - Create a function to handle the sign-in process:
     ```dart
     Future<void> _handleSignIn() async {
       try {
         await googleSignIn.signIn();
       } catch (error) {
         print(error);
       }
     }
     ```
   - Call `_handleSignIn` when the user taps a button:
     ```dart
     ElevatedButton(
       onPressed: _handleSignIn,
       child: Text('Sign in with Google'),
     )
     ```

4. **Send the Google Sign-In token to your backend:**
   - After the user signs in, you can obtain a Google Sign-In token:
     ```dart
     final GoogleSignInAccount? account = await googleSignIn.signIn();
     final GoogleSignInAuthentication auth = await account?.authentication;
     final String? idToken = auth.idToken;
     ```
   - Send this token to your backend server. Your server should verify the token and use it to establish a session or generate a JWT for the user.

Remember, this is just a basic example. You'll need to handle sign-out, error conditions, and other aspects of the user experience. Also, if you're implementing sign-in with other providers (like Facebook or Twitter), the process will be similar, but you'll need to use different Flutter packages and APIs.


### 3.2 Apple

1. **Create an Apple ID for Developers:**
   - Go to the [Apple Developer Program](https://developer.apple.com/programs/).
   - Enroll in the program with your Apple ID.
   - Enable Sign in with Apple for your app ID in the Certificates, Identifiers & Profiles section.

2. **Install the `sign_in_with_apple` package:**
   - Add the `sign_in_with_apple` package to your `pubspec.yaml` file:
     ```yaml
     dependencies:
       flutter:
         sdk: flutter
       sign_in_with_apple: ^3.1.0
     ```
   - Run `flutter pub get` to fetch the package.

3. **Configure your Flutter app:**
   - Follow the [iOS](https://developer.apple.com/documentation/signinwithapplerestapi) setup instructions in the Sign in with Apple documentation to configure your app.

4. **Implement Apple Sign-In in your app:**
   - Import the `sign_in_with_apple` package in your Dart file:
     ```dart
     import 'package:sign_in_with_apple/sign_in_with_apple.dart';
     ```
   - Create a function to handle the sign-in process:
     ```dart
     Future<void> _loginWithApple() async {
       try {
         final credential = await SignInWithApple.getAppleIDCredential(
           scopes: [
             AppleIDAuthorizationScopes.email,
             AppleIDAuthorizationScopes.fullName,
           ],
         );
         // This is the user identity token
         print(credential.identityToken);
       } catch (error) {
         print('Error occurred during login: $error');
       }
     }
     ```
   - Call `_loginWithApple` when the user taps a button:
     ```dart
     ElevatedButton(
       onPressed: _loginWithApple,
       child: Text('Sign in with Apple'),
     )
     ```

5. **Send the Apple Sign-In token to your backend:**
   - After the user signs in, you can obtain an Apple Sign-In token.
   - Send this token to your backend server. Your server should verify the token and use it to establish a session or generate a JWT for the user.

Remember, this is a basic example. You'll need to handle sign-out, error conditions, and other aspects of the user experience. Also, note that Apple Sign-In requires iOS 13.0 or later, or macOS 10.15 or later.


### 3.3 Microsoft

1. **Create a Microsoft App Registration:**
   - Go to the [Azure portal](https://portal.azure.com/).
   - Create a new App Registration.
   - Enable the "Mobile and desktop applications" platform for your app.
   - Note down the Client ID and Tenant ID.

2. **Install the `msal_flutter` package:**
   - Add the `msal_flutter` package to your `pubspec.yaml` file:
     ```yaml
     dependencies:
       flutter:
         sdk: flutter
       msal_flutter: ^1.0.1
     ```
   - Run `flutter pub get` to fetch the package.

3. **Configure your Flutter app:**
   - Follow the [Android](https://docs.microsoft.com/en-us/azure/active-directory/develop/quickstart-v2-android) and [iOS](https://docs.microsoft.com/en-us/azure/active-directory/develop/quickstart-v2-ios) setup instructions in the Microsoft Identity Platform documentation to configure your app.

4. **Implement Microsoft Sign-In in your app:**
   - Import the `msal_flutter` package in your Dart file:
     ```dart
     import 'package:msal_flutter/msal_flutter.dart';
     ```
   - Create a new instance of `PublicClientApplication`:
     ```dart
     final pca = PublicClientApplication.createPublicClientApplication(
       '<Your Client ID>', // Replace with your client ID
       authority: 'https://login.microsoftonline.com/<Your Tenant ID>', // Replace with your tenant ID
     );
     ```
   - Create a function to handle the sign-in process:
     ```dart
     Future<void> _loginWithMicrosoft() async {
       try {
         final result = await pca.acquireToken(interactiveParameters: InteractiveParameters(scopes: ['User.Read']));
         final String? accessToken = result.accessToken;
         if (accessToken != null) {
           // The user logged in successfully, now send the token to your backend
           print('Access token: $accessToken');
         }
       } catch (error) {
         print('Error occurred during login: $error');
       }
     }
     ```
   - Call `_loginWithMicrosoft` when the user taps a button:
     ```dart
     ElevatedButton(
       onPressed: _loginWithMicrosoft,
       child: Text('Sign in with Microsoft'),
     )
     ```

5. **Send the Microsoft Sign-In token to your backend:**
   - After the user signs in, you can obtain a Microsoft Sign-In token.
   - Send this token to your backend server. Your server should verify the token and use it to establish a session or generate a JWT for the user.

Remember, this is a basic example. You'll need to handle sign-out, error conditions, and other aspects of the user experience.


### 3.4 Instagram

1. **Create an Instagram App**: Go to the [Facebook Developers site](https://developers.facebook.com/) and create a new app. Under "Products", add "Instagram Basic Display", and fill in the necessary details.

2. **Get Instagram App ID and App Secret**: After setting up the app, you'll get an Instagram App ID and App Secret. You'll need these for authentication.

3. **Set up a redirect URI**: In the app settings, set a redirect URI. This is where Instagram will redirect users after they authenticate.

4. **Implement Instagram Sign-In in Flutter**: You can use the `url_launcher` package to open the Instagram login page, and the `uni_links` package to handle the redirect URI. Here's a basic example:

```dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uni_links/uni_links.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: RaisedButton(
            onPressed: () async {
              const

 String

 clientId = 'YOUR_INSTAGRAM_APP_ID';
              const String redirectUri = 'YOUR_REDIRECT_URI';
              final String url = 'https://api.instagram.com/oauth/authorize'
                  '?client_id=$clientId'
                  '&redirect_uri=$redirectUri'
                  '&scope=user_profile,user_media'
                  '&response_type=code';

              if (await canLaunch(url)) {
                await launch(url);
              }
            },
            child: Text('Sign in with Instagram'),
          ),
        ),
      ),
    );
  }
}

void handleLinks() async {
  final Uri? initialLink = await getInitialUri();

  if (initialLink != null) {
    // Handle the initial link
  }

  getUriLinksStream().listen((Uri? uri) {
    if (uri != null) {
      // Handle the link
    }
  });
}
```

In this code, replace `'YOUR_INSTAGRAM_APP_ID'` and `'YOUR_REDIRECT_URI'` with your actual Instagram App ID and redirect URI.

When the user taps the "Sign in with Instagram" button, they'll be taken to the Instagram login page. After they authenticate, they'll be redirected to your redirect URI. You can handle this redirect with the `handleLinks` function.

Please note that this is a basic example and doesn't include error handling or storing the access token. You'll need to add these in a production app.

### 3.5 LINE

1. **Create a LINE Login Channel:**
   - Go to the [LINE Developers Console](https://developers.line.biz/console/).
   - Create a new provider and a LINE Login channel.
   - Note down the Channel ID and Channel Secret.

2. **Install the `flutter_line_sdk` package:**
   - Add the `flutter_line_sdk` package to your `pubspec.yaml` file:
     ```yaml
     dependencies:
       flutter:
         sdk: flutter
       flutter_line_sdk: ^1.2.1
     ```
   - Run `flutter pub get` to fetch the package.

3. **Configure your Flutter app:**
   - Follow the [Android](https://developers.line.biz/en/docs/android-sdk/integrate-line-login/#add-channel-id-to-manifest-file) and [iOS](https://developers.line.biz/en/docs/ios-sdk/swift/integrate-line-login/#add-url-schemes) setup instructions in the LINE SDK documentation to configure your app.

4. **Implement LINE Sign-In in your app:**
   - Import the `flutter_line_sdk` package in your Dart file:
     ```dart
     import 'package:flutter_line_sdk/flutter_line_sdk.dart';
     ```
   - Initialize the LINE SDK:
     ```dart
     LineSDK.instance.setup("${Your Channel ID}").then((_) {
       print("LineSDK Prepared");
     });
     ```
   - Create a function to handle the sign-in process:
     ```dart
     Future<void> _loginWithLine() async {
       try {
         final result = await LineSDK.instance.login();
         print(result.accessToken.value);
       } catch (error) {
         print('Error occurred during login: $error');
       }
     }
     ```
   - Call `_loginWithLine` when the user taps a button:
     ```dart
     ElevatedButton(
       onPressed: _loginWithLine,
       child: Text('Sign in with LINE'),
     )
     ```

5. **Send the LINE Sign-In token to your backend:**
   - After the user signs in, you can obtain a LINE Sign-In token.
   - Send this token to your backend server. Your server should verify the token and use it to establish a session or generate a JWT for the user.

Remember, this is a basic example. You'll need to handle sign-out, error conditions, and other aspects of the user experience. Also, note that LINE Sign-In requires LINE 9.8.0 or later for iOS and LINE 10.1.1 or later for Android.

### 3.6 Facebook

1. **Create a Facebook App:**
   - Go to the [Facebook Developers](https://developers.facebook.com/) site.
   - Create a new app.
   - Add the Facebook Login product to your app.
   - Note down the App ID.

2. **Install the `flutter_facebook_auth` package:**
   - Add the `flutter_facebook_auth` package to your `pubspec.yaml` file:
     ```yaml
     dependencies:
       flutter:
         sdk: flutter
       flutter_facebook_auth: ^3.5.6
     ```
   - Run `flutter pub get` to fetch the package.

3. **Configure your Flutter app:**
   - Follow the [Android](https://developers.facebook.com/docs/facebook-login/android) and [iOS](https://developers.facebook.com/docs/facebook-login/ios) setup instructions in the Facebook Login documentation to configure your app.

4. **Implement Facebook Login in your app:**
   - Import the `flutter_facebook_auth` package in your Dart file:
     ```dart
     import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
     ```
   - Create a function to handle the login process:
     ```dart
     Future<void> _loginWithFacebook() async {
       try {
         final LoginResult result = await FacebookAuth.instance.login();
         if (result.status == LoginStatus.success) {
           // The user logged in successfully, now send the token to your backend
           final AccessToken? accessToken = result.accessToken;
           print('Access token: ${accessToken?.token}');
         }
       } catch (error) {
         print('Error occurred during login: $error');
       }
     }
     ```
   - Call `_loginWithFacebook` when the user taps a button:
     ```dart
     ElevatedButton(
       onPressed: _loginWithFacebook,
       child: Text('Login with Facebook'),
     )
     ```

5. **Send the Facebook Login token to your backend:**
   - After the user logs in, you can obtain a Facebook Login token.
   - Send this token to your backend server. Your server should verify the token and use it to establish a session or generate a JWT for the user.

Remember, this is a basic example. You'll need to handle logout, error conditions, and other aspects of the user experience.

### 3.7 Twitter

1. **Create a Twitter App:**
   - Go to the [Twitter Developer Portal](https://developer.twitter.com/en/portal/dashboard).
   - Create a new app.
   - Enable the Twitter Login product for your app.
   - Note down the API Key and API Secret Key.

2. **Install the `flutter_twitter_login` package:**
   - Add the `flutter_twitter_login` package to your `pubspec.yaml` file:
     ```yaml
     dependencies:
       flutter:
         sdk: flutter
       flutter_twitter_login: ^1.1.0
     ```
   - Run `flutter pub get` to fetch the package.

3. **Configure your Flutter app:**
   - Follow the [Android](https://developer.twitter.com/en/docs/authentication/guides/log-in-with-twitter) and [iOS](https://developer.twitter.com/en/docs/authentication/guides/log-in-with-twitter) setup instructions in the Twitter Login documentation to configure your app.

4. **Implement Twitter Login in your app:**
   - Import the `flutter_twitter_login` package in your Dart file:
     ```dart
     import 'package:flutter_twitter_login/flutter_twitter_login.dart';
     ```
   - Create a new instance of `TwitterLogin`:
     ```dart
     final TwitterLogin twitterLogin = TwitterLogin(
       consumerKey: '<Your Consumer Key>',
       consumerSecret: '<Your Consumer Secret>',
     );
     ```
   - Create a function to handle the login process:
     ```dart
     Future<void> _loginWithTwitter() async {
       final TwitterLoginResult result = await twitterLogin.authorize();
       switch (result.status) {
         case TwitterLoginStatus.loggedIn:
           // Get the token and secret for session authentication
           String token = result.session.token;
           String secret = result.session.secret;
           break;
         case TwitterLoginStatus.cancelledByUser:
           // User cancelled the login
           break;
         case TwitterLoginStatus.error:
           // An error occurred
           break;
       }
     }
     ```
   - Call `_loginWithTwitter` when the user taps a button:
     ```dart
     ElevatedButton(
       onPressed: _loginWithTwitter,
       child: Text('Login with Twitter'),
     )
     ```

5. **Send the Twitter Login token to your backend:**
   - After the user logs in, you can obtain a Twitter Login token and secret.
   - Send these to your backend server. Your server should verify the token and secret and use them to establish a session or generate a JWT for the user.



### 3.8 GitHub

1. **Create a GitHub OAuth App:**
   - Go to your [GitHub Developer settings](https://github.com/settings/developers).
   - Click on "New OAuth App".
   - Fill in the "Application name", "Homepage URL" and "Authorization callback URL" fields. The callback URL should be a custom URL scheme that your app can handle.
   - Click "Register application".
   - Note down the Client ID and Client Secret.

2. **Install the `oauth2_client` and `url_launcher` packages:**
   - Add the `oauth2_client` and `url_launcher` packages to your `pubspec.yaml` file:
     ```yaml
     dependencies:
       flutter:
         sdk: flutter
       oauth2_client: ^2.2.0
       url_launcher: ^6.0.12
     ```
   - Run `flutter pub get` to fetch the packages.

3. **Implement GitHub Login in your app:**
   - Import the `oauth2_client` and `url_launcher` packages in your Dart file:
     ```dart
     import 'package:oauth2_client/oauth2_client.dart';
     import 'package:oauth2_client/github_oauth2_client.dart';
     import 'package:url_launcher/url_launcher.dart';
     ```
   - Create a new instance of `GitHubOAuth2Client`:
     ```dart
     final GitHubOAuth2Client oauth2Client = GitHubOAuth2Client(
       redirectUri: 'your-redirect-uri', // Replace with your redirect URI
       customUriScheme: 'your-custom-uri-scheme', // Replace with your custom URI scheme
     );
     ```
   - Create a function to handle the login process:
     ```dart
     Future<void> _loginWithGitHub() async {
       try {
         final tokenResponse = await oauth2Client.getTokenWithAuthCodeFlow(
           clientId: 'your-client-id', // Replace with your client ID
           clientSecret: 'your-client-secret', // Replace with your client secret
           scopes: ['read:user', 'user:email'],
         );
         final String? accessToken = tokenResponse?.accessToken;
         if (accessToken != null) {
           // The user logged in successfully, now send the token to your backend
           print('Access token: $accessToken');
         }
       } catch (e) {
         print('Error occurred during login: $e');
       }
     }
     ```
   - Call `_loginWithGitHub` when the user taps a button:
     ```dart
     ElevatedButton(
       onPressed: _loginWithGitHub,
       child: Text('Login with GitHub'),
     )
     ```

4. **Send the GitHub Login token to your backend:**
   - After the user logs in, you can obtain a GitHub Login token.
   - Send this token to your backend server. Your server should verify the token and use it to establish a session or generate a JWT for the user.

Remember, this is a basic example. You'll need to handle logout, error conditions, and other aspects of the user experience.


### 3.9 OAuth2
1. **Create an OAuth2 Application:**
   - Go to the OAuth2 provider's developer console (this could be Google, Facebook, GitHub, etc.).
   - Create a new OAuth2 application.
   - Note down the Client ID and Client Secret.

2. **Install the `oauth2_client` and `url_launcher` packages:**
   - Add the `oauth2_client` and `url_launcher` packages to your `pubspec.yaml` file:
     ```yaml
     dependencies:
       flutter:
         sdk: flutter
       oauth2_client: ^2.2.0
       url_launcher: ^6.0.12
     ```
   - Run `flutter pub get` to fetch the packages.

3. **Implement OAuth2 Login in your app:**
   - Import the `oauth2_client` and `url_launcher` packages in your Dart file:
     ```dart
     import 'package:oauth2_client/oauth2_client.dart';
     import 'package:url_launcher/url_launcher.dart';
     ```
   - Create a new instance of `OAuth2Client`:
     ```dart
     final OAuth2Client oauth2Client = OAuth2Client(
       authorizeUrl: 'https://<your-provider>/oauth2/authorize', // Replace with your provider's authorization URL
       tokenUrl: 'https://<your-provider>/oauth2/token', // Replace with your provider's token URL
       redirectUri: 'your-redirect-uri', // Replace with your redirect URI
       customUriScheme: 'your-custom-uri-scheme', // Replace with your custom URI scheme
     );
     ```
   - Create a function to handle the login process:
     ```dart
     Future<void> _loginWithOAuth2() async {
       try {
         final tokenResponse = await oauth2Client.getTokenWithAuthCodeFlow(
           clientId: 'your-client-id', // Replace with your client ID
           clientSecret: 'your-client-secret', // Replace with your client secret
           scopes: ['scope1', 'scope2'], // Replace with your scopes
         );
         final String? accessToken = tokenResponse?.accessToken;
         if (accessToken != null) {
           // The user logged in successfully, now send the token to your backend
           print('Access token: $accessToken');
         }
       } catch (e) {
         print('Error occurred during login: $e');
       }
     }
     ```
   - Call `_loginWithOAuth2` when the user taps a button:
     ```dart
     ElevatedButton(
       onPressed: _loginWithOAuth2,
       child: Text('Login with OAuth2'),
     )
     ```

4. **Send the OAuth2 Login token to your backend:**
   - After the user logs in, you can obtain an OAuth2 Login token.
   - Send this token to your backend server. Your server should verify the token and use it to establish a session or generate a JWT for the user.

Remember, this is a basic example. You'll need to handle logout, error conditions, and other aspects of the user experience. Also, the exact URLs and parameters will depend on your OAuth2 provider.




## 4 トークンの保存
モバイルアプリケーションでログインした後、ログイン状態を保持するため、Flutter内でトークンを保持し、バックエンドとの通信でトークンを付けるという方法が使われます。

その際によく使われる、[shared_preferencesプラグイン](https://docs.flutter.dev/cookbook/persistence/key-value)を試します。

### 4.1 コード例
コード例を記載します。

※上記のshared_preferencesプラグインではなく、[flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage)という、よりセキュアなプラグインを使った例です。



First, add the `flutter_secure_storage` package to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_secure_storage: ^4.2.1
```

Then, run `flutter pub get` to fetch the package.

Here's how you can use it in your code:

```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Create storage
final storage = new FlutterSecureStorage();

// Read value 
String value = await storage.read(key: key);

// Write value

 


await storage.write(key: key, value: value);

// Delete value 
await storage.delete(key: key);

// Delete all 
await storage.deleteAll();
```

In this example, `key` is the identifier for the piece of data you're storing, and `value` is the data itself.

Remember, while `flutter_secure_storage` provides a level of security, no method is 100% secure. Always use secure communication (HTTPS) to transfer sensitive data, and minimize the amount of sensitive data you store.
