# EDPagingView
A high performance paging view.

##The Problem
This is what you usually do with when building a paging view.

```
let scrollView = UIScrollView()
scrollView.pagingEnabled = true

scrollView.addSubview(yourFirstPageView)
scrollView.addSubview(yourSecondPageView)
```

Yes, it works, but the views are not cached and not reusable. Adding more and more view, will cause choppy scrolling animation.
Not only that, the memory used is increasing everytime you add subviews. Imagine you have 10,000 subviews in the scrollviews lazy loaded, that takes a huge memory consumption.

##Solution
With <b>EDPagingView</b>, your pages are automatically cached. And you can use reusable identifier to reuse the page.<br>
Whether you have thousands of view or just a few images, scrolling performance is always great. <br>
If you have thousands of views, EDPagingView will reduce the memory consumpotion by <b>99.8</b>%

##Advantages

- Great scrolling performance
- Automatically caching pages
- Resuable page using identifier
- Adding and removing page
- Better memory consumption
- Uses delegate design pattern

##Requirements

- Swift 2.2

##Usage

###Initializing

```
let pagingView = EDPagingView()
pagingView.dataSource = self
```

###Data source

Conform to data source protocol
```
EDPagingViewDataSource
```

```
func numberOfPagesInPagingView(pagingView: EDPagingView) -> Int {
    return pageCount
}

func pagingView(pagingView: EDPagingView, pageForPageIndex index: Int) -> EDPagingViewPage {
    var page = pagingView.dequeueReusablePageWithIdentifier(Constants.pageIdentifier)
    if page == nil {
        page = EDPagingViewPage(reuseIdentifier: "your identifier")
    }
    
    /*
     * If you want to subclass EDPagingViewPage, you can add your subviews in either self or self.contentView
     * Right now the implementation is identical, in the future contentView will be upgraded with action button
     * Therefore, adding subview to self.contentView is recommended for future support.
     */
    
    return page!
}
```

###Subclassing EDPagingView

```
class MyPage: EDPagingViewPage {

    let profileImageView = UIImageView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(profileImageView)
    }
}
```

###Reloading pages

```
pagingView.reloadData()
```

###Scrolling

```
pagingView.scrollToFirstPageAnimated(true)
pagingView.scrollToLastPageAnimated(true)
```

###Get Current Page

```
let currentPage = paggingView.currentPage
```

###Get Number of Pages

```
let numberOfPages = paggingView.numberOfPages
```

##Note
<b>EDPagingView</b> is a subclass of <b>UIScrollView</b>. So you can use UIScrollView delegate to receive scrolling events.