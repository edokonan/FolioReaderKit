//
//  EpubReaderManager.swift
//  FolioReaderKit
//
//  Created by Zhu Kui on 2018/01/18.
//

import UIKit


@objc public protocol EpubReaderManagerDelegate {
    @objc func LoadFileFinished()
    @objc func PageChangedInChapter(TotalPage : Int, CurrentPage : Int)
    @objc func OnTapOverlayView()
    @objc func PageIsScrolling()
}

@objc open class EpubReaderManager: NSObject {
    
    @objc public var novelVC : FolioReaderContainer?
    @objc public var reader : FolioReader?
    @objc public var config : FolioReaderConfig = FolioReaderConfig()
    @objc public var bookPath : String?
    /// Epub Reader Manager Delegate
    open weak var managerDelegate: EpubReaderManagerDelegate?
    
    override init(){
        super.init()
    }

    @objc public  convenience init(bookPath: String){
        self.init()
        
        reader = FolioReader.init()
        
        config.scrollDirection = .defaultVertical
        
        config.allowSharing = false
        
        config.displayTitle = true
        
        config.canChangeScrollDirection = true
        
        config.loadSavedPositionForCurrentBook = true
        
        config.TestMode = false
        
        config.hideWebViewMenu = true
        
        //hidden webview menu
        config.useReaderMenuController = true
        
        //hidden
        config.hideBars = true
        config.hidePageIndicator = true
        
        //hidden Navigation On Tap
        config.shouldHideNavigationOnTap = true
        config.doNotUseSDKNavigationBar = true
        
        //hidden highLight page
        config.hideHighlightPage = false
        
        
        
        //Print the chapter ID if one was clicked
        let listener = ClassBasedOnClickListener(schemeName: "chaptertapped", querySelector: ".chapter", attributeName: "id", onClickAction: { (attributeContent: String?, touchPointRelativeToWebView: CGPoint?) in
//            self.managerDelegate?.OnTapOverlayView()
            print("chapter with id: " + (attributeContent ?? "-") + " clicked")
        })
        config.classBasedOnClickListeners.append(listener)
        novelVC  = FolioReaderContainer.init(withConfig: config, folioReader: reader!, epubPath: bookPath, removeEpub: false)
    }
    
    @objc public func openBook(path: String?){
        novelVC?.removeFromParentViewController()
        novelVC?.view.removeFromSuperview()
        reader = nil
        novelVC = nil
        
        if let bookpath = path{
            reader = FolioReader.init()
            novelVC  = FolioReaderContainer.init(withConfig: config, folioReader: reader!, epubPath: bookpath, removeEpub: false)
        }
    }
    
    @objc public func displayInView(vc: UIViewController,ContainerView: UIView){
        if novelVC != nil{
            novelVC?.removeFromParentViewController()
            novelVC?.view.removeFromSuperview()
            
            vc.addChildViewController(novelVC!)
            ContainerView.addSubview(novelVC!.view)
            ContainerView.layer.masksToBounds = true
            novelVC?.view.frame = ContainerView.bounds
        }
    }
    
    @objc public  func setTestMode(bool:Bool){
        config.TestMode = bool
    }
    
    @objc public  func setEpubManagerDelegate(delegate:EpubReaderManagerDelegate){
        if let center = reader?.readerCenter{
            center.managerDelegate = delegate
            self.managerDelegate = delegate
        }
    }
    
    @objc public  func showChapterList(){
        novelVC?.centerViewController?.readerContainer?.centerViewController?.showChapterList()
    }
    @objc public func showFontsMenu(){
        novelVC?.centerViewController?.readerContainer?.centerViewController?.showFontsMenu()
    }
    @objc open func movetoPageNum(num:Int,totalpage:Int) {
        self.reader?.movetoPageNum(num: num, totalpage: totalpage)
        
    }
}

//test
public func myepub_debugprint(_ items: Any...){
    print(items)
}


