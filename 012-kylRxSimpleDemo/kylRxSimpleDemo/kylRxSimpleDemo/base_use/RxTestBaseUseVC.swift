//
//  RxTestBaseUseVC.swift
//  kylRxSimpleDemo
//
//  Created by yulu kong on 2019/8/30.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class RxTestBaseUseVC: KBaseViewController {


    /// tableView懒加载
    lazy var tableView: UITableView = {
        let tabView = UITableView.init(frame: view.bounds, style: .plain)
        tabView.tableFooterView = UIView()
        tabView.register(KFunItemCell.classForCoder(), forCellReuseIdentifier: resuseID)
        tabView.rowHeight = 80
        
        return tabView
    }()
    
    var data2 = KSectionBaseFunData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        customSectionModel()
        setTableEvent()
    }
    
    /// 导航栏相关
    override func setupNav() {
        title = "Rx基础函数"
        view.backgroundColor = UIColor.white
        /// 加载tableView
        view.addSubview(tableView)
    }
    

    /// 自定义组模型
   private func customSectionModel() {
        let tableViewDataSource2 = RxTableViewSectionedReloadDataSource<KFunItemSectionDataModel>(configureCell: { [weak self](dataSource, tab, indexPath, model) -> KFunItemCell in
            
            let cell = tab.dequeueReusableCell(withIdentifier: self?.resuseID ?? "resuseID_LGSectionViewController", for: indexPath) as! KFunItemCell
            cell.setUISectionData(model)
            cell.selectionStyle = .none
            return cell
            },titleForHeaderInSection: { dataSource,index -> String in
                // print("数据:\(dataSource.sectionModels[index].identity)")
                return dataSource.sectionModels[index].lgheader
        })
        data2.sectionData.asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(dataSource: tableViewDataSource2))
            .disposed(by: disposeBag)
        
    }
    
    //监听事件
    private func setTableEvent() {
        // tableView点击事件
        tableView.rx.itemSelected.subscribe(onNext: { [weak self](indexPath) in
            print("点击\(indexPath)行")
            //self?.navigationController?.pushViewController(LGSectionViewController(), animated: true)
            
            self?.tableView.deselectRow(at: indexPath, animated: true)
        }).disposed(by: disposeBag)
    }
}

// MARK - 创建序列
extension RxTestBaseUseVC {
    /*
     just()
     （1）该方法通过传入一个默认值来初始化。
     （2）下面样例我们显式地标注出了 observable 的类型为 Observable，即指定了这个 Observable 所发出的事件携带的数据类型必须是 Int 类型的。
     */
    private func test_func_just() {
        let observable = Observable<Int>.just(5)
        _ = observable.subscribe {
            print($0)
        }

    }
    
    /*
     of()
     （1）该方法可以接受可变数量的参数（必需要是同类型的）
     （2）下面样例中我没有显式地声明出 Observable 的泛型类型，Swift 也会自动推断类型。
     */
    private func test_func_of() {
        let observable = Observable.of("A", "B", "C")
        _ = observable.subscribe {
            print($0)
        }

    }
    
    /*
     from()
     （1）该方法需要一个数组参数。
     （2）下面样例中数据里的元素就会被当做这个 Observable 所发出 event 携带的数据内容，最终效果同上面饿 of() 样例是一样的。
     */
    private func test_func_from() {
        let observable = Observable.from(["A", "B", "C"])
        _ = observable.subscribe {
            print($0)
        }

    }
    
    /*
     empty()
     该方法创建一个空内容的 Observable 序列。
     */
    private func test_func_empty() {
        let observable = Observable<Int>.empty()
        _ = observable.subscribe {
            print($0)
        }

    }
    
    /*
     never()
     该方法创建一个永远不会发出 Event（也不会终止）的 Observable 序列。
     */
    private func test_func_never() {
        let observable = Observable<Int>.never()
        _ = observable.subscribe {
            print($0)
        }
    }
    
    /*
     error() 方法
     该方法创建一个不做任何操作，而是直接发送一个错误的 Observable 序列。
     */
    enum MyError: Error {
        case A
        case B
    }
    private func test_func_error() {
        let observable = Observable<Int>.error(MyError.A)
        _ = observable.subscribe {
            print($0)
        }
    }
    
