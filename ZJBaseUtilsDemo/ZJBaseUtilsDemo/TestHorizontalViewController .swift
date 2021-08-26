//
//  TestHorizontalViewController .swift
//  ZJBaseUtilsDemo
//
//  Created by eafy on 2021/8/24.
//

import Foundation

class TestHorizontalViewController: ZJBaseViewController {
    
    static var vvv: CGFloat = {
       let v1 = ZJStatusBarHeight()
        
        debugPrint("----------->\(v1)")
        return v1
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isHideNavBar = true
        isShowNavBarView = true
        
        title = "测试标题"
        
        navLeftBtn?.backgroundColor = .blue
        navRightBtn?.backgroundColor = .red
        let v2 = TestHorizontalViewController.vvv;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navLeftBtn?.isHidden = false
    }
}
