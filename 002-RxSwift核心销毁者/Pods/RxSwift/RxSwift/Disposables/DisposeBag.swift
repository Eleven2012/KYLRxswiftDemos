//
//  DisposeBag.swift
//  RxSwift
//
//  Created by Krunoslav Zaher on 3/25/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

extension Disposable {
    /// Adds `self` to `bag`
    ///
    /// - parameter bag: `DisposeBag` to add `self` to.
    public func disposed(by bag: DisposeBag) {
        bag.insert(self)
    }
}

/**
Thread safe bag that disposes added disposables on `deinit`.

This returns ARC (RAII) like resource management to `RxSwift`.

In case contained disposables need to be disposed, just put a different dispose bag
or create a new one in its place.

    self.existingDisposeBag = DisposeBag()

In case explicit disposal is necessary, there is also `CompositeDisposable`.
*/
public final class DisposeBag: DisposeBase {
    
    private var _lock = SpinLock()
    
    // state
    fileprivate var _disposables = [Disposable]()
    fileprivate var _isDisposed = false
    
    /// Constructs new empty dispose bag.
    public override init() {
        super.init()
    }

    /// Adds `disposable` to be disposed when dispose bag is being deinited.
    ///
    /// - parameter disposable: Disposable to add.
    public func insert(_ disposable: Disposable) {
        self._insert(disposable)?.dispose()
    }
    
    private func _insert(_ disposable: Disposable) -> Disposable? {
        //这里为了为了防止多线程下出现抢占资源问题，需要加锁控制同步访问
        self._lock.lock(); defer { self._lock.unlock() }
        if self._isDisposed {//判断如果调用过了_dispose()说明已经被释放过了，不需要再释放，保证对称性，则直接返回
            return disposable
        }
        //保存到数组中
        self._disposables.append(disposable)

        return nil
    }

    /// This is internal on purpose, take a look at `CompositeDisposable` instead.
    private func dispose() {
        // 1.获取到所有保存的销毁者
        let oldDisposables = self._dispose()

        // 2.遍历每个销毁者，掉用每一个销毁者的dispose()释放资源
        for disposable in oldDisposables {
            disposable.dispose()
        }
    }

    private func _dispose() -> [Disposable] {
        self._lock.lock(); defer { self._lock.unlock() }

        // 获取到所有保存的销毁者
        let disposables = self._disposables
        
        self._disposables.removeAll(keepingCapacity: false)
        self._isDisposed = true //这个变量用来记录是否垃圾袋数组被清空过
        
        return disposables
    }
    
    deinit {
        //当DisposeBag自身对象被销毁时，调用自己的dispose(),遍历销毁数组中所有保存的销毁者，
        self.dispose()
    }
}

extension DisposeBag {

    /// Convenience init allows a list of disposables to be gathered for disposal.
    public convenience init(disposing disposables: Disposable...) {
        self.init()
        self._disposables += disposables
    }

    /// Convenience init allows an array of disposables to be gathered for disposal.
    public convenience init(disposing disposables: [Disposable]) {
        self.init()
        self._disposables += disposables
    }

    /// Convenience function allows a list of disposables to be gathered for disposal.
    public func insert(_ disposables: Disposable...) {
        self.insert(disposables)
    }

    /// Convenience function allows an array of disposables to be gathered for disposal.
    public func insert(_ disposables: [Disposable]) {
        self._lock.lock(); defer { self._lock.unlock() }
        if self._isDisposed {
            disposables.forEach { $0.dispose() }
        } else {
            self._disposables += disposables
        }
    }
}
