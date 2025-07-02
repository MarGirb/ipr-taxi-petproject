# 🚖 ИПР. Сервис такси

Full-stack бизнес и системный анализ для pet-project "Сервис такси": от бизнес-процессов до API. Разработано более 40 артефактов, включая BPMN, C4, Use Case, Sequence Diagram, OpenAPI Spec

---

## 📌 Содержание

- [🚖 ИПР. Сервис такси](#-ипр-сервис-такси)
  - [📌 Содержание](#-содержание)
- [📝 Описание проекта](#-описание-проекта)
      - [🔍 Методологические комментарии](#-методологические-комментарии)
- [📝 Артефакты анализа](#-артефакты-анализа)
  - [🏢 BRD](#-brd)
    - [Бизнес-контекст](#бизнес-контекст)
    - [Структурные модели процессов](#структурные-модели-процессов)
    - [Функциональные модели процессов](#функциональные-модели-процессов)
    - [Модели данных](#модели-данных)
  - [🏗️ SRS](#️-srs)
    - [Архитектура](#архитектура)
    - [Use Cases \& Sequence Diagrams](#use-cases--sequence-diagrams)
    - [API](#api)
      - [REST API](#rest-api)
        - [Контракты](#контракты)
      - [AsyncAPI](#asyncapi)
        - [Топики Kafka](#топики-kafka)
    - [Модели данных](#модели-данных-1)
    - [Требования к логгированию](#требования-к-логгированию)
  - [🧳 Инструменты](#-инструменты)
  - [👩‍💻 ИПР](#-ипр)

# 📝 Описание проекта

**My Taxi** — условная региональная служба такси, стартовавшая как небольшая компания с неформальной структурой и отсутствием цифровых процессов.
На момент начала анализа в компании работало всего 7 человек (кроме водителей и технического персонала), заявки на поездки принимались вручную, бизнес-процессы были слабо формализованы.

Первоначальный запрос: **задокументировать текущие процессы и предложить базовую автоматизацию приёма заявок**.

Однако в ходе проекта компания начала быстро масштабироваться. Появились новые цели:

- Полная автоматизация ключевых процессов
- Создание современного IT ландшафта с акцентом на быстрое масштабирование

**В рамках проекта реализованы задачи:**

- Построена модель основных процессов компании
- Проанализированы архитектурные варианты — выбран **микросервисный подход** как наиболее гибкий и масштабируемый
- Детально проработаны два ключевых сценария:
  - **Создание поездки по заявке**
  - **Авторизация клиента в клиентском приложении** с углубленной проработкой сценария авторизации через Google OAuth 2.0

#### 🔍 Методологические комментарии

Из-за учебного формата, быстро меняющегося сценария развития компании и сжатых сроков ИПР были сделаны допущения и упрощения:

- Переход от ручной модели к цифровой происходил **в процессе анализа**. На этапе проектирования архитектуры гипотетическая компания трансформировалась из “подвальной” структуры в быстро развивающийся бизнес с запросом на микросервисы
  - Артефакты бизнес-уровня отражают стартовое состояние, но не охватывают финальную целевую модель
- Пирамида требований (бизнес → пользовательские → функциональные → системные) **не строилась строго сверху вниз**. Вместо этого применялся **инкрементальный подход**
  - Так, вместо фиксирования на каждом уровне требований use case’ы целенаправленно уточнялись на каждом витке — от бизнес-уровня к системному

В результате структура артефактов может выглядеть немного фрагментарно — **это осознанный выбор** в рамках гибкой учебной модели.

---

# 📝 Артефакты анализа

## 🏢 BRD

### Бизнес-контекст
- [Business Model Canvas](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/BRD/Business_Model_Canvas.jpg)
- [Оргструктура и роли](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/BRD/Оргструктура_и_роли.jpg)

### Структурные модели процессов
- [Value Added Chain Diagram](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/BRD/VAD.jpg)
- [IDEF0-A-0](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/BRD/Процессы/IDEF0-A-0.jpg)
- [IDEF0-A0](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/BRD/Процессы/IDEF0-A0.jpg)
- [IDEF-A2](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/BRD/Процессы/IDEF0-A2.jpg)
- [IDEF0-A22](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/BRD/Процессы/IDEF0-A22.jpg)

### Функциональные модели процессов

| Артефакт                      | Процесс                                        
| ----------------------------- | ----------------------------------------------- 
| BPMN Согласовательного уровня | [А22. Поездка по заявке](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/BRD/Процессы/А22_Поездка_по_заявке_Согласовательный_уровень.png)                          |        |
| BPMN Аналитического уровня    | [А221. Оформление заявки клиентом](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/BRD/Процессы/А221_Оформление_заявки_клиентом.png)                |        |
| BPMN Аналитического уровня    | [А222. Назначение водителя для выполнения Заявки](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/BRD/Процессы/А222_Назначение_водителя_для_выполнения_Заявки.png) |        |
| BPMN Аналитического уровня    | [А223. Выполнение поездки](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/BRD/Процессы/А223_Выполнение_поездки.png)                        |        |
| BPMN Аналитического уровня    | [А224. Оплата поездки](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/BRD/Процессы/А224_Оплата_поездки.png)                            |        |
| BPMN Аналитического уровня    | [А225. Отчет водителя](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/BRD/Процессы/А225_Отчет_водителя.png)                            |        |

### Модели данных
- [Модель предметной области](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/BRD/Данные/МПО.jpg)
- [Контекстная диаграмма](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/BRD/Данные/Контекстная_диаграмма.jpg)
- [Диаграмма потоков данных DFD (Level 0)](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/BRD/Данные/DFD_0.jpg)

---

## 🏗️ SRS

### Архитектура

| Стиль                     | Диаграмма | Комментарий |
| ------------------------------ | ------------------ | ------------ |
|                                | [C4 Context](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/architecture/С4_Context.png)         |              |
| Microservices Architecture     | [С4 Container](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/architecture/C4_Containers_MSA.png)      | основное решение             |
| Microservices Architecture     | [C4 Component](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/architecture/С4._Components.%20MSA.png)       | основное решение             |
| Монолит                 | [С4 Container](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/architecture/С4_Containers.%20Монолит.png)      | вариант решения для рассмотрения заказчиком            |
| Монолит                 | [C4 Component](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/architecture/С4_Сomponents_Монолит.png)       | вариант решения для рассмотрения заказчиком             |
| Service-Based Architecture     | [С4 Container](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/architecture/С4_Containers.%20SBA.png)      | вариант решения для рассмотрения заказчиком             |
| Service-Based Architecture     | [C4 Component](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/architecture/С4_Components.%20SBA.png)       | вариант решения для рассмотрения заказчиком             |

### Use Cases & Sequence Diagrams

| Артефакт                                                                  | |  |  |
| ------------------------------------------------------------------------- | ----- | ------------ | ---------------- |
| Use Case Diagram                                                          |       |  [PNG](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/interactions/use%20cases/Use_Case_Diagram.png)            |                   |
| UC-1. Создание поездки по Заявке                                          | [Текст](https://docs.google.com/document/d/1ZqJkvjLKTLqCCJzmj1DiIwN4VM1ZnYkCHbecq9s-a0c/edit?usp=sharing)      | [Sequence PNG](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/interactions/sequence_diagrams/UC-1_Создание_Поездки_по_Заявке_(route_to_start_status%20%3D%20success).png)             | [Sequence PlantUML ](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/interactions/sequence_diagrams/UC-1_Создание_поездки_по_Заявке.plantuml)                  |
| UC-3. Авторизация клиента по номеру телефона                              |       | [Sequence PNG](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/interactions/sequence_diagrams/UC%20-5_Авторизация_клиента_по_номеру_телефона.png)             | [Sequence PlantUML](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/interactions/sequence_diagrams/UC%20-5_Авторизация_клиента_по_номеру_телефона.plantuml)                  |
| UC-2.1 Аутентифкация клиента через OAuth 2.0. Google                      | [Текст](https://docs.google.com/document/d/1We7lsw3FNsDj092ztRCpkdklHSzidylnt3R_bxI74DU/edit?usp=drive_link)      | [Sequence PNG](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/interactions/sequence_diagrams/UC-2_Аутентифкация_клиента_через_OAuth_2_0_Google.png)             | [Sequence PlantUML ](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/interactions/sequence_diagrams/UC-2_Аутентифкация_клиента_через_OAuth_2_0_Google.plantuml)                  |
| UC-2.2 Авторизация клиента, аутентифицированного  через OAuth 2.0. Google | [Текст](https://docs.google.com/document/d/1xviqh3xp5lOp7Rk8CkKzaOAa_0-QT2CP3HJOTyDjGNs/edit?usp=drive_link)      | [Sequence PNG](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/interactions/sequence_diagrams/UC-4_Авторизация_клиента_аутентифицированного_через_OAuth_2_0_Google.png)             | [Sequence PlantUML](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/interactions/sequence_diagrams/UC-4_Авторизация_клиента_аутентифицированного%20_через_OAuth_2_0_Google.plantuml)                  |

### API

#### REST API

- [OpenAPI Spec at SwaggerHub](https://app.swaggerhub.com/apis/MARGIRB/API_AWG_Taxi_Service/1.0.0)
- [OpenAPI Spec.yaml](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/interactions/api/swagger_3_0.yml)

##### Контракты 

- [INT-ClientAp-1. ClientApp запрашивает  authorization URL для OAuth 2.0 Google](https://docs.google.com/document/d/1QHuE8bpfKOh3kytY8n1yOs_1GmTNV0vNHgDm4U1YsMc/edit?usp=drive_link)
- [INT-ClientAp-2. ClientApp запрашивает  auth_token в AuthService](https://docs.google.com/document/d/1gFTW0mbLO1BZUEAocuhOykplAeJJ8oqx_3PtpT1P1GU/edit?usp=drive_link)
- [INT-AuthService-1. Обмен кода авторизации на токены доступа в Google OAuth 2](https://docs.google.com/document/d/1HVrtgJb2_5ndAenc1h0uQ034NotldAZXoKSM0RrAFQs/edit?usp=drive_link)
- [INT-ClientApр-3. ClientApp запрашивает в AuthService access_token](https://docs.google.com/document/d/1ajwAOxNQaqtBTaZF_nuA4XEuudcVphU9ZtxNuDIS8RQ/edit?usp=drive_link)
- [INT-ClientApp-4. ClientApp получает данные клиента в  СustomerService](https://docs.google.com/document/d/1ey2wqxpcnpyYepMIUw1fYXAba7P3eiZHsx4yRkeHups/edit?usp=drive_link)
- [INT-TripService-1. Создание Поездки по Заявке](https://docs.google.com/document/d/1ETf1IHHxLYHFNMMtuXQ5EbkkgftJBDmd1LsfpBpcdYQ/edit?usp=sharing)

#### AsyncAPI

##### Топики Kafka

- [request.status.changed](https://docs.google.com/document/d/1T0QLIuGnHXHvADiKHIi0NMvnHyvKcLCPb_UO03QNJoQ/edit?usp=sharing)
- [ride.request.driver.search](https://docs.google.com/document/d/18ilY3rLyEK8gVlem6EwP6IEX7qC2LL7Z5Sj-VWFc_2k/edit?usp=sharing)
- [ride.request.driver.search.result](https://docs.google.com/document/d/1Pi6DOdaqjBOGwDFASOHLygxIqxvgySBoEnQWPt12t-g/edit?usp=sharing)
- [driver.status.search](https://docs.google.com/document/d/1VN38gYVnKuYeFtyB65GMK5ncWN7Rjw9b4DCBPNOySF0/edit?usp=sharing)
- [driver.status.search.result](https://docs.google.com/document/d/1m5T03u8Hgk1M1yGHXXwYs3Vh4Defg_4aWHSrmzRdu38/edit?usp=sharing)

### Модели данных

- [State Machine](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/data/State_Machine%20.jpg)
- [Словарь данных](https://docs.google.com/document/d/10KZdMk-CEB4wlowSt70QYX2wTnOXWpxI7LCSUPdLruU/edit?usp=drive_link)
- ERD: [ERD файл](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/data/ERD.erd), [PNG](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/data/ERD.png), [SQL файл](https://github.com/MarGirb/ipr-taxi-petproject/blob/main/Taxi_AWG_final/SRS/data/ERD_my_taxi.sql)


### Требования к логгированию

- [Сервис такси  MyTaxi. Требования к логгированию ](https://docs.google.com/document/d/1x8aJ9HnnHkU61igeE0T3xfub_kynuIIF3RGqaY8Bybg/edit?usp=drive_link)

---


## 🧳 Инструменты

- **draw.io** для C4, Use Case diagram
- **Miro** для DFD, IDEF0, State Machine
- **StormBPM** для BPMN-сценариев
- **VSCode** для PlantUML, ERD и спецификации OpenAPI 3.0
- **Swagger Hub** для спецификации OpenAPI 3.0
- **Google Docs** для текстовых описаний 

---

## 👩‍💻 ИПР

- Ментори: **Мария Гиршберг**
- Ментор: **Андрей Корниенко**
- Руководитель: **Максим Скворцов**
- Компания: **AWG**
- Период ИПР: **февраль-июнь 2025**
