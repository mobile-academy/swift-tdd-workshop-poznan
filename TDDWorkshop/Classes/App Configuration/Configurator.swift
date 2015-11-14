//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation

class Configurator {

    func configureApplication(configuration: Configuration, launchOptions: [NSObject: AnyObject]?) {
        Parse.setApplicationId(configuration.parseApplicationID, configuration.parseClientID)
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
    }
}
