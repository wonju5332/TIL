# 프로비져닝 프로파일 갱신하기

* 현재 앱스토어에 등록되어 있는 제품의 릴리즈용 프로비져닝 프로파일의 만료기간을 초과하여, 만료된 상태이다.
* TestFlight에 업로드 하려고 했더니, 프로비져닝 문제로 업로드할 수 없는 상태였고, 아래와 같은 검색결과를 얻었다.

>When a Distribution Certificate is about to expire, you must create a new certificate and then create new App Store and Ad Hoc Provisioning Profiles that use the new certificate. These files are uploaded to the mag+ Publish portal where you then rebuild your app and submit an update to iTunes Connect.

* 즉, 새로운 프로비져닝 프로파일을 만들고 등록하여 사용해야 한다는 것이다.

1. 맥에서 keyChain 앱을 열고, 키체인 접근 > 인증기관에서 인증요청을 선택한다.

2. 디스크에 저장 하고, CSR 파일을 생성한다.
3. Apple Developer 사이트에 로그인 하고, certificate항목으로 간다.
4. 추가 버튼을 눌러, private key를 확인 후, 목적에 맞게 선택 후, 인증서를 생성한다.
5. 만료된 인증서를 선택 후, 편집모드로 들어가서, 새로 생성된 인증서를 적용하거나, 또는 새로 생성된 인증서를 다운받아서 설치한다.
---
참고자료
[Renewing a Distribution Certificate](https://support.magplus.com/hc/en-us/articles/204967377)
