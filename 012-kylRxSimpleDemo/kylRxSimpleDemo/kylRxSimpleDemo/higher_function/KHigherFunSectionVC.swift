//
//  KHigherFunSectionVC.swift
//  kylRxSimpleDemo
//
//  Created by yulu kong on 2019/9/3.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
//import JXPhotoBrowser

struct LGPlayer {
    init(score: Int) {
        self.score = BehaviorSubject(value: score)
    }
    let score: BehaviorSubject<Int>
}

extension Date {
    static var time: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH-mm-ss"
        return formatter.string(from: Date())
    }
}


class KHigherFunSectionVC: KBaseViewController {
    
    var intervalOB: Observable<Int>!
    var disposeSub: Disposable!
    
    let kylError = NSError.init(domain: "com.kylerror.cn", code: 10090, userInfo: nil)
    
    /// tableView懒加载
    lazy var tableView: UITableView = {
        let tabView = UITableView.init(frame: self.view.bounds, style: .plain)
        tabView.tableFooterView = UIView()
        tabView.register(KFunItemCell.classForCoder(), forCellReuseIdentifier: resuseID)
        tabView.rowHeight = 80
        
        return tabView
    }()
    
    var data = KHighFunData()
    var data2 = KSectionHighFunData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNav()
        self.customSectionModel()
    }
    
    /// 导航栏相关
    override func setupNav() {
        self.title = "高阶函数"
        self.view.backgroundColor = UIColor.white
        /// 加载tableView
        self.view.addSubview(self.tableView)
    }
    
    /// Rx 处理分组
    func setupTableViewRX() {
        
        let tableViewDataSource = RxTableViewSectionedReloadDataSource<SectionModel<String,KFunItemSectionModel>>(configureCell: { [weak self](dataSource, tab, indexPath, model) -> KFunItemCell in
            
            let cell = tab.dequeueReusableCell(withIdentifier: self?.resuseID ?? "resuseID_LGSectionViewController", for: indexPath) as! KFunItemCell
            cell.setUISectionData(model)
            cell.selectionStyle = .none
            return cell
            },titleForHeaderInSection: { dataSource,index -> String in
                // print("数据:\(dataSource.sectionModels[index].identity)")
                return dataSource.sectionModels[index].model
        })
        
        /// 我们上次就是通过bind函数,这里我们变化一下
        self.data.githubData.asDriver(onErrorJustReturn: [])
            .drive(self.tableView.rx.items(dataSource: tableViewDataSource))
            .disposed(by: self.disposeBag)
        
    }
    
    /// 自定义组模型
    func customSectionModel() {
        let tableViewDataSource2 = RxTableViewSectionedReloadDataSource<KFunItemSectionDataModel>(configureCell: { [weak self](dataSource, tab, indexPath, model) -> KFunItemCell in
            
            let cell = tab.dequeueReusableCell(withIdentifier: self?.resuseID ?? "resuseID_LGSectionViewController", for: indexPath) as! KFunItemCell
            cell.setUISectionData(model)
            cell.selectionStyle = .none
            return cell
            },titleForHeaderInSection: { dataSource,index -> String in
                // print("数据:\(dataSource.sectionModels[index].identity)")
                return dataSource.sectionModels[index].lgheader
        })
        self.data2.sectionData.asDriver(onErrorJustReturn: [])
            .drive(self.tableView.rx.items(dataSource: tableViewDataSource2))
            .disposed(by: self.disposeBag)
        
    }
    
}


