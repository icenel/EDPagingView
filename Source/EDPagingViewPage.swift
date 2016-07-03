//
//  EDPagingViewPage.swift
//  TestingSlideView
//
//  Created by Edward Anthony on 7/3/16.
//  Copyright © 2016 Edward Anthony. All rights reserved.
//

import UIKit

public class EDPagingViewPage: UIView {
    
    public var reuseIdentifier: String?
    
    private var _contentView: UIView?
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public init(reuseIdentifier: String?) {
        super.init(frame: UIScreen.mainScreen().bounds)
        self.reuseIdentifier = reuseIdentifier
    }
}

// MARK: - Content View

public extension EDPagingViewPage {
    public var contentView: UIView {
        get {
            if _contentView == nil {
                _contentView = UIView()
                self.addSubview(_contentView!)
                self.layoutIfNeeded()
            }
            return _contentView!
        }
    }
}

// MARK: - Layouting

public extension EDPagingViewPage {
    public override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = self.bounds
    }
}

// MARK: - Overriding

public extension EDPagingViewPage {
    public func prepareForReuse() {
        // For overriding
    }
}
