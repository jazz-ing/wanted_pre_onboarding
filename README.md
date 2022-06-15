
# Wanted Pre Onboarding 사전과제

오픈 API를 통해 현재 날씨 정보를 받아와 보여주는 프로젝트

<img width="300" src="https://user-images.githubusercontent.com/78457093/173705599-20cf1f22-f325-41ae-ae91-78793e71a6fd.gif">

# 목차
[1. 프로젝트 개요](#프로젝트-개요)  
[2. 기능 구현](#기능-구현)  
[3. 설계](#설계)  

# 프로젝트 개요
### 아키텍쳐
- MVC 패턴을 활용해 프로젝트 구현
### 기술 스택
|분류|사용 기술|
|------|---|
|UI|· UIKit|
|Networking|· URLSession|
|Encoding/Decoding|· Codable </br> · JSONEncoder,JSONDecoder|
|Caching|· NSCache|

<br>

# 기능 구현

## Main View [(MainWeatherViewController)](https://github.com/jazz-ing/wanted_pre_onboarding/blob/main/WantedPreOnboarding/WantedPreOnboarding/Sources/Controllers/MainWeatherViewController.swift)
<img width="200" src="https://user-images.githubusercontent.com/78457093/173712842-f1b8ca0b-17e1-4b96-a710-ccc3a12a13ec.png">  

- `State` enum을 통해 TableView의 상태를 관리
  - TableView의 상태를 로딩중, 데이터 로드 완료, 에러 상태로 나누어 상태에 따라 뷰를 업데이트하도록 구현
- [WeatherDataUseCase](https://github.com/jazz-ing/wanted_pre_onboarding/blob/main/WantedPreOnboarding/WantedPreOnboarding/Sources/UseCases/WeatherDataUseCase.swift)를 통해 **현재 날씨에 대한 데이터를 로드**해옴
- `prepare(for:sender:)` 메소드를 통해 **Detail View에 데이터 전달**

## Detail View [(DetailWeatherViewController)](https://github.com/jazz-ing/wanted_pre_onboarding/blob/main/WantedPreOnboarding/WantedPreOnboarding/Sources/Controllers/DetailWeatherViewController.swift)
<img width="200" src="https://user-images.githubusercontent.com/78457093/173712837-2614a632-c643-4445-be25-b6abc1ed641a.png">  

- `currentWeather` 변수를 통해 **Main View로부터 데이터를 전달받아** 화면에 보여줌
  - 데이터 전달에 실패할 경우 Alert으로 에러를 알려주고, Alert을 닫으면 이전 화면으로 돌아가도록 구현
- [IconImageUSeCase](https://github.com/jazz-ing/wanted_pre_onboarding/blob/main/WantedPreOnboarding/WantedPreOnboarding/Sources/UseCases/IconImageUseCase.swift)를 통해 **캐시를 활용**해 아이콘 이미지 데이터를 로드해옴


<br>

# 설계

## MVC
두개의 화면만으로 구성된 간단한 프로젝트로 MVC를 통해 구현

### Model
- API를 통해 응답받은 JSON데이터를 디코딩할 모델타입과 테이블뷰에 보여줄 데이터를 구성할 모델 타입 구현
### View
- View에서는 이미 세팅된 데이터를 보여주기만 하도록 간단히 구현 [(Cell 코드 확인하기)](https://github.com/jazz-ing/wanted_pre_onboarding/blob/main/WantedPreOnboarding/WantedPreOnboarding/Sources/Views/CurrentWeatherTableViewCell.swift)
### Controller
- Massive View Controller의 문제를 해결하고자 TableView의 [Datasource](https://github.com/jazz-ing/wanted_pre_onboarding/blob/main/WantedPreOnboarding/WantedPreOnboarding/Sources/Controllers/WeatherTableViewDatasource.swift), [Delegate](https://github.com/jazz-ing/wanted_pre_onboarding/blob/main/WantedPreOnboarding/WantedPreOnboarding/Sources/Controllers/WeatherTableViewDelegate.swift)를 별도의 클래스로 정의해 분리
- 네트워크 호출 및 뷰에 보여줄 형식으로 데이터 포맷 코드 작성

## Network Layer
- URLSession을 활용해 구현한 [네크워킹 타입](https://github.com/jazz-ing/wanted_pre_onboarding/blob/main/WantedPreOnboarding/WantedPreOnboarding/Sources/Networking/NetworkManager.swift)과 [UseCase](https://github.com/jazz-ing/wanted_pre_onboarding/tree/main/WantedPreOnboarding/WantedPreOnboarding/Sources/UseCases)를 분리해 코드의 변경에 대한 안정성을 높임
- [날씨에 대한 EndPoint](https://github.com/jazz-ing/wanted_pre_onboarding/blob/main/WantedPreOnboarding/WantedPreOnboarding/Sources/Networking/WeatherEndPoint.swift)를 Enum으로 구현해 각 요청을 case로 나누고, case별로 URL의 구성요소를 다르게 리턴하도록 연산프로퍼티를 통해 구현  
  - 여러 API에 대응할 수 있도록 URL을 구성하는 요소들인 baseURL, path, query 등을 프로퍼티로 갖는 [EndPointType](https://github.com/jazz-ing/wanted_pre_onboarding/blob/main/WantedPreOnboarding/WantedPreOnboarding/Sources/Networking/EndPointType.swift)이라는 프로토콜 작성  

### Info.Plist를 통한 API Key 보안
- xcconfig파일과 info.Plist, gitignore를 활용해 API Key를 보호