// MARK: - Rx高阶函数： Rx流程操作符
extension KHigherFunSectionVC {
    func test_debug() {
        // **** debug
        // 打印所有订阅、事件和处理。
        print("*****debug*****")
        var count = 1
        
        let sequenceThatErrors = Observable<String>.create { observer in
            observer.onNext("Kongyulu")
            observer.onNext("yifeng")
            observer.onNext("yisheng")
            
            if count < 5 {
                observer.onError(self.kylError)
                print("错误序列来了")
                count += 1
            }
            
            observer.onNext("yuhairong")
            observer.onNext("zhangsiyuan")
            observer.onNext("kongliyuan")
            observer.onCompleted()
            
            return Disposables.create()
        }
        
        sequenceThatErrors
            .retry(3)
            .debug()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    func test_delay() {
        
    }
    
    func test_connect() {
        
    }
    
    /// multicast
    func testMulticastConnectOperators(){
        
        // *** multicast : 将源可观察序列转换为可连接序列，并通过指定的主题广播其发射。
        print("*****multicast*****")
        let subject = PublishSubject<Any>()
        subject.subscribe{print("00:\($0)")}
            .disposed(by: disposeBag)
        
        let netOB = Observable<Any>.create { (observer) -> Disposable in
            sleep(2)// 模拟网络延迟
            print("我开始请求网络了")
            observer.onNext("请求到的网络数据")
            observer.onNext("请求到的本地")
            observer.onCompleted()
            return Disposables.create {
                print("销毁回调了")
            }
            }.publish()
        
        netOB.subscribe(onNext: { (anything) in
            print("订阅1:",anything)
        })
            .disposed(by: disposeBag)
        
        // 我们有时候不止一次网络订阅,因为有时候我们的数据可能用在不同的额地方
        // 所以在订阅一次 会出现什么问题?
        netOB.subscribe(onNext: { (anything) in
            print("订阅2:",anything)
        })
            .disposed(by: disposeBag)
        
        _ = netOB.connect()
        
    }
    
    /// replay
    func testReplayConnectOperators(){
        
        // **** replay: 将源可观察序列转换为可连接的序列，并将向每个新订阅服务器重放以前排放的缓冲大小
        // 首先拥有和publish一样的能力，共享 Observable sequence， 其次使用replay还需要我们传入一个参数（buffer size）来缓存已发送的事件，当有新的订阅者订阅了，会把缓存的事件发送给新的订阅者
        print("*****replay*****")
        
//        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance).replay(5)
//
//        interval.subscribe(onNext: { print(Date.time,"订阅: 1, 事件: \($0)") })
//            .disposed(by: self.disposeBag)
//
//        delay(2) { _ = interval.connect() }
//
//        delay(4) {
//            interval.subscribe(onNext: { print(Date.time,"订阅: 2, 事件: \($0)") })
//                .disposed(by: self.disposeBag)
//        }
//
//        delay(8) {
//            interval.subscribe(onNext: { print(Date.time,"订阅: 3, 事件: \($0)") })
//                .disposed(by: self.disposeBag)
//        }
//        delay(20, closure: {
//            self.disposeBag = DisposeBag()
//        })
        
        /**
         订阅: 1, 事件: 4
         订阅: 1, 事件: 0
         2019-05-28 21-32-42 订阅: 2, 事件: 0
         2019-05-28 21-32-42 订阅: 1, 事件: 1
         2019-05-28 21-32-42 订阅: 2, 事件: 1
         2019-05-28 21-32-45 订阅: 2, 事件: 4
         2019-05-28 21-32-46 订阅: 3, 事件: 0
         2019-05-28 21-32-46 订阅: 3, 事件: 1
         2019-05-28 21-32-46 订阅: 3, 事件: 2
         2019-05-28 21-32-46 订阅: 3, 事件: 3
         2019-05-28 21-32-46 订阅: 3, 事件: 4
         
         // 序列从 0开始
         // 定时器也没有断层  sub2 sub3 和 sub1 是同步的
         */
    }
    
    /// push - connect 将源可观察序列转换为可连接序列
    func testPushConnectOperators(){
        
        // **** push:将源可观察序列转换为可连接序列
        // 共享一个Observable的事件序列，避免创建多个Observable sequence。
        // 注意:需要调用connect之后才会开始发送事件
        print("*****testPushConnect*****")
        
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance).publish()
        
        interval.subscribe(onNext: { print("订阅: 1, 事件: \($0)") })
            .disposed(by: disposeBag)
        
        delay(2) {
            _ = interval.connect()
        }
        delay(4) {
            interval.subscribe(onNext: { print("订阅: 2, 事件: \($0)") })
                .disposed(by: self.disposeBag)
        }
        delay(6) {
            interval.subscribe(onNext: { print("订阅: 3, 事件: \($0)") })
                .disposed(by: self.disposeBag)
        }
        delay(10, closure: {
            //self.disposeBag = DisposeBag()
        })
        /**
         订阅: 1, 事件: 1
         订阅: 2, 事件: 1
         订阅: 1, 事件: 2
         订阅: 2, 事件: 2
         订阅: 1, 事件: 3
         订阅: 2, 事件: 3
         订阅: 3, 事件: 3
         
         订阅: 2 从1开始
         订阅: 3 从3开始
         */
        // 但是后面来的订阅者，却无法得到之前已发生的事件
    }
    
