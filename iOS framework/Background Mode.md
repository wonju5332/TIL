## iOS App UIKit 의 상태 종류

1. Not Running
2. Foreground (Inactive, Active)
3. BackGround
4. Suspend

![UIKit App State](/assets/스크린샷%202020-01-20%20오후%203.30.10.png)

1. Not Running
App을 실행하지 않은 상태로서, App이 실행되기전 상태 또는 실행되었지만 System에 의해 종료된 상태입니다.
2. Foreground
App이 실행되어 사용자에게 보여지고 있는 상태입니다.
오직 하나의 App만 Foreground 상태를 가지며 inActive와 Active의 두가지 상태로 나뉘어집니다.
InActive : Foreground 상태에서 전화가 왔을때, 잠금상태, 멀티태스킹 스크린에서는 InActive 상태를 가집니다.
Active : inActive 상태가 아닌 상태에 해당합니다.
3. Background
Foreground 상태에서 HomeScreen으로 이동한 상태입니다.
Background 상태로 전환되기 전에 호출된 Task가 끝나지 않은 경우 Background 상태에서도 여전히 실행됩니다.
Background 상태로 전환된 후 호출된 Task는 App이 Foreground 상태로 전환된 후에 실행됩니다.
4. Suspend
App이 Background 상태로 전환된 후 더 이상 작업을 수행하지 않으면 System에서 App을 Suspend 상태로 바꾸게 됩니다.
App은 여전히 메모리에 존재하며 Suspend 상태가 될 당시의 상태를 저장하고 있지만, CPU나 배터리를 소모하지 않습니다.
Suspend 상태의 App은 Foreground 상태의 App을 위해 메모리 부족 등의 이유로 System에 의해 언제든지 종료됩니다. 이후 App을 실행하면 이전 상태의 화면은 나오지 않고 App이 재시작됩니다.


---

백그라운드에서 블루투스를 사용하는 모드

1. BL-Centeral Mode
2. BL-Peripherla Mode



---

[cashwalk 님의 블로그](https://medium.com/cashwalk/ios-background-mode-9bf921f1c55b)
