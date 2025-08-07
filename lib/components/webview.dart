import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {

  final String initUrl;
  final String urlToPop;

  const WebViewPage({Key? key,
    required this.initUrl,
    this.urlToPop = ''
  }) : super(key: key);
  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebViewPage> {


  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    //if (Platform.isAndroid) {
    //WebView.platform = SurfaceAndroidWebView();
    //}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: WebView(
        initialUrl: widget.initUrl,
        javascriptMode: JavascriptMode.unrestricted,
        allowsInlineMediaPlayback: true,
        gestureNavigationEnabled: true,

        userAgent: "Flutter;Webview",
        navigationDelegate: (navigation){
          print(navigation.url);
          if(navigation.url.contains(widget.urlToPop)){
            Navigator.of(context).pop(true); //close webview
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}