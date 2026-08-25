# Online Examination System

A web-based Online Examination System developed using Java, JSP, Servlets, Maven, MySQL, HTML, CSS, and JavaScript.

The system provides separate interfaces for students and administrators. Students can register, take randomized MCQ examinations, navigate between questions, receive results instantly, and track their performance. Administrators can manage examination questions, import questions from XML, and monitor student performance.

## Features

### Student Features

- Student registration and login
- Role-based authentication
- Secure student examination portal
- Randomized multiple-choice questions
- 30-second timer for each question
- Previous and next question navigation
- Answer selection and answer persistence
- Automatic handling of question timeout
- Instant examination results
- Pass/Fail calculation
- Percentage calculation
- Personal performance history
- Previous examination attempt tracking
- Light and dark theme support

### Administrator Features

- Dedicated administrator login
- Role-based admin authentication
- Admin dashboard
- Add examination questions
- View all questions
- Edit existing questions
- Delete questions
- Import questions from XML
- Delete imported XML questions
- Student performance monitoring
- View total students
- View students who have attempted examinations
- Identify students who have not attempted an examination
- View total examination attempts
- View individual student scores
- View percentages and pass/fail results
- View examination attempt history

## Technology Stack

| Technology | Purpose |
|------------|---------|
| Java | Backend application development |
| JSP | Dynamic web pages |
| Servlets | Request and response handling |
| Maven | Project and dependency management |
| MySQL | Database |
| JDBC | Database connectivity |
| HTML5 | Page structure |
| CSS3 | User interface and styling |
| JavaScript | Client-side functionality |
| XML | Question import |
| Apache Tomcat | Application server |

## Project Architecture

The project follows a layered architecture:

```text
OnlineExaminationSystem
│
├── src
│   └── main
│       ├── java
│       │   └── com.exam
│       │       ├── controller
│       │       ├── dao
│       │       ├── model
│       │       └── util
│       │
│       └── webapp
│           ├── admin
│           ├── student
│           ├── css
│           ├── js
│           ├── xml
│           ├── index.jsp
│           ├── login.jsp
│           ├── register.jsp
│           ├── exam.jsp
│           └── result.jsp
│
└── pom.xml