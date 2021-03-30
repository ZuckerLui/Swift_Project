//
//  RXBaseViewController.swift
//  Swift_Project
//
//  Created by 吕征 on 2021/2/13.
//  Copyright © 2021 lvzheng. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

enum ObservableError: Error {
    case A
    case B
}

class RXBaseViewController: UIViewController {

    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    
    lazy var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 监听textField改变
        textField.rx.text.subscribe { (text: String?) in
            print("textfield: \(text ?? "")")
        }.disposed(by: bag)
        
        textField.rx.text.orEmpty.subscribe { (text) in
            print("textfield1: \(text)")
        }.disposed(by: bag)
                
        // rx中的添加观察者
        textField.rx.observe(String.self, "text").subscribe { (text: String?) in
            
        }.disposed(by: bag)
        
//        customObserver()
//        creatObservableOptions()
//        timerFunc()
    }
    
    @IBAction func openTableViewPage(_ sender: Any) {
        
        let vc = RXTableViewController(nibName: "RXTableViewController", bundle: Bundle.main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func PublishSubjectAction(_ sender: Any) {
        publishSubjectEg()
    }
    
    @IBAction func BehaviorSubjectAction(_ sender: Any) {
        behaviorSubjectEg()
    }
    
    @IBAction func ReplaySubjectAction(_ sender: Any) {
        replaySubjectEg()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

//MARK:创建自定义观察者
extension RXBaseViewController {
    func customObserver() {
        // 观察者,手动将event分类
        let observer : AnyObserver<String> = AnyObserver.init { (event) in
            switch event {
            case .next(let data):
                print("event不提供分类 next: \(data)")
            case .error(let error):
                print("event不提供分类 error: \(error)")
            case .completed:
                print("event不提供分类completed")
            }
        }
        
        let observable = Observable.of("A", "B", "C", "D")
        
        // 订阅(event不提供分类)
        observable.subscribe(observer)
            .disposed(by: bag)
        
        // 订阅（event提供分类）
        observable.subscribe { (item) in
            print(item)
        } onError: { (error) in
            print(error)
        } onCompleted: {
            print("completed")
        } onDisposed: {
            print("disposed")
        }.disposed(by: bag)
        
        // 绑定，ABCD事件会依次走过
        observable.bind(to: numLabel.rx.text).disposed(by: bag)
    }
}

//MARK:静态Observable（Observable需要预先将要发出去的数据准备好）
extension RXBaseViewController {
    func creatObservableOptions() {
        // 单个
        let _ = Observable<String>.just("1")
        
        // 传入若干个同类型
        let _ = Observable.of("1", "2", "3")
        
        // 传入一个数组
        let _ = Observable.from(["1", "2", "3"])
        
        // 创建一个空的Observable 序列
        let _ = Observable<Int>.empty()
        
        // 创建一个永远不会发出event事件的Observable序列
        let _ = Observable<Int>.never()
        
        // 直接发出error事件
        let _ = Observable<Int>.error(ObservableError.A)
        
        // 创建一个以这个范围内所有值作为初始值的Observable序列
        let _ = Observable<Int>.range(start: 1, count: 5)
        
        // 该方法创建一个可以无限发出给定元素的 Event的 Observable 序列（永不终止）
        let _ = Observable.repeatElement(1)
        
        // 这个block有一个回调参数observer就是订阅这个Observable对象的订阅者
        // 当一个订阅者订阅这个Observable对象的时候，就会将订阅者作为参数传入这个block来执行一些内容
        let observable = Observable<String>.create { (observer) -> Disposable in
            // 对订阅者发出了.next事件，且携带了一个数据"creat.com"
            // 且会按顺序执行
            observer.onNext("creat.com")
//            observer.onError(ObservableError.A)
            observer.onCompleted()
            return Disposables.create()
        }
        
        observable.subscribe { (item) in
            print(item)
        } onError: { (error) in
            print(error)
        } onCompleted: {
            print("completion")
        } onDisposed: {
            print("disposed")
        }.disposed(by: bag)
        
        // 循环
        Observable.range(start: 1, count: 10)
            .subscribe { (num: Int) in
                print("\(num)")
            }.disposed(by: bag)

        // 对事件序列进行处理，此时事件并不会执行
        let numberObser = Observable.of("1", "2", "3", "4", "5", "6", "7", "8", "9")
                            .map({ (item) in
                                Int(item)
                            })
                            .filter { (i: Int?) -> Bool in
                                if let item = i, item % 2 == 0{
                                    print("事件：\(item)")
                                    return true
                                }
                                return false
                            }
        // 订阅事件，此时事件才开始执行
        numberObser.subscribe { (event) in
            print("订阅结果：\(event)")
        }.disposed(by: bag)
        
        // 不订阅前2次事件，从第3次订阅
        numberObser.skip(2).subscribe { (event) in
            print("错过2次后的订阅结果：\(event)")
        }.disposed(by: bag)

    }
}


// MARK:timer
extension RXBaseViewController {
    func timerFunc() {
        // 每隔一秒发送一次事件，而且它会一直发送下去。
        let timerObservable = Observable<Int>.interval(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        timerObservable.subscribe { (event) in
            print(event)
        }.disposed(by: bag)
        
        timerObservable.map { (second) -> CGFloat in
            CGFloat(second)
        }.bind(to: numLabel.rx.fontSize)
        .disposed(by: bag)
        
        // 5秒后发送一次事件，且只发送一次
        let _ = Observable<Int>.timer(DispatchTimeInterval.seconds(5), scheduler: MainScheduler.instance)
        
        // 等待5秒后开始发送事件，且之后每一秒发送一次
        let _ = Observable<Int>.timer(DispatchTimeInterval.seconds(5), period: DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
    }
}

// MARK:factory类
extension RXBaseViewController {
    func factoryFunc() {
        // 该个方法相当于是创建一个 Observable 工厂，通过传入一个 block 来执行延迟 Observable序列创建的行为，而这个 block 里就是真正的实例化序列对象的地方。
        let factory : Observable<String> = Observable.deferred { () -> Observable<String> in
            
            return Observable.of("aa", "bb", "cc")
        }
        
        // 序列对象的实力是订阅后发生的
        factory.subscribe { (event) in
            print(event)
        }.disposed(by: bag)
    }
}

//MARK: 动态Observable(Observable能动态的获得、产生数据，再通过Event发出去)
extension RXBaseViewController {
    
    func publishSubjectEg() {
        // publishSubject 最普通的subject,不需要起始值，订阅后可以接收到新发出的event
        let subject = PublishSubject<String>()
        
        subject.onNext("111")
        
        subject.subscribe { (event) in
            print("第1次订阅：" + event)
        } onError: { (error) in
            
        } onCompleted: {
            print("第1次订阅：Completed")
        } onDisposed: {
            
        }.disposed(by: bag)
        
        subject.onNext("222")
        subject.onCompleted()
        subject.onNext("333")

        subject.subscribe(onNext: { string in
            print("第2次订阅：", string)
        }, onCompleted:{
            print("第2次订阅：Completed")
        }).disposed(by: bag)
    }
    
    func behaviorSubjectEg() {
        // BehaviorSubject 需要通过一个默认初始值来创建, 订阅后会立即收到一个Event, 之后就是正常情况
        let subject = BehaviorSubject(value: "111")
        
        subject.subscribe { (event) in
            print("第1次订阅：" + event)
        }.disposed(by: bag)

        subject.onNext("222")
        
        subject.onError(NSError(domain: "local", code: -100, userInfo: nil))
        
        subject.subscribe { (event) in
            print("第2次订阅：" + event)
        }.disposed(by: bag)
    }
    
    func replaySubjectEg() {
        // ReplaySubject 需要设置缓存个数bufferSize，  bufferSize设置为2，它会将最后2个event缓存起来，有subscriber订阅时，会先收到2个缓存的event
        let subject = ReplaySubject<String>.create(bufferSize: 2)
        
        subject.onNext("111")
        subject.onNext("222")
        subject.onNext("333")
        
        subject.subscribe { (event) in
            print("第1次订阅：" + event)
        }.disposed(by: bag)
        
        subject.onNext("444")
        subject.onCompleted()

        subject.subscribe { (event) in
            print("第2次订阅：" + event)
        }.disposed(by: bag)
    }
}

//MARK:UILabel扩展属性
extension Reactive where Base: UILabel {
    public var fontSize: Binder<CGFloat> {
        return Binder(self.base) { label, fontSize in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}

//MARK:
extension RXBaseViewController {
    
}
