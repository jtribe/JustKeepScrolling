
/**
* JustKeepLoading
* APIController
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

class APIController {
	
	private var isUpdating = false
	private var pages: [[Item]] = []
	
	func getNextPage(success success:SuccessBlock, failure: FailureBlock) {
		return loadItems(success: success, failure: failure)
	}
	
	func reloadData(success success:SuccessBlock, failure: FailureBlock) {
		self.pages = []
		return loadItems(success: success, failure: failure)
	}
	
	private func loadItems(success success:SuccessBlock, failure: FailureBlock) {
		
		if self.isUpdating {
			let items = self.pages.flatMap { $0 }
			success(items)
			return
		}
		
		self.isUpdating = true
		let nextPage = self.pages.count + 1
		
		// Calling API service
		APIService.sharedInstance.getItems("api.somewhere.com", page: nextPage, success: { items in
			self.pages.append(items)
			let items = self.pages.flatMap { $0 }
			self.isUpdating = false
			success(items)
		}, failure: { errorMessage in
			self.isUpdating = false
			failure(errorMessage)
		})
	}
	
}
