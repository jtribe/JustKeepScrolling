
/**
* JustKeepLoading
* UITableView Extension
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

// MARK: Loading Footer

extension UITableView {
	
	func showLoadingFooter(){
		let loadingFooter = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
		loadingFooter.frame.size.height = 50
		loadingFooter.hidesWhenStopped = true
		loadingFooter.startAnimating()
		tableFooterView = loadingFooter
	}
	
	func hideLoadingFooter(){
		let tableContentSufficentlyTall = (contentSize.height > frame.size.height)
		let atBottomOfTable = (contentOffset.y >= contentSize.height - frame.size.height)
		if atBottomOfTable && tableContentSufficentlyTall {
			UIView.animateWithDuration(0.2, animations: {
				self.contentOffset.y = self.contentOffset.y - 50
			}, completion: { finished in
				self.tableFooterView = UIView()
			})
		} else {
			self.tableFooterView = UIView()
		}
	}
	
	func isLoadingFooterShowing() -> Bool {
		return tableFooterView is UIActivityIndicatorView
	}
	
}
