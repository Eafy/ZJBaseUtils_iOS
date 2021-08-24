//
//  TestHorizontalViewController .swift
//  ZJBaseUtilsDemo
//
//  Created by eafy on 2021/8/24.
//

import Foundation

class TestHorizontalViewController: ZJBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isHideNavBar = true
        isShowNavBarView = true
        
        title = "测试标题"
        
        navLeftBtn?.backgroundColor = .blue
        navRightBtn?.backgroundColor = .red
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navLeftBtn?.isHidden = false
    }
}
