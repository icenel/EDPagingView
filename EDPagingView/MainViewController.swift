//
//  MainViewController.swift
//  EDPagingView
//
//  Created by Edward Anthony on 7/3/16.
//  Copyright © 2016 Edward Anthony. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let pagingView = EDPagingView()
    let addPageButton = UIButton()
    
    var pageCount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        
        addPageButton.setImage(UIImage.addButtonImage(), forState: .Normal)
        addPageButton.addTarget(self, action: #selector(addPage), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(pagingView)
        self.view.addSubview(addPageButton)
        
        pagingView.dataSource = self
        
        pagingView.reloadData()
    }
}

// MARK: - Layouting

extension MainViewController {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        pagingView.frame = self.view.bounds
        
        let topRight = self.view.bounds.insetBy(dx: 20.0, dy: 30.0)
        addPageButton.frame = CGRect(x: topRight.maxX - 50.0, y: topRight.minY, width: 50.0, height: 50.0)
    }
}

// MARK: _ EDPagingView datasource

extension MainViewController: EDPagingViewDataSource {
    func numberOfPagesInPagingView(pagingView: EDPagingView) -> Int {
        return pageCount
    }
    
    func pagingView(pagingView: EDPagingView, pageForPageIndex index: Int) -> EDPagingViewPage {
        var page = pagingView.dequeueReusablePageWithIdentifier(Constants.pageIdentifier)
        if page == nil {
            page = EDPagingViewPage(reuseIdentifier: Constants.pageIdentifier)
        }
        
        /*
         * If you want to subclass EDPagingViewPage, you can add your subview in either self or self.contentView
         * Right now the implementation is identical, in the future contentView will be upgraded with action button
         * Therefore, adding subview to self.contentView is recommended for future support.
         */
        
        page!.contentView.backgroundColor = UIColor(hue: 1.0 * CGFloat(index) / CGFloat(pagingView.numberOfPages),
                                                    saturation: 1.0,
                                                    brightness: 1.0, alpha: 1.0)
        
        return page!
    }
}

// MARK: - Action

extension MainViewController {
    func addPage() {
        self.pageCount += 1
        self.pagingView.reloadData()
        self.pagingView.scrollToLastPageAnimated(true)
    }
}

// MARK: - Constants

extension MainViewController {
    struct Constants {
        static let pageIdentifier = "page"
    }
}