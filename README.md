# App for Alter Solutions Challenge

[![Build Status](https://app.bitrise.io/app/51778326b5919739/status.svg?token=c0iWcfgcHydCJfdUa9dfZw&branch=main)](https://app.bitrise.io/app/51778326b5919739)
[![codecov](https://codecov.io/gh/maclacerda/alter-solutions-challenge/branch/main/graph/badge.svg?token=YLQv28c0Hu)](https://codecov.io/gh/maclacerda/alter-solutions-challenge)
[![CodeFactor](https://www.codefactor.io/repository/github/maclacerda/alter-solutions-challenge/badge?s=f17e6c4617801851359726ec8fd8cb6c73986b64)](https://www.codefactor.io/repository/github/maclacerda/alter-solutions-challenge)

Application to solve the challenge proposed by Alter Solutions.
<br/><br/>

# Architecture

The architecture chosen for this project was the MVVVM+C, Model View ViewModel with the Coordinator pattern to perform the navigation between scenes.
<br/><br/>

# Construction of views

The ViewCode pattern was used to build the screens.
<br/><br/>

# Third Party Libraries

For this challenge, the following libraries were used:

* Kingfisher (version 6.3.1)
    - Downloading images asynchronously

* RxSwift (version 6.2.0)
    - Control the flow of communication between Controller and ViewModel

* Firebase (version 8.6.1)
    - Analytics Event Management

* AlterSolutionsChallengeCore (https://github.com/maclacerda/alter-solutions-challenge-core)
    - Internal Core Framework

<br/><br/>
# Dependency Manager

The SPM (Swift Package Manager) was used as a dependency manager
<br/><br/>
# Testes

Using the `XCTest` framework to perform unit and UI testing
<br/><br/>
# Analytics

The `Firebase` platform was used to send events to access the dashboard of tracked events, go to: https://analytics.google.com/analytics/web/?hl=pt#/p284946414/reports/home

*Note: The event happens when you favorite or disfavor a Pokemon*
<br/><br/>
# Challenge Requirements
<br/>

- [x] Pagination<br/>
- [x] Functional programming<br/>
- [x] Dependency Injection<br/>
- [x] Unit Testing<br/>
- [x] UI Testing<br/>
- [x] WebHook - Firebase see # Analytics<br/>
- [x] Adapt UI to mobile orientation changes
- [x] Dark Mode Support

<br/><br/>
# Future Features
<br/>

- [ ] Xcodegen / Tuist / Buck<br/>
- [ ] Migrate UI to SwiftUI framework
- [ ] Remove RxSwift and migrate do Combine Framework
- [ ] Bump Target iOS Version