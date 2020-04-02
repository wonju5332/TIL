# 오픈소스 라이브러리 만들기

* [레퍼런스](https://yagom.net/courses/open-source-library/lessons/코코아팟-톺아보기/)


###  코코아팟 톺아보기

* 코코아팟이란

* Podfile 에 사용할 라이브러리만 명시해주면 프로젝트에서 자유롭게 사용할 수 있게 도와주는 의존성 관리 도구

* pod install 로 코코아팟 라이브러리를 설치하게 되면, .xcodeproj가 아닌 .xcworkspace 에서 작업을 해야한다.

* 복수의 프로젝트를 워크스페이스 단위로 묶어놓는 것인데, 이유는 여러 Xcode 프로젝트의 의존성을 맺어주기 위함이다.


* Pods 프로젝트가 전역으로 관리되는 것은 아니다. 워크스페이스에 복수개의 프로젝트가 포함되어 있다면, Podfile에서 각 프로젝트에 원하는 라이브러리 의존성을 추가하여 **개별적** 으로 사용할 수도 있다.

```
platform :ios, '13.0'
source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

workspace 'MyApp'

target 'MyApp1' do
    project 'MyApp1/MyApp1'

    pod 'SwiftSVG'
    pod 'SwiftLint'
end

target 'MyApp2' do
    project 'MyApp2/MyApp2'

    pod 'Kingfisher'
    pod 'Alamofire'
end

```

### Podfile?
* 가져올 Pod의 버전을 명시한다.


* 0.1보다 높은 버전 > 0.1
* 0.1 이고 보다 높은 버전 >= 0.1
* 0.1보다 낮은 버전 < 0.1
* 0.1이고 보다 낮은 버전 <= 0.1
* 0.1.2 이상이지만, 0.2보다는 낮은 버전 ~> 0.1.2
* 0.1 이상이지만, 1.0 보다는 낮은 버전(1.0은 포함X) ~> 0.1


### Podfile.lock?

* pod install을 하고 나면 Podfile.lock 이라는 파일이 생깁니다. pod들의 버전을 계속 추적하여 기록해놓고 유지시키는 역할을 합니다.
또한 lock파일의 유지성을 보증하는 해쉬값인 체크섬이 부여된다. 따라서, 하나라도 변화가 생기면, podfile.lock의 체크섬이 변해서 git 에 추적되는 경우에는 podfile.lock도 같이 커밋해야한다.

### 기타 Pods
```
pod install

pod update

pod outdated
>> Podfile.lock에 리스트된 것보다 새로운 버전을 가진 모든 팟을 나열합니다
pod repo update
>> /Users/{사용자이름}/.cocoapods/repos 에 있는 모든 podspec 파일을 업데이트 합니다. podspec 파일에는 해당 pod 의 주소 등 중요한 정보들이 담겨있습니다. podspec 파일에 대한 자세한 설명은 다음 단계에서 다루겠습니다.
```



### 코코아팟 라이브러리 만들기

* 프로젝트 생성을 원하는 디렉토리로 이동하여 pod lib create {라이브러리명} 명령어를 실행합니다.
* Q1) What platform do you want to use?? [ iOS / macOS ]
실습은 iOS 애플리케이션을 기준으로 진행하기 때문에 iOS를 선택하도록 하겠습니다.

* Q2) What language do you want to use?? [ Swift / ObjC ]
언어는 Swift 와 Objective-C 중에서 선택할 수 있습니다. 언어에 따라 4번째 질문인 선택할 수 있는 Testing Framework 가 달라집니다. 언어는 Swift 를 선택하도록 하겠습니다.

* Q3) Would you like to include a demo application with your library? [ Yes / No ]
이 질문은 라이브러리 안에 데모 애플리케이션 포함 여부에 대한 질문입니다. 데모 애플리케이션 포함 여부에 대한 선택은 다른 질문으로 쉽게 답을 고를 수 있습니다. 바로 "이 라이브러리에 대한 화면 스크린샷이 필요한지?" 입니다. 이번 실습은 화면에 나타나는 알럿이 주요 기능이기 때문에 Yes를 선택하도록 하겠습니다.