    /*
     range() 方法
     （1）该方法通过指定起始和结束数值，创建一个以这个范围内所有值作为初始值的 Observable 序列。
     （2）下面样例中，两种方法创建的 Observable 序列都是一样的。
     */
    private func test_func_range() {
        //使用range()
        let observable = Observable.range(start: 1, count: 5)
        _ = observable.subscribe {
            print($0)
        }
        
        //使用of()
        let observable2 = Observable.of(1, 2, 3 ,4 ,5)
        _ = observable2.subscribe {
            print($0)
        }
    }
    
    /*
     repeatElement() 方法
     该方法创建一个可以无限发出给定元素的 Event 的 Observable 序列（永不终止）。
     */
    private func test_func_repeatElement() {
        let observable = Observable.repeatElement(1)
        _ = observable.subscribe {
            print($0)
        }
    }
    
    /*
     generate() 方法
     （1）该方法创建一个只有当提供的所有的判断条件都为 true 的时候，才会给出动作的 Observable 序列。
     （2）下面样例中，两种方法创建的 Observable 序列都是一样的。
     */
    private func test_func_generate() {
        //使用generate()方法
        let observable = Observable.generate(
            initialState: 0,
            condition: { $0 <= 10 },
            iterate: { $0 + 2 }
        )
        _ = observable.subscribe {
            print($0)
        }
        
        //使用of()方法
        let observable2 = Observable.of(0 , 2 ,4 ,6 ,8 ,10)
        _ = observable2.subscribe {
            print($0)
        }

    }
    
    /*
     create() 方法
     （1）该方法接受一个 block 形式的参数，任务是对每一个过来的订阅进行处理。
     （2）下面是一个简单的样例。为方便演示，这里增加了订阅相关代码
     */
    private func test_func_create() {
        //这个block有一个回调参数observer就是订阅这个Observable对象的订阅者
        //当一个订阅者订阅这个Observable对象的时候，就会将订阅者作为参数传入这个block来执行一些内容
        let observable = Observable<String>.create{observer in
            //对订阅者发出了.next事件，且携带了一个数据"hangge.com"
            observer.onNext("hangge.com")
            //对订阅者发出了.completed事件
            observer.onCompleted()
            //因为一个订阅行为会有一个Disposable类型的返回值，所以在结尾一定要returen一个Disposable
            return Disposables.create()
        }
        
        //订阅测试
        _ = observable.subscribe {
            print($0)
        }

    }
    
    /*
     deferred() 方法
     （1）该个方法相当于是创建一个 Observable 工厂，通过传入一个 block 来执行延迟 Observable 序列创建的行为，而这个 block 里就是真正的实例化序列对象的地方。
     （2）下面是一个简单的演示样例：
     */
    private func test_func_deferred() {
        //用于标记是奇数、还是偶数
        var isOdd = true
        
        //使用deferred()方法延迟Observable序列的初始化，通过传入的block来实现Observable序列的初始化并且返回。
        let factory : Observable<Int> = Observable.deferred {
            
            //让每次执行这个block时候都会让奇、偶数进行交替
            isOdd = !isOdd
            
            //根据isOdd参数，决定创建并返回的是奇数Observable、还是偶数Observable
            if isOdd {
                return Observable.of(1, 3, 5 ,7)
            }else {
                return Observable.of(2, 4, 6, 8)
            }
        }
        
        //第1次订阅测试
        _ = factory.subscribe { event in
            print("\(isOdd)", event)
        }
        
        //第2次订阅测试
        _ = factory.subscribe { event in
            print("\(isOdd)", event)
        }

    }
    
    /*
     interval() 方法
     （1）这个方法创建的 Observable 序列每隔一段设定的时间，会发出一个索引数的元素。而且它会一直发送下去。
     （2）下面方法让其每 1 秒发送一次，并且是在主线程（MainScheduler）发送。
     */
    private func test_func_interval() {
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        _ = observable.subscribe { event in
            print(event)
        }

    }
    
    /*
     timer() 方法
     (1) 这个方法有两种用法，一种是创建的 Observable 序列在经过设定的一段时间后，产生唯一的一个元素。
     (2) 另一种是创建的 Observable 序列在经过设定的一段时间后，每隔一段时间产生一个元素。
     */
    private func test_func_timer() {
        //5秒种后发出唯一的一个元素0
        let observable = Observable<Int>.timer(5, scheduler: MainScheduler.instance)
        _ =  observable.subscribe { event in
            print(event)
        }

        //延时5秒种后，每隔1秒钟发出一个元素
        let observable2 = Observable<Int>.timer(5, period: 1, scheduler: MainScheduler.instance)
        _ = observable2.subscribe { event in
            print(event)
        }

    }
    
   
    
}
