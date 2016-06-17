//
//  Copyright © 2015 Mobile Academy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //MARK: UIApplicationDelegate

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        configureApplication(launchOptions)
        return true
    }

    //MARK: Helpers

    func configureApplication(launchOptions: [NSObject: AnyObject]?) {
        let configurator = Configurator()
        let appConfiguration = ConfigurationFactory().applicationConfiguration()
        configurator.configureApplication(appConfiguration, launchOptions: launchOptions)
    }
}

