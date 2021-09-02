# App for Alter Solutions Challenge

[![Build Status](https://app.bitrise.io/app/51778326b5919739/status.svg?token=c0iWcfgcHydCJfdUa9dfZw&branch=main)](https://app.bitrise.io/app/51778326b5919739)
[![codecov](https://codecov.io/gh/maclacerda/alter-solutions-challenge/branch/main/graph/badge.svg?token=YLQv28c0Hu)](https://codecov.io/gh/maclacerda/alter-solutions-challenge)
[![CodeFactor](https://www.codefactor.io/repository/github/maclacerda/alter-solutions-challenge/badge?s=f17e6c4617801851359726ec8fd8cb6c73986b64)](https://www.codefactor.io/repository/github/maclacerda/alter-solutions-challenge)

Aplicação para solução do desafio proposto pela Alter Solutions.
<br/><br/>

# Arquitetura

A arquitetura escolhida para este projeto foi o MVVVM+C, Model View ViewModel com o pattern de Coordinator para realização da navegação entre as cenas.
<br/><br/>

# Construção das views

Foi utilizado o padrão ViewCode para construção das telas.
<br/><br/>

# Bibliotecas de terceiros

Para este desafio foram usadas as seguintes bibliotecas:

* Kingfisher (versão 6.3.1)
    - Download de imagens de forma assíncrona

* RxSwift (versão 6.2.0)
    - Controlar o fluxo de comunicação entre a Controller e a ViewModel

* Firebase (versão 8.6.1)
    - Gerenciamento de eventos de analytics

* AlterSolutionsChallengeCore (https://github.com/maclacerda/alter-solutions-challenge-core)
    - Framework interno

<br/><br/>
# Gerenciador de Dependências

Foi utilizado o SPM (Swift Package Manager) como gerenciador de dependências
<br/><br/>
# Testes

Utilizando o framework `XCTest` para realização dos testes unitários e de UI
<br/><br/>
# Analytics

Para o envio de eventos foi utlizado a plataforma do `Firebase` para ter acesso a dashboard de eventos trackeados acesse: https://analytics.google.com/analytics/web/?hl=pt#/p284946414/reports/home

Nota: O evento acontece ao favoritar ou desfavoritar um Pokemon
<br/><br/>
# Requisitos do Desafio
<br/>

- [x] Pagination<br/>
- [x] Functional programming<br/>
- [x] Dependency Injection<br/>
- [x] Unit Testing<br/>
- [x] UI Testing<br/>
- [x] WebHook - Firebase see # Analytics<br/>
- [x] Adapt UI to mobile orientation changes