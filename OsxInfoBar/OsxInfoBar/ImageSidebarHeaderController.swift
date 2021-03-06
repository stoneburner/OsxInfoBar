//
//  ImageSidebarHeaderController.swift
//  OsxInfoBar
//
//  Created by @PlumheadDev on 14/02/2016.
//

import Cocoa

//MARK: - A sidebar header with an image and some text content
class ImageSidebarHeaderController: NSViewController {
    @IBOutlet weak var titleLabel: NSTextField!
    
    var _presenter : TextSidebarHeader? {
        didSet {
        guard isViewLoaded else {return}
        titleLabel.stringValue = _presenter?.content ?? ""
        }
    }
    
    // Users of this header will assign an appropriate toggle function.
    var toggle       : (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
    }
    
    @IBAction func showHidePressed(_ sender: AnyObject) {
        toggle?()
    }
}

//MARK: - SidebarHeader implementation
extension ImageSidebarHeaderController : SidebarHeaderElement {
    @discardableResult func configure(_ p: HeaderDetailPresentable) -> Bool {
        // We could initialise this header with different types - at the moment just accept the TextSidebarHeader
        guard let pr = p as? TextSidebarHeader else {return false}
        _ = self.view
        _presenter = pr
        return true
    }
    
    func update(toViewState vs : SidebarState) {
        switch vs {
        case .open:
            self.view.layer?.backgroundColor = NSColor.green.cgColor
        case .collapsed:
            let c = NSColor(calibratedRed: 1.0, green: 0.0, blue: 0.0, alpha: 0.25)
            self.view.layer?.backgroundColor = c.cgColor
        }
    }
}
