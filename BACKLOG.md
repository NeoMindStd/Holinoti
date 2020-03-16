# BACKLOG

## USER STORY

#### 관리자용 앱(App for Admin)
 - 이 프로젝트는 관리자가 시설의 기본적인 영업시간, 영업요일 등을 올리고, 최고 관리자(사장 등)가 다른 관리자(알바 등)을 관리할 수 있고, 공사, 여행등으로 인한 임시 휴일시 앱에 등록하여 고객들이 볼 수 있도록 공지하는 기능을 주 목표로 삼고 있습니다.

#### 고객용 앱(App for Customer)
 - 이 프로젝트는 고객들이 원하는 시설(식당, 공원, 도서관 등)을 조회하여 영업시간을 볼 수 있고, 임시 휴일 여부를 확인할 수 있으며, 즐겨찾기 등록하여 임시휴일 등록시 알람을 받는 기능을 제공하는 것을 주 목표로 합니다.

위 두가지 앱은 Dart, Java, Kotlin, Swift로 작성되어 Flutter VM으로 구동됩니다.

상태관리로는 rxdart와 Stream을 사용합니다.(Stateful 등은 웬만하면 지양해주세요)

디자인패턴은 BLoC(비즈니스 로직 컴포넌트)를 적용하여, 모델(객체)-BLoC(실제 동작)-위젯(화면상에 보여지는 위젯)으로 구성됩니다.

#### DB
 - MySQL 또는 MariaDB를 이용합니다.

  - 앱에서 요구하는 데이터를 저장하고 조회할 수 있도록 하고, 비밀번호 등 민감한 개인정보는 암호화하여 저장하는 것이 주 목표입니다.
  
  - 대량의 데이터 처리를 위한 트랜잭션 최적화, 보안이 부가목표입니다

#### 처리 서버
 - 처리 서버는 관리자용 앱과 고객용 앱의 데이터 요청을 처리하는 역할을 합니다. 두 앱에서 서버의 데이터를 요청하면, DB서버에서 조회,수정,삽입,삭제를 하는 역할입니다. 또, firebase를 이용하여 관리자용 앱에서 임시휴일 등록 시 고객용 앱에 알람을 보내는 역할도 맡을 예정입니다. 

 - Spring boot 프레임워크 상에서 Java로 작성되어 Apache Tomcat 서버에서 구동됩니다. Lombok 어노테이션 프로세서를 사용하여 코드를 간략화 시키고, 디자인패턴으로는 MVC패턴을 사용합니다. MVC패턴은 모델-뷰-컨트롤러로 구성되지만, 이 프로젝트에서는 처리 서버만 구현하면 되므로 실질적으로 뷰를 제외한 모델과 컨트롤러만으로 구성됩니다.

## TODO LIST

#### 공통(General)
- 사용한 오픈소스 라이브러리 표기 (Add the licenses page)
- 개인정보 처리방침 등록 (Add the privacy policy page)
- REST API 이용 보안 키 등록 (Change to use security key for rest api)
- README.md에서 영어 번역을 README_EN.md로 분리 (Move english translation into README_EN.md in README.md)

#### 관리자용 앱(App for Admin)
- 가게 수정 및 삭제, 운영시간 수정 및 삭제, 회원정보 관리 및 회원 탈퇴기능 도입 (Implement features that edit and delete facilities, update and delete operating hours, manage member information and membership withdrawal)
- 비정기 휴일, 영업일 등록기능 도입 (Implement a feature that register irregular holiday and business day)

#### 고객용 앱(App for Customer)
- 가게 즐겨찾기 기능 추가 (Implement a feature that facilities favorites)
- 비정기 휴일, 영업일 등록 시 푸시 알림 예약기능 추가 - 서버 단 (Implement a feature that add push notification when registered irregular holiday and business day - server side)

#### 서버(Server)
- 로그인 시 서버에서 처리 후 토큰 교환하는 방식으로 변경 (Change the login method to use tokens)
- 데이터베이스에 비밀번호 저장 시 SHA 해싱 암호화 적용 (Apply SHA hashing encryption when storing passwords in the database)