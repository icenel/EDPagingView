//
//  EDPagingView.swift
//  TestingSlideView
//
//  Created by Edward Anthony on 7/3/16.
//  Copyright © 2016 Edward Anthony. All rights reserved.
//

import UIKit

@objc public protocol EDPagingViewDelegate: UIScrollViewDelegate {
    // For future protocol
}

@objc public protocol EDPagingViewDataSource {
    optional func numberOfPagesInPagingView(pagingView: EDPagingView) -> Int // Default is 0 if not implemented
    func pagingView(pagingView: EDPagingView, pageForPageIndex index: Int) -> EDPagingViewPage
}

public class EDPagingView: UIScrollView {
    public var backgroundView: UIView? {
        willSet {
            if newValue != nil {
                backgroundView?.removeFromSuperview()
            }
        }
        didSet {
            if backgroundView != nil {
                self.insertSubview(backgroundView!, atIndex: 0)
            }
        }
    }
    
    public weak var dataSource: EDPagingViewDataSource?
    override public var delegate: UIScrollViewDelegate? {
        didSet {
            if let newValue = delegate {
                /*
                 * Swift doesn't support overrididing inherited properties with different type
                 * like Objective C Does, therefore we need internal delegate.
                 */
                internalDelegate = unsafeBitCast(newValue, EDPagingViewDelegate.self)
            } else {
                delegate = nil
            }
        }
    }
    
    private var internalDelegate: EDPagingViewDelegate?
    
    private var needsReload = false
    private var cachedPages = [Int: EDPagingViewPage]()
    private var reusablePages = Set<EDPagingViewPage>() // Set contains unique memory pointers
    private var _numberOfPages = 0
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.pagingEnabled = true
    }
}

// MARK: - Computed & Observing Properties

public extension EDPagingView {
    public var numberOfPages: Int {
        return dataSource?.numberOfPagesInPagingView?(self) ?? 0
    }
    
    public var currentPageIndex: Int {
        let floatingPageIndex = self.contentOffset.x / self.frame.width
        return lround(Double(floatingPageIndex))
    }
    
    public override var frame: CGRect {
        didSet {
            setContentSize()
        }
    }
}

// MARK: - Reloading

public extension EDPagingView {
    private func setNeedsReload() {
        needsReload = true
        self.setNeedsLayout()
    }
    
    private func reloadIfNeeded() {
        if needsReload {
            reloadData()
        }
    }
    
    public func reloadData() {
        cachedPages.values.forEach { $0.removeFromSuperview() }
        cachedPages.removeAll()
        
        reusablePages.forEach { $0.removeFromSuperview() }
        reusablePages.removeAll()
        
        setContentSize()
        
        needsReload = false
    }
}

// MARK: - Layouting

public extension EDPagingView {
    public  override func layoutSubviews() {
        backgroundView?.frame = self.bounds
        reloadIfNeeded()
        layoutPagingView()
        super.layoutSubviews()
    }
    
    private func layoutPagingView() {
        let visibleBounds = CGRect(origin: CGPoint(x: self.contentOffset.x, y: 0), size: self.bounds.size)
        
        var availablePages = cachedPages
        cachedPages.removeAll()
        
        for pageIndex in 0..<_numberOfPages {
            let pageRect = rectForPageIndex(pageIndex)
            
            // If page is currently visible
            if pageRect.intersects(visibleBounds) {
                if let page = availablePages[pageIndex] ?? dataSource?.pagingView(self, pageForPageIndex: pageIndex) {
                    cachedPages[pageIndex] = page
                    availablePages.removeValueForKey(pageIndex)
                    
                    page.frame = rectForPageIndex(pageIndex)
                    page.setNeedsLayout()
                    self.addSubview(page)
                }
            }
        }
        
        for page in availablePages.values {
            if page.reuseIdentifier != nil {
                // Set is unique and page with same reuse identifier will have same pointer
                reusablePages.insert(page)
            }
            page.removeFromSuperview()
        }
    }
}

// MARK: - Public method

public extension EDPagingView {
    public func dequeueReusablePageWithIdentifier(identifier: String) -> EDPagingViewPage? {
        for page in reusablePages {
            if page.reuseIdentifier == identifier {
                let strongPage = page // Variables in Swift are strong by default
                reusablePages.remove(page)
                strongPage.prepareForReuse()
                return strongPage
            }
        }
        return nil
    }
}

// MARK: - UIScrollView

public extension EDPagingView {
    private func setContentSize() {
        _numberOfPages = dataSource?.numberOfPagesInPagingView?(self) ?? 0
        let width = self.bounds.width * CGFloat(_numberOfPages)
        self.contentSize = CGSize(width: width, height: self.bounds.height)
    }
    
    public func scrollToFirstPage() {
        scrollToFirstPageAnimated(false)
    }
    
    public func scrollToLastPage() {
        scrollToLastPageAnimated(false)
    }
    
    public func scrollToFirstPageAnimated(animated: Bool) {
        scrollToPageWithIndex(0, animated: animated)
    }
    
    public func scrollToLastPageAnimated(animated: Bool) {
        scrollToPageWithIndex(_numberOfPages - 1, animated: animated)
    }
    
    public func scrollToPageWithIndex(index: Int, animated: Bool) {
        self.scrollRectToVisible(rectForPageIndex(index), animated: animated)
    }
}

// MARK: - Helper

public extension EDPagingView {
    private func rectForPageIndex(index: Int) -> CGRect {
        return CGRect(origin: CGPoint(x: self.bounds.width * CGFloat(index), y: 0), size: self.bounds.size)
    }
}