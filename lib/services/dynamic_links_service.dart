import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkService {
  Future handleDynamicLinks() async {
    // 1. Get the initial dynamic link if the app is opened with a dynamic link
    final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();

    // 2. handle link that has been retrieved

    if (data != null) {
      _handleDeepLink(data.link);
    }

    // 3. Register a link callback to fire if the app is opened up from the background
    // using a dynamic link.
    FirebaseDynamicLinks.instance.onLink.listen(
      (PendingDynamicLinkData? pendingDynamicLinkData) {
        // Set up the `onLink` event listener next as it may be received here
        if (pendingDynamicLinkData != null) {
          final Uri deepLink = pendingDynamicLinkData.link;
          _handleDeepLink(deepLink);
          // Example of using the dynamic link to push the user to a different screen
          // Navigator.pushNamed(context, deepLink.path);
        }
      },
    );
  }

  void _handleDeepLink(Uri? deepLink) {
    if (deepLink != null) {
      print('_handleDeepLink | deeplink: $deepLink');
    }
  }

  Future<String?> createNewDynamicLink(String? invoiceId) async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://anurag-error404.github.io/invoice?id=$invoiceId"),
      uriPrefix: "https://govtbills.page.link",
      androidParameters: const AndroidParameters(packageName: "com.example.govt_billing"),
    );
    final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    return dynamicLink.shortUrl.toString();
  }
}
