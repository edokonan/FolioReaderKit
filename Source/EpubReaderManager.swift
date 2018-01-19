//
//  EpubReaderManager.swift
//  FolioReaderKit
//
//  Created by Zhu Kui on 2018/01/18.
//

import UIKit

@objc open class EpubReaderManager: NSObject {

    @objc var novelVC : FolioReaderContainer?
    @objc let reader = FolioReader.init()
    @objc let config = FolioReaderConfig()
    @objc var bookPath : String?
    
    @objc func initWithPath(bookPath: String){
        config.scrollDirection = .horizontal
        config.allowSharing = false
        config.displayTitle = true
        config.canChangeScrollDirection = true
        //        config.scrollToTopWhenChangeChapter = true
        //webview menu
        config.useReaderMenuController = false
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
    
    
    @objc func openBook(path: String){
        novelVC  = FolioReaderContainer.init(withConfig: config, folioReader: reader, epubPath: bookPath)
    }
    
    @objc func showChapterList(){
        novelVC?.centerViewController?.readerContainer?.centerViewController?.showChapterList()
    }
    @objc func showFontsMenu(){
        novelVC?.centerViewController?.readerContainer?.centerViewController?.showFontsMenu()
    }
}
