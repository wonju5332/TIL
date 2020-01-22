
# Dynamic Size Controller

* 스토리보드 상에서, 하나의 뷰컨트롤러 안에 다양한 UI컴포넌트들이 들어가게 될 경우, 일명 Massive View Controller가 될 가능성이 높다.

* 이를 embeded Contrainer View를 이용하여, 큰 단위의 View단위들을 자식 컨트롤러에게 위임하여 일명 Onion View Conroller 를 만들고자 했다.

----

* 화면 레이아웃

부모 뷰
> 스크롤 뷰
>> 뷰
>>> 뷰 (Child View Controller)
>>> 뷰 (Child View Controller)
>>> ...
>>> 스택뷰 (Child View Controller)

* 위 상황에서, 스택뷰는 동적으로 1개 내지 4개까지 내부의 뷰의 갯수가 늘어날 수 있다.

* 위 상황에서 Container View 로 설정되면, 부모뷰의 높이에 따른 제한된 조건이 걸리게 되기 때문에, 스택뷰의 동적높이의 따른 뷰 화면이 정상적으로 반영되지 않는다.

* 실제 해결한 처리방법
1.  부모뷰컨트롤러에서는 일반적인 오토레이아웃 조건을 생성한다.
2. 자식뷰에서 bottom의 높이에 대한 조건이 생성되는 뷰를 선택하여, bottom의 조건의 우선순위 < 1000 으로 처리한다.
![스크린샷 2020-01-22 오전 10.24.40](/assets/스크린샷%202020-01-22%20오전%2010.24.40.png)
3. 자식뷰컨트롤러의 loadView 사이클에서 부모뷰의 제약조건에 제한받지 않도록 처리한다.

```swift

class ChildViewController: UIViewController {
  @IBOutlet weak var vStack: UIStackView!

  override func viewDidLoad() {
    super.viewDidLoad()
//        viewOuter.backgroundColor = UIColor.clear
//        viewInner.roundCorners(15.0)
//        viewOuter.addViewShadow()

  }
  override func loadView() {
    super.loadView()
    self.view.translatesAutoresizingMaskIntoConstraints = false // 상위 뷰의 조건에 따라가지 않도록 한다.
  }
}

```

## 결과

![Jan-22-2020 10-28-30](/assets/Jan-22-2020%2010-28-30.gif)


---
## 레퍼런스
[Onion controller We Break Screens Into Parts](https://sudonull.com/post/6390-Onion-controller-We-break-screens-into-parts)
[StackOverFlow:Sizing a Container View with a controller of dynamic size inside a scrollview
](https://stackoverflow.com/questions/35014362/sizing-a-container-view-with-a-controller-of-dynamic-size-inside-a-scrollview)
