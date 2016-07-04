//
//  MyPage.swift
//  EDPagingView
//
//  Created by Edward Anthony on 7/4/16.
//  Copyright © 2016 Edward Anthony. All rights reserved.
//

import UIKit

class MyPage: EDPagingViewPage {
    let titleLabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        titleLabel.font = UIFont.systemFontOfSize(30.0)
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = .Center
        titleLabel.backgroundColor = UIColor.blackColor()
        
        self.contentView.addSubview(titleLabel)
    }
}

// MARK: - Layouting

extension MyPage {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.sizeToFit()
        titleLabel.bounds.size.width += 15.0
        titleLabel.bounds.size.height += 5.0
        titleLabel.center = self.contentView.center
    }
}