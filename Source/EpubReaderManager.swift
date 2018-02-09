//
//  EpubReaderManager.swift
//  FolioReaderKit
//
//  Created by Zhu Kui on 2018/01/18.
//

import UIKit


@objc public protocol EpubReaderManagerDelegate {
    func LoadFileFinished()
    func PageChangedInChapter(TotalPage : Int, CurrentPage : Int)
    func OnTapOverlayView()
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
        
        //webview menu
        config.useReaderMenuController = true
        
        //hidden Navigation On Tap
        config.shouldHideNavigationOnTap = true
        config.neverDisplayNavigationOnTap = true
        //hidden highLight page
        config.hideHighlightPage = false
        
        //Print the chapter ID if one was clicked
        //A chapter in "The Silver Chair" looks like this "<section class="chapter" title="Chapter I" epub:type="chapter" id="id70364673704880">"
        //To know if a user tapped on a chapter we can listen to events on the class "chapter" and receive the id value
        let listener = ClassBasedOnClickListener(schemeName: "chaptertapped", querySelector: ".chapter", attributeName: "id", onClickAction: { (attributeContent: String?, touchPointRelativeToWebView: CGPoint?) in
            self.managerDelegate?.OnTapOverlayView()
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


