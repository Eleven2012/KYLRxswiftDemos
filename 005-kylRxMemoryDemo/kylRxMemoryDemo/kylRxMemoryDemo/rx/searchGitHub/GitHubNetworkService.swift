//
//  GitHubNetworkService.swift
//  kylRxMemoryDemo
//
//  Created by yulu kong on 2019/8/28.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import RxSwift
import RxCocoa
import Moya_ObjectMapper

class GitHubNetworkService {
    
    //搜索资源数据
    func searchRepositories(query:String) -> Observable<GitHubRepositories> {
        return GitHubProvider.rx.request(.repositories(query))
            .filterSuccessfulStatusCodes()
            .mapObject(GitHubRepositories.self)
            .asObservable()
            .catchError({ error in
                print("发生错误：",error.localizedDescription)
                return Observable<GitHubRepositories>.empty()
            })
    }
}

