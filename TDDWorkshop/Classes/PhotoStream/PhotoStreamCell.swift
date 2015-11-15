//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

class PhotoStreamCell: UICollectionViewCell {

    //MARK: Object Life Cycle

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.redColor()
    }

}
