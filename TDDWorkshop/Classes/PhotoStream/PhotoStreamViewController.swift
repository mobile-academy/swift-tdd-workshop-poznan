//
//  Copyright © 2015 Mobile Academy. All rights reserved.
//

import UIKit

class PhotoStreamViewController: UIViewController {

    let parseAdapter = ParseAdapter()
    var downloader: StreamItemDownloader?
    var creator: StreamItemCreator?

    override func viewDidLoad() {
        super.viewDidLoad()
        downloader = StreamItemDownloader(parseAdapter: parseAdapter)
        creator = StreamItemCreator(presenter: DefaultViewControllerPresenter(viewController: self))

    }
}



