
/**
* JustKeepLoading
* ViewController
*
* Copyright (c) 2016 Jtribe
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
* of the Software, and to permit persons to whom the Software is furnished to do so,
* subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
* INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
* PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
* HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
* CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
* OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	private let refreshControl = UIRefreshControl()
	
	// data
	private let serviceController = APIController()
	private var items: [Item] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Just Keep Scrolling"
		reloadData()
		addPullToRefresh()
	}
	
	// MARK: Refresh Control
	
	private func addPullToRefresh(){
		refreshControl.removeFromSuperview()
		refreshControl.tintColor = UIColor.blackColor()
		refreshControl.addTarget(self, action: #selector(reloadData), forControlEvents: .ValueChanged)
		tableView.addSubview(refreshControl)
	}

}

// MARK: UITableViewDelegate, UITableViewDataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
	
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.items.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell") as! ItemCell
		let item = items[indexPath.row]
		cell.configureWithItem(item)
		return cell
	}
	
}

// MARK: UIScrollViewDelegate

extension ViewController: UIScrollViewDelegate {
	
	// loads next page when at the bottom
	func scrollViewDidScroll(scrollView: UIScrollView) {
		let contentLarger = (scrollView.contentSize.height > scrollView.frame.size.height)
		let viewableHeight = contentLarger ? scrollView.frame.size.height : scrollView.contentSize.height
		let atBottom = (scrollView.contentOffset.y >= scrollView.contentSize.height - viewableHeight + 50)
		if atBottom && !tableView.isLoadingFooterShowing() {
			getNextPage()
		}
	}
	
}

// MARK: API Accessors

extension ViewController {
	
	func getNextPage() {
		tableView.showLoadingFooter()
		serviceController.getNextPage(success: { items in
			self.items = items
			self.tableView.reloadData()
			self.tableView.hideLoadingFooter()
		}, failure: { errorMessage in
			print(errorMessage)
			self.tableView.hideLoadingFooter()
		})
	}
	
	func reloadData() {
		serviceController.reloadData(success: { items in
			self.items = items
			self.tableView.reloadData()
			self.refreshControl.endRefreshing()
		}, failure: { errorMessage in
			print(errorMessage)
			self.refreshControl.endRefreshing()
		})
	}
	
}