* Q4-1) Which testing frameworks will you use? [ Specta / Kiwi / None ]
* Q4-2) Which testing frameworks will you use? [ Quick / None ]
4번째 질문은 2개로 나뉠 수 있습니다. Q2에서 언어를 Objc를 골랐다면 Q4-1로 나올 것이고, Swift를 선택했다면 Q4-2로 나옵니다. 이 질문은 테스트를 위한 프레임워크를 추가적으로 사용할 것인지에 대한 질문입니다. 사용하지 않는다면 기본으로 제공되는 Apple의 XCTest를 사용하면 됩니다. 이번 예제에서는 추가적인 프레임워크는 선택하지 않도록 하겠습니다.


### podspec?

* 라이브러리를 생성하게 되면, 같은 경로 내에 .podspec 파일이 함께 생성된다.

* podspec은 팟 라이브러리에 대한 정보를 담고 있다. 일반적인 메타데이터가 포함되어 있다. 문제가 있을 경우 배포 시 에러가 발생할 수 있다.

name: 라이브러리 이름
version: 배포 버전
license: 오픈소스 라이선스 정보
homepage: 홈페이지 주소로 주로 Github 저장소의 메인 페이지를 사용
author: 라이브러리 만든이의 이름과 이메일
summary: 라이브러리에 대한 간단한 설명
source: 라이브러리 소스가 위치해있는 원격 저장소 주소
source_files: 소스 파일이 위치한 디렉토리 주소
frameworks: 사용한 프레임워크

