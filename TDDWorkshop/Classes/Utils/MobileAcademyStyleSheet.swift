//
// Copyright (©) 2016 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

    static func ma_greyColor() -> UIColor {
        return UIColor(red: 52/255, green: 52/255, blue: 53/255, alpha: 1.0)
    }

    static func ma_tealColor() -> UIColor {
        return UIColor(red: 66/255, green: 177/255, blue: 211/255, alpha: 1.0)
    }

    static func ma_darkTealColor() -> UIColor {
        return UIColor(red: 62/255, green: 160/255, blue: 183/255, alpha: 1.0)
    }
}


class MobileAcademyStyleSheet {
    static func applyStyle() {
        UINavigationBar.appearance().barTintColor = UIColor.ma_tealColor()
        UINavigationBar.appearance().translucent = false
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()

        UITabBar.appearance().barTintColor = UIColor.ma_greyColor()
        UITabBar.appearance().tintColor = UIColor.whiteColor()

        UISegmentedControl.appearance().tintColor = UIColor.ma_tealColor()
    }
}