    /// 没有共享序列
    func testWithoutConnect() {
        
        print("*****testWithoutConnect*****")
        
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        
        interval.subscribe(onNext: { print("订阅: 1, 事件: \($0)") })
            .disposed(by: disposeBag)
        
        delay(3) {
            interval.subscribe(onNext: { print("订阅: 2, 事件: \($0)") })
                .disposed(by: self.disposeBag)
        }
        delay(10, closure: {
            //self.disposeBag = DisposeBag()
        })
        
        // 发现有一个问题:在延时3s之后订阅的Subscription: 2的计数并没有和Subscription: 1一致，而是又从0开始了，如果想共享，怎么办?
    }
    
    /// 延迟几秒执行
    func delay(_ delay: Double, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }
    
}

// MARK: - Rx高阶函数： 从可观察对象的错误通知中恢复的操作符
extension KHigherFunSectionVC {
    
    
    /// 从错误事件中恢复，方法是返回一个可观察到的序列，该序列发出单个元素，然后终止
    func test_catchErrorJustReturn() {
        // **** catchErrorJustReturn
        // 从错误事件中恢复，方法是返回一个可观察到的序列，该序列发出单个元素，然后终止
        print("*****catchErrorJustReturn*****")
        let sequenceThatFails = PublishSubject<String>()
        
        sequenceThatFails
            .catchErrorJustReturn("kongyulu")
            .subscribe{print($0)}
            .disposed(by: disposeBag)
        
        sequenceThatFails.onNext("yifeng")
        sequenceThatFails.onNext("yisheng")// 正常序列发送成功的
        sequenceThatFails.onError(self.kylError) //发送失败的序列,一旦订阅到位 返回我们之前设定的错误的预案
    }
    
    
    /// 通过切换到提供的恢复可观察序列，从错误事件中恢复
    func test_catchError() {
        // **** catchErrorJustReturn
        // 从错误事件中恢复，方法是返回一个可观察到的序列，该序列发出单个元素，然后终止
        print("*****catchErrorJustReturn*****")
        let sequenceThatFails = PublishSubject<String>()
        
        sequenceThatFails
            .catchErrorJustReturn("kongyulu")
            .subscribe{print($0)}
            .disposed(by: disposeBag)
        
        sequenceThatFails.onNext("yifeng")
        sequenceThatFails.onNext("yisheng")// 正常序列发送成功的
        sequenceThatFails.onError(self.kylError) //发送失败的序列,一旦订阅到位 返回我们之前设定的错误的预案
        
        // **** catchError
        // 通过切换到提供的恢复可观察序列，从错误事件中恢复
        print("*****catchError*****")
        
        let recoverySequence = PublishSubject<String>()
        
        recoverySequence
            .catchError {
                print("Error:",$0)
                return recoverySequence // 获取到了错误序列-我们在中间的闭包操作处理完毕,返回给用户需要的序列(showAlert)
            }
            .subscribe{print($0)}
            .disposed(by: disposeBag)
        
        sequenceThatFails.onNext("test1")
        sequenceThatFails.onNext("test2")  // 正常序列发送成功的
        sequenceThatFails.onError(kylError) // 发送失败的序列
        
        recoverySequence.onNext("yuhairong")
        
    }
    
    
    /// 通过无限地重新订阅可观察序列来恢复重复的错误事件
    func test_retry() {
        // *** retry: 通过无限地重新订阅可观察序列来恢复重复的错误事件
        print("*****retry*****")
        var count = 1 // 外界变量控制流程
        let sequenceRetryErrors = Observable<String>.create { (observer) -> Disposable in
            observer.onNext("kongyulu")
            observer.onNext("yifeng")
            observer.onNext("yisheng")
            
            if count == 1 { // 流程进来之后就会过度-这里的条件可以作为出口,失败的次数
                observer.onError(self.kylError)
                print("错误序列来了")
                count += 1
            }
            
            observer.onNext("test1")
            observer.onNext("test2")
            observer.onNext("test3")
            observer.onCompleted()
            return Disposables.create()
        }
        
        sequenceRetryErrors
            .retry() //调用这个retry后，上面的observer闭包会重新执行一次
            .subscribe(onNext: {print($0)})
            .disposed(by: disposeBag)
    }
    
    
    /// retry(_:): 通过重新订阅可观察到的序列，重复地从错误事件中恢复，直到重试次数达到max未遂计数
    func test_retry2() {
        // **** retry(_:): 通过重新订阅可观察到的序列，重复地从错误事件中恢复，直到重试次数达到max未遂计数
        print("*****retry(_:)*****")
        var count = 1 // 外界变量控制流程
        let sequenceThatErrors = Observable<String>.create { observer in
            observer.onNext("kongyulu")
            observer.onNext("yifeng")
            observer.onNext("yisheng")
            
            if count < 5 { // 这里设置的错误出口是没有太多意义的额,因为我们设置重试次数
                observer.onError(self.kylError) //发送错误消息
                print("错误序列来了")
                count += 1
            }
            //发送错误后，下面的sender都不会打印了
            observer.onNext("sender 1")
            observer.onNext("sender 2")
            observer.onNext("sender 3")
            observer.onCompleted()
            
            return Disposables.create()
        }
        
        sequenceThatErrors
            .retry(3) //重复地从错误事件中恢复3次
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
}




// MARK: - Rx高阶函数： 集合控制操作符
extension KHigherFunSectionVC {
    
    
    /// 将一个可观察序列转换为一个数组，将该数组作为一个新的单元素可观察序列发出，然后终止
    func test_toArray() {
        // *** toArray: 将一个可观察序列转换为一个数组，将该数组作为一个新的单元素可观察序列发出，然后终止
        print("*****toArray*****")
        Observable.range(start: 1, count: 10)
            .toArray() //这里生成一个从1到10的数组
            .subscribe { print($0) }
            .disposed(by: disposeBag)
    }
    
    
    /// 从一个设置的初始化值开始，然后对一个可观察序列发出的所有元素应用累加器闭包，并以单个元素可观察序列的形式返回聚合结果 - 类似scan
    func test_reduce() {
        // *** reduce: 从一个设置的初始化值开始，然后对一个可观察序列发出的所有元素应用累加器闭包，并以单个元素可观察序列的形式返回聚合结果 - 类似scan
        print("*****reduce*****")
        Observable.of(10, 100, 1000)
            .reduce(1, accumulator: +) // 1 + 10 + 100 + 1000 = 1111
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    
    /// 以顺序方式连接来自一个可观察序列的内部可观察序列的元素，在从下一个序列发出元素之前，等待每个序列成功终止
    /// 用来控制顺序
    func test_concat() {
        // *** concat: 以顺序方式连接来自一个可观察序列的内部可观察序列的元素，在从下一个序列发出元素之前，等待每个序列成功终止
        // 用来控制顺序
        print("*****concat*****")
        let subject1 = BehaviorSubject(value: "kongyulu")
        let subject2 = BehaviorSubject(value: "1")
        
        let subjectsSubject = BehaviorSubject(value: subject1)
        
        subjectsSubject.asObservable()
            .concat()
            .subscribe { print($0) }
            .disposed(by: disposeBag)
        
        subject1.onNext("yifeng")
        subject1.onNext("yisheng")
        
        subjectsSubject.onNext(subject2)
        
        subject2.onNext("打印不出来")
        subject2.onNext("2")
        
        //subject1.onCompleted() // 必须要等subject1 完成了才能订阅到! 用来控制顺序 网络数据的异步
        subject2.onNext("3")
    }
    
}





// MARK: - Rx高阶函数： 过滤条件操作符
extension KHigherFunSectionVC {
    ///仅从满足指定条件的可观察序列中发出那些元素
    func test_fliter() {
        // **** filter : 仅从满足指定条件的可观察序列中发出那些元素
        print("*****filter*****")
        Observable.of(1,2,3,4,5,6,7,8,9,0)
            .filter{$0 % 2 == 0}
            .subscribe(onNext: {print($0)})
            .disposed(by: disposeBag)
    }
    
