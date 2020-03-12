# GradientLayer

* 아래와 같은 그라디언트 속성을 뷰에 부여하고 싶을 때!

* 오토레이아웃 적용이 된 시점 이후에 필요한 경우에 아래와 같이 한다.


```swift
override func viewDidAppear(_ animated: Bool) {
      let grdient = CAGradientLayer(layer: vCircle.layer)
      grdient.colors = [UIColor.blue.cgColor, UIColor.red.cgColor]
      grdient.locations = [0, 1]
      grdient.startPoint = CGPoint(x: 0, y: 0)
      grdient.endPoint = CGPoint(x: 1, y: 1)
      grdient.frame = vCircle.bounds
      // 뷰의 레이어의 상단계층에 그라디언트 속성을 삽입한다.
      vCircle.layer.insertSublayer(grdient, at: 0)
      // 뷰를 원형으로 처리
      vCircle.clipsToBounds = true
      vCircle.layer.cornerRadius = vCircle.frame.width / 2
```
