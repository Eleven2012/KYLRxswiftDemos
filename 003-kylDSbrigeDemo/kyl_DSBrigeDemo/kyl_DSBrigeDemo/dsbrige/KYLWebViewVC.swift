//
//  KYLWebViewVC.swift
//  kyl_DSBrigeDemo
//
//  Created by yulu kong on 2019/8/15.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import dsBridge
import SnapKit

class KYLWebViewVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    

    private var webview:DWKWebView = {
        let webview:DWKWebView = DWKWebView.init()
        return webview
    }()

}

// MARK: - 设置Webview
extension KYLWebViewVC {
    private func setupUI() {
        setupWebviewUI()
    }
    
    private func setupWebviewUI() {
        view.addSubview(webview)
        webview.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        #if DEBUG
        webview.setDebugMode(true)
        #endif
        webview.customJavascriptDialogLabelTitles(["alertTitle":"Nofification","alertBtn":"OK"])
        webview.navigationDelegate = self
        
        guard let htmlPath = Bundle.main.path(forResource: "test", ofType: "html"),
        let htmlContent = (try? String.init(contentsOfFile: htmlPath, encoding: String.Encoding.utf8)) else {
            return
        }
        
        webview.loadHTMLString(htmlContent, baseURL: URL(fileURLWithPath: Bundle.main.bundlePath))
    }
}

// MARK: - JS 调用 原生
extension KYLWebViewVC {
    private func addJSMethod() {
        webview.addJavascriptObject(KYLJSApi(), namespace: nil)
        //增加命名空间, JS在调用的时候可以用 swift.methodName 方便管理功能模块可增强阅读
        webview.addJavascriptObject(KYLJSApi(), namespace: "swift")
    }
}

// MARK: - 原生 调用 JS
extension KYLWebViewVC {
    
    // 字典转json字符串
    private func dicToString(_ dic:[String : Any]) -> String? {
        let data = try? JSONSerialization.data(withJSONObject: dic, options: [])
        let str = String(data: data!, encoding: String.Encoding.utf8)
        return str
    }
    
    private func nativeCallJS() {
        //原生调用js的addValue方法，参数是[3,4],返回值是value
        webview.callHandler("addValue", arguments: [3,4]) { (value) in
            debugPrint("\(#function) \(String(describing: value))")
        }
        
        //拼接字符串
        webview.callHandler("append", arguments: ["I", "love","you"]) { (value) in
            debugPrint("\(#function) \(String(describing: value))")
        }
        
        //传递json数据
        let jsonStr = dicToString(["name":"kongyulu","sex":"male"])
        webview.callHandler("showJson", arguments: [jsonStr ?? ""]) { (value) in
            debugPrint("\(#function) \(String(describing: value))")
        }
        
        //收到result 转为json
        webview.callHandler("showResult", arguments:  [jsonStr ?? ""]) { (value) in
            debugPrint("\(#function) \(String(describing: value))")
        }
        
        //带有命名空间的方法
        webview.callHandler("sync.addValue", arguments: [5,6]) { (value) in
            debugPrint("\(#function) \(String(describing: value))")
        }
        
        //测试js里面是否有某个方法
        webview.hasJavascriptMethod("addValue") { (isHas) in
            debugPrint("isHas = \(isHas)")
        }
        
        //如果H5调用了window.close方法就会监听到
        webview.setJavascriptCloseWindowListener {
            debugPrint("\(#function) 监听到关闭H5页面")
        }
    }
}

// MARK: - WKNavigationDelegate
extension KYLWebViewVC: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        debugPrint("\(#function)")
    }
}
