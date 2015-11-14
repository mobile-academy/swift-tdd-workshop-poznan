//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

protocol ViewControllerPresenter {

    weak var viewController: UIViewController? {get set}

    func presentViewController(viewController: UIViewController)
    func dismissViewController(viewController: UIViewController)
}

class DefaultViewControllerPresenter: ViewControllerPresenter {

    weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func presentViewController(viewController: UIViewController) {
        self.viewController?.presentViewController(viewController, animated: true, completion: nil)
    }

    func dismissViewController(viewController: UIViewController) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }

}
