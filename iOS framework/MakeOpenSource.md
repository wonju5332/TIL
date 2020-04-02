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

* 빈 저장소 URL을 확보 한 후, 라이브러리 위치로 이동 후, 원격저장소로 등록해두고, push
reagit
