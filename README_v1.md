# 🚖  Taxi Service

This portfolio case demonstrates my full-cycle system/business analysis capabilities, showcasing a rigorous, standards-driven approach from business process analysis to complete IT architecture specification and API design 

It includes 40+ analysis artifacts,covering the full software lifecycle, including BPMN models, C4 architecture diagrams, Use Cases, Sequence Diagrams, and OpenAPI specifications

The project was developed as part of the [AWG](https://www.awg.ru/en/) In-house System Analysis Individual Training Program (System Thinking, Architecture & API Design), where I had the opportunity to learn directly from  [Lead Solution Architect Andrey Kornienko](https://www.linkedin.com/in/andrei-kornienko/), whose insightful feedback throughout the program helped ensure best-in-class quality

---

- [📝 Summary](#-summary)
       [Notes](#methodological-notes)
- [📝 Analysis Deliverables](#-analysis-deliverables)
  - [BRD](#brd)
    - [Business Context](#business-context)
    - [Process Architecture (Structural Models)](#process-architecture-structural-models)
    - [Process Architecture (Functional Models)](#process-architecture-functional-models)
    - [Data Models](#data-models)
  - [SRS](#srs)
    - [System Architecture](#system-architecture)
    - [Use Cases \& Sequence Diagrams](#use-cases--sequence-diagrams)
    - [API](#api)
      - [REST API](#rest-api)
        - [Контракты](#контракты)
      - [AsyncAPI](#asyncapi)
        - [Kafka topics](#kafka-topics)
        - [RabbitMQ Contracts](#rabbitmq-contracts)
    - [Модели данных](#модели-данных)
    - [NFR: Logging](#nfr-logging)
  - [🧳 Tools](#-tools)

# 📝 Summary

**My Taxi** is a hypothetical regional taxi company that started as a small business with no formal processes or IT systems.
At the start, trip requests were handled manually, with only 7 back-office employees (excluding drivers and technical staff)

Initial scope: document existing processes and design basic automation for trip request management. During the project, the company scaled rapidly, creating new strategic goals:
	•	**End-to-end automation** of key business processes
	•	**Building a scalable IT landscape** with focus on microservices architecture

**Key deliverables**:
- Modeled core business processes
- Evaluated architectural options and selected a microservices-based solution as the target architecture
- Developed detailed requirements and design for two key scenarios:
  - **Trip creation based on customer request**
  - **Customer authentication & authorization** in the app, including Google OAuth 2.0

####  Notes

Due to the training format and fast-changing company context, several assumptions and simplifications were applied:
- The shift from manual to digital operations occurred during the analysis stage. By the architecture phase, the company was modeled as a fast-growing business requiring microservices
- The requirements were refined incrementally, not strictly top-down
---

# 📝 Analysis Deliverables

## BRD

### Business Context
- [Business Model Canvas](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/BRD/Business_Model_Canvas.jpg)
- [Organizational structure and role model](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/BRD/Оргструктура_и_роли.jpg)

### Process Architecture (Structural Models)
- [Value Added Chain Diagram](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/BRD/VAD.jpg)
- [IDEF0-A-0](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/BRD/Процессы/IDEF0-A-0.jpg)
- [IDEF0-A0](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/BRD/Процессы/IDEF0-A0.jpg)
- [IDEF-A2](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/BRD/Процессы/IDEF0-A2.jpg)
- [IDEF0-A22](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/BRD/Процессы/IDEF0-A22.jpg)

### Process Architecture (Functional Models)

| Артефакт                      | Процесс                                        
| ----------------------------- | ----------------------------------------------- 
| BPMN Business Level | [А22. Trip request end-to-end process](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/BRD/Процессы/А22_Поездка_по_заявке_Согласовательный_уровень.png)                          |        |
| BPMN Analytical Level    | [А221. Client request submission](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/BRD/Процессы/А221_Оформление_заявки_клиентом.png)                |        |
| BPMN Analytical Level    | [А222. Driver assignment](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/BRD/Процессы/А222_Назначение_водителя_для_выполнения_Заявки.png) |        |
| BPMN Analytical Level    | [А223. Trip execution](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/BRD/Процессы/А223_Выполнение_поездки.png)                        |        |
| BPMN Analytical Level     | [А224. Trip payment](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/BRD/Процессы/А224_Оплата_поездки.png)                            |        |
| BPMN Analytical Level     | [А225. Driver reportin](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/BRD/Процессы/А225_Отчет_водителя.png)                            |        |

### Data Models
- [Domain model](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/BRD/Данные/МПО.jpg)
- [Context diagram](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/BRD/Данные/Контекстная_диаграмма.jpg)
- [Data Flow Diagram DFD (Level 0)](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/BRD/Данные/DFD_0.jpg)

---

##  SRS

### System Architecture

| Style                      | Diagram                                                                                                                               | Comment              |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- | -------------------- |
|                            | [C4 Context](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/architecture/С4_Context.png)                 |                      |
| Microservices Architecture | [С4 Container](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/architecture/C4_Containers_MSA.png)        | Target solution      |
| Microservices Architecture | [C4 Component](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/architecture/С4._Components.%20MSA.png)    | Target solution      |
| Monolith                 | [С4 Container](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/architecture/С4_Containers.%20Монолит.png) | Alternative solution |
| Monolith                    | [C4 Component](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/architecture/С4_Сomponents_Монолит.png)    | Alternative solution |
| Service-Based Architecture | [С4 Container](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/architecture/С4_Containers.%20SBA.png)     | Alternative solution |
| Service-Based Architecture | [C4 Component](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/architecture/С4_Components.%20SBA.png)     | Alternative solution |

### Use Cases & Sequence Diagrams

| Артефакт                                                                  | |  |  |
| ------------------------------------------------------------------------- | ----- | ------------ | ---------------- |
| Use Case Diagram                                                          |       |  [PNG](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/interactions/use%20cases/Use_Case_Diagram.png)            |                   |
| UC-1. Trip creation by customer request                                          | [Text](https://docs.google.com/document/d/1ZqJkvjLKTLqCCJzmj1DiIwN4VM1ZnYkCHbecq9s-a0c/edit?usp=sharing)      | [Sequence PNG](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/interactions/sequence_diagrams/UC-1_Создание_Поездки_по_Заявке_(route_to_start_status%20%3D%20success).png)             | [Sequence PlantUML ](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/interactions/sequence_diagrams/UC-1_Создание_поездки_по_Заявке.plantuml)                  |
| UC-3. Customer login via phone number                              |       | [Sequence PNG](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/interactions/sequence_diagrams/UC%20-5_Авторизация_клиента_по_номеру_телефона.png)             | [Sequence PlantUML](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/interactions/sequence_diagrams/UC%20-5_Авторизация_клиента_по_номеру_телефона.plantuml)                  |
| UC-2.1 Customer authentication via Google OAuth 2.0                      | [Text](https://docs.google.com/document/d/1We7lsw3FNsDj092ztRCpkdklHSzidylnt3R_bxI74DU/edit?usp=drive_link)      | [Sequence PNG](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/interactions/sequence_diagrams/UC-2_Аутентифкация_клиента_через_OAuth_2_0_Google.png)             | [Sequence PlantUML ](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/interactions/sequence_diagrams/UC-2_Аутентифкация_клиента_через_OAuth_2_0_Google.plantuml)                  |
| UC-2.2 Customer authorization after OAuth 2.0 authentication | [Text](https://docs.google.com/document/d/1xviqh3xp5lOp7Rk8CkKzaOAa_0-QT2CP3HJOTyDjGNs/edit?usp=drive_link)      | [Sequence PNG](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/interactions/sequence_diagrams/UC-4_Авторизация_клиента_аутентифицированного_через_OAuth_2_0_Google.png)             | [Sequence PlantUML](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/interactions/sequence_diagrams/UC-4_Авторизация_клиента_аутентифицированного%20_через_OAuth_2_0_Google.plantuml)                  |

### API

#### REST API

- [OpenAPI Spec at SwaggerHub](https://app.swaggerhub.com/apis/MARGIRB/API_AWG_Taxi_Service/1.0.0)
- [OpenAPI Spec.yaml](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/interactions/api/swagger_3_0.yml)

##### Контракты 

- [INT-ClientAp-1. ClientApp requests OAuth 2.0 authorization URL](https://docs.google.com/document/d/1QHuE8bpfKOh3kytY8n1yOs_1GmTNV0vNHgDm4U1YsMc/edit?usp=drive_link)
- [INT-ClientAp-2. ClientApp requests Auth token ](https://docs.google.com/document/d/1gFTW0mbLO1BZUEAocuhOykplAeJJ8oqx_3PtpT1P1GU/edit?usp=drive_link)
- [INT-AuthService-1. Token exchange with Google OAuth 2.0](https://docs.google.com/document/d/1HVrtgJb2_5ndAenc1h0uQ034NotldAZXoKSM0RrAFQs/edit?usp=drive_link)
- [INT-ClientApр-3. ClientApp requests Access token  from AuthService](https://docs.google.com/document/d/1ajwAOxNQaqtBTaZF_nuA4XEuudcVphU9ZtxNuDIS8RQ/edit?usp=drive_link)
- [INT-ClientApp-4. ClientApp retrieves Customer data from CustomerService](https://docs.google.com/document/d/1ey2wqxpcnpyYepMIUw1fYXAba7P3eiZHsx4yRkeHups/edit?usp=drive_link)
- [INT-TripService-1. Creation Trip on Request in TripService](https://docs.google.com/document/d/1ETf1IHHxLYHFNMMtuXQ5EbkkgftJBDmd1LsfpBpcdYQ/edit?usp=sharing)

#### AsyncAPI

#####  Kafka topics

- [request.status.changed](https://docs.google.com/document/d/1T0QLIuGnHXHvADiKHIi0NMvnHyvKcLCPb_UO03QNJoQ/edit?usp=sharing)
- [ride.request.driver.search](https://docs.google.com/document/d/18ilY3rLyEK8gVlem6EwP6IEX7qC2LL7Z5Sj-VWFc_2k/edit?usp=sharing)
- [ride.request.driver.search.result](https://docs.google.com/document/d/1Pi6DOdaqjBOGwDFASOHLygxIqxvgySBoEnQWPt12t-g/edit?usp=sharing)
- [driver.status.search](https://docs.google.com/document/d/1VN38gYVnKuYeFtyB65GMK5ncWN7Rjw9b4DCBPNOySF0/edit?usp=sharing)
- [driver.status.search.result](https://docs.google.com/document/d/1m5T03u8Hgk1M1yGHXXwYs3Vh4Defg_4aWHSrmzRdu38/edit?usp=sharing)
- [ride.preride.create](https://docs.google.com/document/d/1D4kNdeL-KRzbXybJROS9j1ZPrFvJlsp-Yf5fdF9z158/edit?usp=sharing)
- [fare.preride.search](https://docs.google.com/document/d/1h8Sf4q1hY8SqTZ3Ppp-ZgKdLWWDwUGCsE9_hD-CYBaE/edit?usp=sharing)
- [fare.preride.search.result](https://docs.google.com/document/d/1L6Rt3uK6TNhK9PFDVZX03ZUCZvqrOLqvEagYfu_TvWw/edit?usp=sharing)
- [ride.preride.created](https://docs.google.com/document/d/1gb-u3CAfTpR9nLDw0eh4itRSgBEWPMa5w8Bb5h4VZ9Q/edit?usp=sharing)

#####  RabbitMQ Contracts

- [RabbitMQ Trip v1.1](https://docs.google.com/document/d/1Kbn93PHuyKnpXsAPzQCR0Cr31ZL0diSwc4nHb24H9_4/edit?usp=sharing)

### Data 

- [State Machine](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/data/State_Machine%20.jpg)
- [Data Dictionary](https://docs.google.com/document/d/10KZdMk-CEB4wlowSt70QYX2wTnOXWpxI7LCSUPdLruU/edit?usp=drive_link)
- ERD: [ERD file](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/data/ERD.erd), [PNG](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/data/ERD.png), [SQL file](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/data/ERD_my_taxi.sql)


### NFR: Logging

- [Сервис такси  MyTaxi. Logging requirements specification ](https://docs.google.com/document/d/1x8aJ9HnnHkU61igeE0T3xfub_kynuIIF3RGqaY8Bybg/edit?usp=drive_link)

---


## 🧳 Tools

- **draw.io** for C4, Use Case diagram
- **Miro** for DFD, IDEF0, State Machine
- **StormBPM** for BPMN
- **VS Code** for PlantUML, ERD, OpenAPI 3.0 specification
- **Swagger Hub** for  OpenAPI 3.0 specification
- **Google Docs** for text descriptions


