
/**
* JustKeepLoading
* APIService
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

// return block types

typealias SuccessBlock = (([Item])->(Void))
typealias FailureBlock = ((String)->(Void))

// This would be the actual API service class, making the request

class APIService: NSObject {
	
	static let sharedInstance = APIService()
	private override init() {}
	
	func getItems(apiURL: String, page: Int, success: SuccessBlock, failure:FailureBlock) {
		delay(0.5){
			if page > 0 && page <= mockDataPages.count {
				success(mockDataPages[page-1])
			} else {
				failure("The API Has No More Data To Give")
			}
		}
	}

}

// MARK: Mock Data

let mockDataPages = [mockPage1,mockPage2,mockPage3,mockPage4]

let mockPage1: [Item] = [
	Item(name: "Hi, I'm Dory", description: "I just keep swimming", image: UIImage(named: "Dory1")),
	Item(name: "Hi, I'm Dory", description: "I just keep swimming", image: UIImage(named: "Dory1")),
	Item(name: "Hi, I'm Dory", description: "I just keep swimming", image: UIImage(named: "Dory1")),
	Item(name: "Hi, I'm Dory", description: "I just keep swimming", image: UIImage(named: "Dory1")),
	Item(name: "Hi, I'm Dory", description: "I just keep swimming", image: UIImage(named: "Dory1")),
	Item(name: "Hi, I'm Dory", description: "I just keep swimming", image: UIImage(named: "Dory1")),
	Item(name: "Hi, I'm Dory", description: "I just keep swimming", image: UIImage(named: "Dory1")),
	Item(name: "Hi, I'm Dory", description: "I just keep swimming", image: UIImage(named: "Dory1")),
	Item(name: "Hi, I'm Dory", description: "I just keep swimming", image: UIImage(named: "Dory1")),
	Item(name: "Hi, I'm Dory", description: "I just keep swimming", image: UIImage(named: "Dory1"))
]

let mockPage2: [Item] = [
	Item(name: "P. Sherman 42 Wallaby Way, Sydney", description: "I just keep swimming", image: UIImage(named: "Dory2")),
	Item(name: "P. Sherman 42 Wallaby Way, Sydney", description: "I just keep swimming", image: UIImage(named: "Dory2")),
	Item(name: "P. Sherman 42 Wallaby Way, Sydney", description: "I just keep swimming", image: UIImage(named: "Dory2")),
	Item(name: "P. Sherman 42 Wallaby Way, Sydney", description: "I just keep swimming", image: UIImage(named: "Dory2")),
	Item(name: "P. Sherman 42 Wallaby Way, Sydney", description: "I just keep swimming", image: UIImage(named: "Dory2")),
	Item(name: "P. Sherman 42 Wallaby Way, Sydney", description: "I just keep swimming", image: UIImage(named: "Dory2")),
	Item(name: "P. Sherman 42 Wallaby Way, Sydney", description: "I just keep swimming", image: UIImage(named: "Dory2")),
	Item(name: "P. Sherman 42 Wallaby Way, Sydney", description: "I just keep swimming", image: UIImage(named: "Dory2")),
	Item(name: "P. Sherman 42 Wallaby Way, Sydney", description: "I just keep swimming", image: UIImage(named: "Dory2")),
	Item(name: "P. Sherman 42 Wallaby Way, Sydney", description: "I just keep swimming", image: UIImage(named: "Dory2"))
]

let mockPage3: [Item] = [
	Item(name: "I can't remember", description: "I just keep swimming", image: UIImage(named: "Dory3")),
	Item(name: "I can't remember", description: "I just keep swimming", image: UIImage(named: "Dory3")),
	Item(name: "I can't remember", description: "I just keep swimming", image: UIImage(named: "Dory3")),
	Item(name: "I can't remember", description: "I just keep swimming", image: UIImage(named: "Dory3")),
	Item(name: "I can't remember", description: "I just keep swimming", image: UIImage(named: "Dory3")),
	Item(name: "I can't remember", description: "I just keep swimming", image: UIImage(named: "Dory3")),
	Item(name: "I can't remember", description: "I just keep swimming", image: UIImage(named: "Dory3")),
	Item(name: "I can't remember", description: "I just keep swimming", image: UIImage(named: "Dory3")),
	Item(name: "I can't remember", description: "I just keep swimming", image: UIImage(named: "Dory3")),
	Item(name: "I can't remember", description: "I just keep swimming", image: UIImage(named: "Dory3"))
]

let mockPage4: [Item] = [
	Item(name: "I don't think I've ever eaten a fish", description: "I just keep swimming", image: UIImage(named: "Dory4")),
	Item(name: "I don't think I've ever eaten a fish", description: "I just keep swimming", image: UIImage(named: "Dory4")),
	Item(name: "I don't think I've ever eaten a fish", description: "I just keep swimming", image: UIImage(named: "Dory4")),
	Item(name: "I don't think I've ever eaten a fish", description: "I just keep swimming", image: UIImage(named: "Dory4"))
]

// API Delay Simulation

func delay(delay: Double, closure: ()->()) {
	dispatch_after(
		dispatch_time(
			DISPATCH_TIME_NOW,
			Int64(delay * Double(NSEC_PER_SEC))
		),
		dispatch_get_main_queue(),
		closure
	)
}
