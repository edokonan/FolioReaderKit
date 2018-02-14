//
//  SampleViewController.swift
//  Storyboard-Example
//
//  Created by Zhu Kui on 2018/01/17.
//  Copyright © 2018年 FolioReader. All rights reserved.
//

import UIKit
import FolioReaderKit
class SampleViewController: UIViewController {

//    var novelVC : FolioReaderContainer?
//    let reader = FolioReader.init()
//    let config = FolioReaderConfig()
    var bookPath : String?
//    var epubreader : EpubReaderManager?
    
    var epubMng : EpubReaderManager?
    override func viewDidLoad() {
        super.viewDidLoad()
////        epubreader = CMCEpubReaderManager.ini
//        //config.scrollDirection = .horizontalWithVerticalContent
//        config.scrollDirection = .horizontal
//        config.allowSharing = false
//        config.displayTitle = true
//        config.canChangeScrollDirection = true
//        config.scrollToTopWhenChangeChapter = true
//        //webview menu
//        config.useReaderMenuController = false
//        //hidden
//        config.shouldHideNavigationOnTap = true
//        //Print the chapter ID if one was clicked
//        //A chapter in "The Silver Chair" looks like this "<section class="chapter" title="Chapter I" epub:type="chapter" id="id70364673704880">"
//        //To know if a user tapped on a chapter we can listen to events on the class "chapter" and receive the id value
//        let listener = ClassBasedOnClickListener(schemeName: "chaptertapped", querySelector: ".chapter", attributeName: "id", onClickAction: { (attributeContent: String?, touchPointRelativeToWebView: CGPoint?) in
//            print("chapter with id: " + (attributeContent ?? "-") + " clicked")
//        })
//        config.classBasedOnClickListeners.append(listener)
//
        bookPath = Bundle.main.path(forResource: "The Silver Chair", ofType: "epub")
        epubMng = EpubReaderManager.init(bookPath: bookPath!)
        epubMng?.displayInView(vc: self,ContainerView: ContainerView)
        epubMng?.setEpubManagerDelegate(delegate: self)
        
        
//        epubMng = EpubReaderManager.init(bookPath: bookPath!)
//        epubMng?.displayInView(vc: self,ContainerView: ContainerView)
//        epubMng?.setEpubManagerDelegate(delegate: self)
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        epubMng?.novelVC?.view.frame = self.ContainerView.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var ContainerView: UIView!
    @IBAction func openbook1(_ sender: Any) {
        guard let bookPath = Bundle.main.path(forResource: "鳳神醫02-測字符(m)+Qrcode", ofType: "epub") else { return }
        epubMng?.openBook(path: bookPath)
        epubMng?.setTestMode(bool: true)
        epubMng?.displayInView(vc: self,ContainerView: ContainerView)
        
//        self.addChildViewController((epubMng?.novelVC!)!)
//        self.ContainerView.addSubview((epubMng?.novelVC?.view)!)
//        self.ContainerView.layer.masksToBounds = true
//        epubMng?.novelVC?.view.frame = self.ContainerView.bounds
//        self.loadViewIfNeeded()
    }
    
    var i = 0
    @IBAction func openbook2(_ sender: Any) {
        if i == 0{
            guard let Path = Bundle.main.path(forResource: "[田中芳樹] 銀河英雄伝説 第01巻 黎明篇", ofType: "epub") else { return }
            bookPath = Path
            i = 1
        }
        else if i == 1{
            guard let Path = Bundle.main.path(forResource: "[上橋菜穂子] 守り人シリーズ01 精霊の守り人", ofType: "epub") else { return }
            bookPath = Path
            i = 2
        }
        else if i > 1{
            guard let Path = Bundle.main.path(forResource: "危机与重构：唐帝国及其地方诸侯", ofType: "epub") else { return }
            bookPath = Path
            i = 0
        }
        epubMng?.openBook(path: bookPath)
        epubMng?.displayInView(vc: self,ContainerView: ContainerView)
    }
    @IBAction func openfont(_ sender: Any) {
//        novelVC?.centerViewController?.readerContainer?.centerViewController?.presentFontMenu()
        epubMng?.showFontsMenu()
    }
    @IBAction func btnaction4(_ sender: Any) {
//        novelVC?.readerConfig.scrollDirection = .horizontal
        epubMng?.showChapterList()
    }
    
    
    func initConfig(){
    }
    
}
extension SampleViewController:EpubReaderManagerDelegate{
    func LoadFileFinished() {
        
    }
    func PageChangedInChapter(TotalPage: Int, CurrentPage: Int) {
        print("------PageChangedInChapter--------\(CurrentPage)/\(TotalPage)")

    }
    
    func OnTapOverlayView() {
        print("------OnTapOverlayView--------")

    }
}