    ///抑制可观察序列发出的顺序重复元素
    func test_distinctUntilChanged() {
        // ***** distinctUntilChanged: 抑制可观察序列发出的顺序重复元素
        print("*****distinctUntilChanged*****")
        Observable.of("1", "2", "2", "2", "3", "3", "4")
            .distinctUntilChanged()
            .subscribe(onNext: {print($0)})
            .disposed(by: disposeBag)
    }
    
    ///仅在可观察序列发出的所有元素的指定索引处发出元素
    func test_elementAt() {
        // **** elementAt: 仅在可观察序列发出的所有元素的指定索引处发出元素
        print("*****elementAt*****")
        Observable.of("C", "o", "o", "c", "i")
            .elementAt(3)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    ///只发出可观察序列发出的第一个元素(或满足条件的第一个元素)。如果可观察序列发出多个元素，将抛出一个错误。
    func test_single() {
        // *** single: 只发出可观察序列发出的第一个元素(或满足条件的第一个元素)。如果可观察序列发出多个元素，将抛出一个错误。
        print("*****single*****")
        Observable.of("kongyulu", "yuhairong")
            .single()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    func test_single2() {
        // *** single: 只发出可观察序列发出的第一个元素(或满足条件的第一个元素)。如果可观察序列发出多个元素，将抛出一个错误。
        print("*****single*****")
        Observable.of("kongyulu", "yuhairong")
            .single{ $0 == "kongyulu"}
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    ///只从一个可观察序列的开始发出指定数量的元素。 上面signal只有一个序列 在实际开发会受到局限 这里引出 take 想几个就几个
    func test_take() {
        // **** take: 只从一个可观察序列的开始发出指定数量的元素。 上面signal只有一个序列 在实际开发会受到局限 这里引出 take 想几个就几个
        print("*****take*****")
        Observable.of("kongyulu", "yuhairong","yifeng", "yisheng")
            .take(2)//这里取前面两个
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    func test_take2() {
        // **** take: 只从一个可观察序列的开始发出指定数量的元素。 上面signal只有一个序列 在实际开发会受到局限 这里引出 take 想几个就几个
        print("*****take*****")
        Observable.of("kongyulu", "yuhairong","yifeng", "yisheng")
            .take(3)//这里取前面三个
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    //仅从可观察序列的末尾发出指定数量的元素
    func test_takeLast() {
        // *** takeLast: 仅从可观察序列的末尾发出指定数量的元素
        print("*****takeLast*****")
        Observable.of("kongyulu", "yuhairong","yifeng", "yisheng")
            .takeLast(3)//取从末尾开始算起的3个元素
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    ///只要指定条件的值为true，就从可观察序列的开始发出元素
    func test_takeWhile() {
        // **** takeWhile: 只要指定条件的值为true，就从可观察序列的开始发出元素
        print("*****takeWhile*****")
        Observable.of(1, 2, 3, 4, 5, 6)
            .takeWhile { $0 < 3 } //取出满足条件的元素 (1,2)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    /// 从源可观察序列发出元素，直到参考可观察序列发出元素
    /// 这个要重点,应用非常频繁 比如我页面销毁了,就不能获取值了(cell重用运用)
    func test_takeUntil() {
        // ***** takeUntil: 从源可观察序列发出元素，直到参考可观察序列发出元素
        print("*****takeUntil*****")
        let sourceSequence = PublishSubject<String>()
        let referenceSequence = PublishSubject<String>()
        sourceSequence
            .takeUntil(referenceSequence)
            .subscribe(onNext: {print($0)})
            .disposed(by: disposeBag)
        
        sourceSequence.onNext("kongyulu")
        sourceSequence.onNext("yifeng")
        sourceSequence.onNext("yisheng")
        //referenceSequence.onNext("yuhairong") // 条件一出来,下面就走不了
        sourceSequence.onNext("test1")
        sourceSequence.onNext("test2")
        sourceSequence.onNext("test3")
    }
    
    func test_takeUntil2() {
        // ***** takeUntil: 从源可观察序列发出元素，直到参考可观察序列发出元素
        print("*****takeUntil*****")
        let sourceSequence = PublishSubject<String>()
        let referenceSequence = PublishSubject<String>()
        sourceSequence
            .takeUntil(referenceSequence)
            .subscribe(onNext: {print($0)})
            .disposed(by: disposeBag)
        
        sourceSequence.onNext("kongyulu")
        sourceSequence.onNext("yifeng")
        sourceSequence.onNext("yisheng")
        
        referenceSequence.onNext("yuhairong") // 条件一出来,下面就走不了
        
        sourceSequence.onNext("test1")
        sourceSequence.onNext("test2")
        sourceSequence.onNext("test3")
    }
    
    ///从源可观察序列发出元素，直到参考可观察序列发出元素
    /// 这个要重点,应用非常频繁  textfiled 都会有默认序列产生
    func test_skip() {
        // ***** skip: 从源可观察序列发出元素，直到参考可观察序列发出元素
        print("*****skip*****")
        Observable.of(1,2,3,4,5,6)
            .skip(2) //直接跳过前面两个元素，即从3开始
            .subscribe(onNext: {print($0)})
            .disposed(by: disposeBag)
    }
    
    /// 直接跳过满足条件的元素，相当于过滤作用
    func test_skipWhile() {
        print("*****skipWhile*****")
        //skipWhile刚刚和takeWhile的作用相反
        Observable.of(1, 2, 3, 4, 5, 6)
            .skipWhile { $0 < 4 } //直接跳过满足条件的元素，相当于过滤作用（满足小于4的都跳过，即只有4，5，6）
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    
    /// 抑制从源可观察序列发出元素，直到参考可观察序列发出元素
    func test_skipUntil() {
        // *** skipUntil: 抑制从源可观察序列发出元素，直到参考可观察序列发出元素
        // skipUntil 作用刚刚和 takeUntil 相反
        print("*****skipUntil*****")
        let sourceSeq = PublishSubject<String>()
        let referenceSeq = PublishSubject<String>()
        
        sourceSeq
            .skipUntil(referenceSeq)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        // 没有条件命令 下面走不了
        sourceSeq.onNext("kongyulu")
        sourceSeq.onNext("yifeng")
        sourceSeq.onNext("yisheng")
        
        referenceSeq.onNext("yuhairong") // 条件一出来,下面就可以走了
        
        sourceSeq.onNext("test1")
        sourceSeq.onNext("test2")
        sourceSeq.onNext("test3")
    }
    
}



// MARK: - Rx高阶函数： 映射操作符
extension KHigherFunSectionVC {
    /// 转换闭包应用于可观察序列发出的元素，并返回转换后的元素的新可观察序列。
    func test_map() {
        // ***** map: 转换闭包应用于可观察序列发出的元素，并返回转换后的元素的新可观察序列。
        print("*****map*****")
        let ob = Observable.of(1,2,3,4)
        ob.map { (number) -> Int in
            return number + 2
            }
            .subscribe(onNext: {print($0)})
            .disposed(by: disposeBag)
    }
    
    ///将可观测序列发射的元素转换为可观测序列，并将两个可观测序列的发射合并为一个可观测序列。
    ///这也很有用，例如，当你有一个可观察的序列，它本身发出可观察的序列，
    ///你想能够对任何一个可观察序列的新发射做出反应(序列中序列:比如网络序列中还有模型序列)
    func test_flatmap() {
        print("*****flatMap*****")
        let boy = LGPlayer(score: 100)
        let girl = LGPlayer(score: 90)
        let player = BehaviorSubject(value: boy)
        
        player.asObservable()
            .flatMap { $0.score.asObservable() } // 本身score就是序列 模型就是序列中的序列
            .subscribe(onNext: {print($0)})
            .disposed(by: disposeBag)
        
        boy.score.onNext(60)
        player.onNext(girl)
        boy.score.onNext(50)
        boy.score.onNext(40)//  如果切换到 flatMapLatest 就不会打印
        girl.score.onNext(10)
        girl.score.onNext(0)
    }
    
    /// flatMap和flatMapLatest的区别是，flatMapLatest只会从最近的内部可观测序列发射元素
    /// flatMapLatest实际上是map和switchLatest操作符的组合。
    func test_flatMapLatest() {
        print("*****flatMapLatest*****")
        let boy = LGPlayer(score: 100)
        let girl = LGPlayer(score: 90)
        let player = BehaviorSubject(value: boy)
        
        player.asObservable()
            .flatMapLatest { $0.score.asObservable() } // 本身score就是序列 模型就是序列中的序列
            .subscribe(onNext: {print($0)})
            .disposed(by: disposeBag)
        
        boy.score.onNext(60)
        player.onNext(girl)
        boy.score.onNext(50)
        boy.score.onNext(40)//  如果切换到 flatMapLatest 就不会打印
        girl.score.onNext(10)
        girl.score.onNext(0)
    }
    
    ///从初始就带有一个默认值开始，然后对可观察序列发出的每个元素应用累加器闭包，并以单个元素可观察序列的形式返回每个中间结果
    func test_scan() {
        print("*****scan*****")
        Observable.of(10,100,1000)
            .scan(2) { aggregateValue, newValue in
                aggregateValue + newValue // 10 + 2 , 100 + 10 + 2 , 1000 + 100 + 2
            }
            .subscribe(onNext: {print($0)})
            .disposed(by: disposeBag)
    }
}







// MARK: - Rx高阶函数： 组合操作符
extension KHigherFunSectionVC {
    func test_startWith()  {
        // *** startWith : 在开始从可观察源发出元素之前，发出指定的元素序列
        print("*****startWith*****")
        Observable.of("1", "2", "3", "4")
            .startWith("A")
            .startWith("B")
            .startWith("C", "a", "b")
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        //效果: CabBA1234
        
    }
    
    func test_merge()  {
        // **** merge : 将源可观察序列中的元素组合成一个新的可观察序列，并将像每个源可观察序列发出元素一样发出每个元素
        print("*****merge*****")
        let subject1 = PublishSubject<String>()
        let subject2 = PublishSubject<String>()
        // merge
        Observable.of(subject1,subject2)
            .merge()
            .subscribe(onNext: { print($0)})
            .disposed(by: disposeBag)
        
        //- 下面任何一个响应都会勾起新序列响应
        subject1.onNext("K")
        subject1.onNext("o")
        subject2.onNext("n")
        subject2.onNext("g")
        subject1.onNext("Y")
        subject2.onNext("u")
        subject1.onNext("L")
        subject2.onNext("u")
    }
    
    func test_zip()  {
        //  *** zip: 将多达8个源可观测序列组合成一个新的可观测序列，并将从组合的可观测序列中发射出对应索引处每个源可观测序列的元素
        print("*****zip*****")
        let stringSubject = PublishSubject<String>()
        let intSubject = PublishSubject<Int>()
        
        Observable.zip(stringSubject, intSubject) { stringElement , intElement in
            "\(stringElement) \(intElement)"
            }
            .subscribe(onNext: {print($0)})
            .disposed(by: disposeBag)
        
        stringSubject.onNext("K")
        stringSubject.onNext("o") //到这里存储了K o 但是不好响应，除非有另一个响应
        
        intSubject.onNext(1) //勾出一个
        intSubject.onNext(2) //勾出另一个
        stringSubject.onNext("o") //再存一个
        intSubject.onNext(3) //勾出一个
        
        //总结： 只有两个序列同时有值的 时候才会响应，否则只会存值。
        
    }
    
    
    /// combineLatest:将8源可观测序列组合成一个新的观测序列,
    ///并将开始发出联合观测序列的每个源的最新元素可观测序列一旦所有排放源序列至少有一个元素,
    ///并且当源可观测序列发出的任何一个新元素
    func test_combineLatest()  {
        print("*****combineLatest*****")
        let stringSub =  PublishSubject<String>()
        let intSub = PublishSubject<Int>()
        //合并序列
        Observable.combineLatest(stringSub, intSub) { strE, intE in
            "\(strE) \(intE)"
            }
            .subscribe(onNext: {print($0)})
            .disposed(by: disposeBag)
        
        stringSub.onNext("K") //存一个K
        stringSub.onNext("Y") //存了一个覆盖 - 和zip不一样
        intSub.onNext(1) //发现strOB 观察者存在值 Y(上面的Y覆盖了K) 则 响应 Y 1
        intSub.onNext(2) //覆盖1 -> 2, 发现strOB有值YK 响应 Y 2
        stringSub.onNext("Kongyulu") // 覆盖Y -> Kongyulu 发现intOB有值 2 响应：Kongyulu 2
        
        //总结：1. combineLatest 比较zip 会覆盖
        // 2. 应用非常频繁: 比如账户和密码同时满足->才能登陆. 不关系账户密码怎么变化的只要查看最后有值就可以 loginEnable
    }
    
    
    
    // 将可观察序列发出的元素转换为可观察序列，并从最近的内部可观察序列发出元素
    func test_switchLatest()  {
        // switchLatest : 将可观察序列发出的元素转换为可观察序列，并从最近的内部可观察序列发出元素
        print("*****switchLatest*****")
        let switchLatestSub1 = BehaviorSubject(value: "K")
        let switchLatestSub2 = BehaviorSubject(value: "1")
        //注意下面这句代码：这里选择了switchLatestSub1就不会再监听switchLatestSub2
        let switchLatestSub = BehaviorSubject(value: switchLatestSub1)
        
        switchLatestSub.asObservable()
            .switchLatest()
            .subscribe(onNext: {print($0)})
            .disposed(by: disposeBag)
        
        switchLatestSub1.onNext("Y")
        switchLatestSub1.onNext("_")
        switchLatestSub2.onNext("2")
        switchLatestSub2.onNext("3") // 2,3都不会监听，但是默认保存有2 覆盖1  3覆盖2
        switchLatestSub.onNext(switchLatestSub2) //切换到 switchLatestSub2
        switchLatestSub1.onNext("*") //由于上面切换到了switchLatestSub2，所以switchLatestSub1不会响应，不会输出*
        switchLatestSub1.onNext("Kongyulu")//这里不会响应，不会输出Kongyulu
        switchLatestSub2.onNext("4")
        /*
         到这里会输出：
         *****switchLatest*****
         K
         Y
         _
         3
         4
         */
        switchLatestSub.onNext(switchLatestSub1)// 如果再次切换到 switchLatestSub1会打印出 Kongyulu
        switchLatestSub2.onNext("5")
        /*
         到这里会输出：
         *****switchLatest*****
         K
         Y
         _
         3
         4
         Kongyulu
         */
        
    }
}


// MARK: - 核心销毁者
extension KHigherFunSectionVC {
    func limitObservable(){
        
        // 创建序列
        let ob = Observable<Any>.create { (observer) -> Disposable in
            observer.onNext("Cooci")
            return Disposables.create { print("销毁释放了")} // dispose.dispose()
        }
        // 序列订阅
        let dispose = ob.subscribe(onNext: { (anything) in
            print("订阅到了:\(anything)")
        }, onError: { (error) in
            print("订阅到了:\(error)")
        }, onCompleted: {
            print("完成了")
        }) {
            print("销毁回调")
        }
        // 销毁关系
        // status - 算法 - dispose 随时随地都能销毁
        
        // 对象 是无法销毁的
        print("执行完毕")
        dispose.dispose()
    }
    
    func intervalObservableTest(){
        
//        self.intervalOB = Observable<Int>.interval(1, scheduler: MainScheduler.init())
//
//        self.intervalOB.subscribe(onNext: { (num) in
//            self.showSencondNum.text = String(num)
//        }).disposed(by: disposeBag)
//
//        _ = self.stopAction.rx.tap.subscribe(onNext: {
//            print("点击按钮")
//            self.disposeBag = DisposeBag()
//        })
        
        
    }
    
}
