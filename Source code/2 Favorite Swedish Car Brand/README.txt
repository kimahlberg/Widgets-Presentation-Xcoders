This project demonstrates the use of URL Schemes and an App Group's shared
NSUserDefaults object to launch the app and pass information between a widget
and its containing app.

# Launching the containing app from the widget using URL Scheme

First a URL Scheme was registered for the app. This is done in the app's
info.plist file under the URL Types array (the raw key is: CFBundleURLTypes).

This example uses the URL Scheme: kawidgettest://

You can see how the URL Scheme is used to launch the app when the background 
of the widget is tapped in the -backgroundButtonTapped: method in
TodayViewController.m.


# Passing info between app and widget using an App Group's shared NSUserDefaults

First an App Group must be set up using the developer portal.

The App Group needs to be enabled for both the app target and the extension target.
This is done in Xcode using the Capabilities tab for each target.

The example is delivered with the App Group ID: group.com.theevilboss.widgettest
You should change this to match your own App Group ID.

You can see how the shared NSUserDefaults object is used to store a value in the
-carBrandButtonTapped: methods of both the app's ViewController.m and the widget's
TodayViewController.m.

You can see how the value is then retrieved from the shared NSUserDefaults object in
the -updateControls methods of both the app's ViewController.m and the widget's
TodayViewController.m.

