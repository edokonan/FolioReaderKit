//
//  EpubReaderManager.swift
//  FolioReaderKit
//
//  Created by Zhu Kui on 2018/01/18.
//

import UIKit

@objc open class EpubReaderManager: NSObject {
    
    @objc public var novelVC : FolioReaderContainer?
    @objc public let reader = FolioReader.init()
    @objc public let config = FolioReaderConfig()
    @objc public var bookPath : String?
    
    override init(){
        super.init()
    }
    
//    @objc public convenience init(contentDirection: CharpterContentDirection){
//        self.init()
//        //        config.scrollDirection = .horizontalWithVerticalContent
//        config.scrollDirection = .defaultVertical
//        //        config.contentDirection = .topToBottom
//        config.contentDirection = contentDirection
//        config.allowSharing = false
//        config.displayTitle = true
//        config.canChangeScrollDirection = true
//        //        config.scrollToTopWhenChangeChapter = true
////        config.loadSavedPositionForCurrentBook = true
//        //webview menu
//        config.useReaderMenuController = true
//        //hidden
//        config.shouldHideNavigationOnTap = true
//        //Print the chapter ID if one was clicked
//        //A chapter in "The Silver Chair" looks like this "<section class="chapter" title="Chapter I" epub:type="chapter" id="id70364673704880">"
//        //To know if a user tapped on a chapter we can listen to events on the class "chapter" and receive the id value
//        let listener = ClassBasedOnClickListener(schemeName: "chaptertapped", querySelector: ".chapter", attributeName: "id", onClickAction: { (attributeContent: String?, touchPointRelativeToWebView: CGPoint?) in
//            print("chapter with id: " + (attributeContent ?? "-") + " clicked")
//        })
//        config.classBasedOnClickListeners.append(listener)
//        //        bookPath = Bundle.main.path(forResource: "The Silver Chair", ofType: "epub")
//        //        setupConfig(config, epubPath: bookPath)
////        novelVC  = FolioReaderContainer.init(withConfig: config, folioReader: reader, epubPath: bookPath)
//        //        self.addChildViewController(novelVC!)
//        //        self.ContainerView.addSubview(novelVC!.view)
//        //        self.ContainerView.layer.masksToBounds = true
//    }
    
    
    @objc public  convenience init(bookPath: String){
        self.init()
//        config.scrollDirection = .horizontalWithVerticalContent
        config.scrollDirection = .defaultVertical
//        config.contentDirection = .topToBottom
//        config.contentDirection = .rightToLeft

        config.allowSharing = false
        config.displayTitle = true
        config.canChangeScrollDirection = true
        //        config.scrollToTopWhenChangeChapter = true
        config.loadSavedPositionForCurrentBook = true
        
        //webview menu
        config.useReaderMenuController = true
        //hidden
        config.shouldHideNavigationOnTap = true
        //Print the chapter ID if one was clicked
        //A chapter in "The Silver Chair" looks like this "<section class="chapter" title="Chapter I" epub:type="chapter" id="id70364673704880">"
        //To know if a user tapped on a chapter we can listen to events on the class "chapter" and receive the id value
        let listener = ClassBasedOnClickListener(schemeName: "chaptertapped", querySelector: ".chapter", attributeName: "id", onClickAction: { (attributeContent: String?, touchPointRelativeToWebView: CGPoint?) in
            print("chapter with id: " + (attributeContent ?? "-") + " clicked")
        })
        config.classBasedOnClickListeners.append(listener)
        //        bookPath = Bundle.main.path(forResource: "The Silver Chair", ofType: "epub")
        //        setupConfig(config, epubPath: bookPath)
        novelVC  = FolioReaderContainer.init(withConfig: config, folioReader: reader, epubPath: bookPath)
        //        self.addChildViewController(novelVC!)
        //        self.ContainerView.addSubview(novelVC!.view)
        //        self.ContainerView.layer.masksToBounds = true
    }
    
    
    @objc public func openBook(path: String?){
        if let bookpath = path{
            novelVC  = FolioReaderContainer.init(withConfig: config, folioReader: reader, epubPath: bookpath)
        }
    }
    
    @objc public  func showChapterList(){
        novelVC?.centerViewController?.readerContainer?.centerViewController?.showChapterList()
    }
    @objc public func showFontsMenu(){
        novelVC?.centerViewController?.readerContainer?.centerViewController?.showFontsMenu()
    }
}

