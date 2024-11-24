import ParseSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Initialize Parse SDK
        ParseSwift.initialize(applicationId: "YOUR_PARSE_SERVER_APPLICATION_ID",
                              clientKey: "YOUR_PARSE_SERVER_CLIENT_KEY",
                              serverURL: URL(string: "YOUR_PARSE_SERVER_API_ADDRESS")!)
        return true
    }
}