* [작성법 가이드](https://guides.cocoapods.org/syntax/podspec.html)

* s.source 항목을 보면 라이브러리 소스를 받아올 Github 저장소 URL이 기입되어져 있다. 이 부분을 원격저장소 URL을 입력해놓아야 한다.

* 빈 저장소 URL을 확보 한 후, 라이브러리 위치로 이동 후, 원격저장소로 등록해두고, push..


### 배포준비!
#### podspec 확인하기


* 배포를 하기 전에는 .podspec 파일에 이상이 없는지 확인하는 것이다.

```
pod spec lint // .podspec 파일에 명시된 값에 대한 유효성 검증
```

* 검증결과, 실패할 경우 빨간색 글씨로 알려준다.

```
-> WJCoordinator (0.1.0)
   - WARN  | summary: The summary is not meaningful.
   - WARN  | [iOS] swift: The validator used Swift `4.0` by default because no Swift version was specified. To specify a Swift version during validation, add the `swift_versions` attribute in your podspec. Note that usage of a `.swift-version` file is now deprecated.
   - NOTE  | xcodebuild:  note: Using new build system
   - NOTE  | xcodebuild:  note: Building targets in parallel
   - NOTE  | [iOS] xcodebuild:  note: Planning build
   - NOTE  | [iOS] xcodebuild:  note: Constructing build description
   - NOTE  | [iOS] xcodebuild:  warning: Skipping code signing because the target does not have an Info.plist file and one is not being generated automatically. (in target 'App' from project 'App')
   - NOTE  | [iOS] xcodebuild:  note: Execution policy exception registration failed and was skipped: Error Domain=NSPOSIXErrorDomain Code=1 "Operation not permitted" (in target 'WJCoordinator' from project 'Pods')
   - NOTE  | [iOS] xcodebuild:  note: Execution policy exception registration failed and was skipped: Error Domain=NSPOSIXErrorDomain Code=1 "Operation not permitted" (in target 'Pods-App' from project 'Pods')
   - NOTE  | [iOS] xcodebuild:  note: Execution policy exception registration failed and was skipped: Error Domain=NSPOSIXErrorDomain Code=1 "Operation not permitted" (in target 'App' from project 'App')
[!] WJCoordinator did not pass validation, due to 2 warnings (but you can use `--allow-warnings` to ignore them).
You can use the `--no-clean` option to inspect any issue.
```

1. podspec에 적혀있는 버전명과 같은 이름으로 원격저장소에 태그가 있어야 한다.
```
git tag 0.1.0
git push origin master

```
2. podspec에 swift버전을 명시해야 한다.

```

s.swift_versions = '5.0'
```


...

### 배포하기

* 배포를 위해서는 계정인증을 해야한다.

```
pod trunk register wonju5332@hanmail.net wonju
                    {email}             {name}
[!] Please verify the session by clicking the link in the verification email that has been sent to wonju5332@hanmail.net

새로운 컴퓨터에서 작업할때마다 인증을 해줘야 함.
해당 이메일로 가서 verification 을 한다.

```

* 인증 완료 후 podspec파일을 실행한다.

```
pod trunk push WJCoordinator.podspec

--------------------------------------------------------------------------------
 🎉  Congrats

 🚀  WJCoordinator (0.1.0) successfully published
 📅  April 2nd, 22:34
 🌎  https://cocoapods.org/pods/WJCoordinator
 👍  Tell your friends!
--------------------------------------------------------------------------------
```

* 원격저장소 페이지에 가면, pod 뱃지가 활성화 된 것을 확인한다.
[저장소](https://github.com/wonju5332/WJCoordinator)



# 카르타고 톺아보기

* 카르타고는 코코아 앱에 간단하게 프레임워크 혹은 라이브러리를 추가할 수 있도록 도와주는 의존성 관리 도구
* 카르타고는 코코아팟과 달리, 프로젝트 파일이나 빌드 설정을 자동으로 수정하지 않는다.
* 빌드 시점에 같이 빌드되는 코코아팟과는 달라 , 일반적으로 빌드 속도 또한 빠르다.


### 카르타고 설치
* Homebrew를 이용하여, 설치한다.
```
brew install carthage // 설치중..

명령어 소개

carthage update // Cartfile 을 기반으로 모든 의존성 갱신 및 빌드 , 특정 프레임워크만 국한하여 업데이트 할 수 있음

carthage bootstrap // Cartfile.resolved 를 기반으로 모든 의존성을 갱신 및 빌드

carthage build // 갱신하지 않고, 모든 의존성을 빌드

carthage outdated // 새로운 버전 있는지
```

### 프레임워크 생성하기

* 라이브러리가 카르타고를 지원하려면, **프레임워크 파일** 로 만들어줘야 한다.

* 새로운 Xcode 프로젝트를 생성하고, Framework 템플릿을 선택한다.

* 생성하고 나면, 헤더파일과 infoplist 파일 2가지가 존재한다.

* 코코아팟에 배포한 WJCoordinator를 카르타고에도 배포하기 위해서는 아래와 같이 진행하였다.

1. 새로 생성된 프레임워크의 xcodeproj와 WJCoordinator폴더를 복제하여 기존 코코아팟 라이브러리 폴더에 붙여넣어, 병합시킨다.

2. 기존 코코아팟 라이브러리 > Class 의 폴더를 카르타고 배포하기위해 생성한 프레임워크 프로젝트 폴더안에 참조시킨다. 즉 하나의 소스파일을 양쪽 프로젝트에서 참조.

* 위 작업이 잘 되었다면 , 프레임워크 프로젝트 > 빌드페이즈 > Compile source 에 소스가 추가되어있는 것을 확인할 수 있다.

* Manage Schemes 로 들어가 Shared 옵션이 체크되어 있는지 확인합니다. 이미 체크가 되어있어도 해제했다가 다시 체크해주어야 Shared 옵션이 정확히 반영됩니다.

* 마지막으로 Generic iOS device 선택 후 빌드한다.
