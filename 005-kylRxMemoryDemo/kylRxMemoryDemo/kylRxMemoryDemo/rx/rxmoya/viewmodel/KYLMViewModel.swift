//
//  KYLMViewModel.swift
//  kylRxMemoryDemo
//
//  Created by yulu kong on 2019/8/28.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum KYLMRefreshStatus {
    case none
    case beingHeaderRefresh
    case endHeaderRefresh
    case beingFooterRefresh
    case endFooterRefresh
    case noMoreData
}

class KYLMViewModel: NSObject {
    // 存放着解析完成的模型数组
    let models = Variable<[KYLMModel]>([])
    // 记录当前的索引值
    var index: Int = 1
}

extension KYLMViewModel: KYLMViewModelType {
    
    typealias Input = KYLMInput
    typealias Output = KYLMOutput
    
    struct KYLMInput {
        // 网络请求类型
        let category: KYLMNetworkTool.KYLMNetworkCategory
        
        init(category: KYLMNetworkTool.KYLMNetworkCategory) {
            self.category = category
        }
    }
    
    struct KYLMOutput {
        // tableView的sections数据
        let sections: Driver<[KYLMSection]>
        // 外界通过该属性告诉viewModel加载数据（传入的值是为了标志是否重新加载）
        let requestCommond = PublishSubject<Bool>()
        // 告诉外界的tableView当前的刷新状态
        let refreshStatus = Variable<KYLMRefreshStatus>(.none)
        
        init(sections: Driver<[KYLMSection]>) {
            self.sections = sections
        }
    }
    
    func transform(input: KYLMViewModel.KYLMInput) -> KYLMViewModel.KYLMOutput {
        let sections = models.asObservable().map { (models) -> [KYLMSection] in
            // 当models的值被改变时会调用
            return [KYLMSection(items: models)]
            }.asDriver(onErrorJustReturn: [])
        
        let output = KYLMOutput(sections: sections)
        
        output.requestCommond.subscribe(onNext: {[unowned self] isReloadData in
            self.index = isReloadData ? 1 : self.index+1
            kylMNetTool.rx.request(.data(type: input.category, size: 10, index: self.index))
                .asObservable()
                .mapArray(KYLMModel.self)
                .subscribe({ [weak self] (event) in
                    switch event {
                    case let .next(modelArr):
                        self?.models.value = isReloadData ? modelArr : (self?.models.value ?? []) + modelArr
                        KYLProgressHUD.showSucess("加载成功")
                    case let .error(error):
                        KYLProgressHUD.showError(error.localizedDescription)
                    case .completed:
                        output.refreshStatus.value = isReloadData ? .endHeaderRefresh : .endFooterRefresh
                    }
                }).disposed(by: DisposeBag()) //disposed(by: self.rx.disposeBag)
        }).disposed(by: DisposeBag())
        
        return output
    }
}




extension BehaviorRelay where Element: RangeReplaceableCollection {
    
    func append(_ subElement: Element.Element) {
        var newValue = value
        newValue.append(subElement)
        accept(newValue)
    }
    
    func append(contentsOf: [Element.Element]) {
        var newValue = value
        newValue.append(contentsOf: contentsOf)
        accept(newValue)
    }
    
    public func remove(at index: Element.Index) {
        var newValue = value
        newValue.remove(at: index)
        accept(newValue)
    }
    
    public func removeAll() {
        var newValue = value
        newValue.removeAll()
        accept(newValue)
    }
    
}
