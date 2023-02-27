//
//  ScrollableView.swift
//  ScrollView-Header-stretching-Animations-Swift
//
//  Created by Takasur Azeem on 25/02/2023.
//  Copyright © 2023 Sanket Vaghela. All rights reserved.
//

import UIKit

class ScrollableView: UIView, UIScrollViewDelegate {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var screenTitleLbl: UILabel!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerviewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleTopConstraint: NSLayoutConstraint!

    var statusHeight = UIApplication.shared.statusBarFrame.size.height// Statusbar height
    let scrollTopEdgeInsets: CGFloat = 200// scrollView Top insets size

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("ScrollableView", owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        scrollView.delegate = self
        scrollView.layer.cornerRadius = 25
        scrollView.layer.masksToBounds = true
        scrollView.contentInset = UIEdgeInsets(top: scrollTopEdgeInsets, left: 0, bottom: 0, right: 0)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        // set headerview height
        headerviewHeightConstraint.constant = headerviewHeightConstraint.constant + statusHeight + 44

        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
    }
    

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let minHeight: CGFloat = 50
        let maxHeight: CGFloat = 250 + minHeight
        let yPos = scrollView.contentOffset.y
        let newHeaderViewHeight = (maxHeight - yPos) - (maxHeight-minHeight)
        let tempNewHeaderViewHeight = (maxHeight - yPos) - (maxHeight-minHeight)
        let titleValue = newHeaderViewHeight - minHeight

        // set screen title alpha value
        if titleValue > 0 {
            let finalValue = titleValue * 100 / scrollTopEdgeInsets
            let alphaValue = finalValue / 100
            screenTitleLbl.alpha = 1 - alphaValue
        }

        // manage header height constraint
        if newHeaderViewHeight > maxHeight {
            headerviewHeightConstraint
                .constant = (max(tempNewHeaderViewHeight, maxHeight) + (minHeight / 2)) + statusHeight
        } else {
            headerviewHeightConstraint.constant = (max(newHeaderViewHeight, minHeight) + (minHeight/2)) + statusHeight
        }
    }

}

extension ScrollableView: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int { 20 }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}
