//
//  CompDetailsVC.swift
//  Sportily
//
//  Created by Artoon Solutions Private Limited on 25/07/19.
//  Copyright © 2019 Artoon Solutions Private Limited. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

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

    override func viewDidLoad() {
        super.viewDidLoad()
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

    override func viewDidAppear(_ animated: Bool) {
//        tblHeightConstraint.constant = self.leaderboardTblView.contentSize.height
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

extension ViewController: UITableViewDataSource {
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
