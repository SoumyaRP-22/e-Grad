# 🎓 e-GRAD Smart Learning Platform

> A Java-based online examination system built with **JSP, Servlets, JDBC, and MySQL**, providing a secure and interactive platform for conducting timed online examinations.

![Java](https://img.shields.io/badge/Java-17+-orange?style=for-the-badge&logo=openjdk)
![JSP](https://img.shields.io/badge/JSP-Servlets-blue?style=for-the-badge)
![MySQL](https://img.shields.io/badge/Database-MySQL-blue?style=for-the-badge&logo=mysql)
![Tomcat](https://img.shields.io/badge/Server-Apache%20Tomcat-red?style=for-the-badge&logo=apachetomcat)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

---

# 📖 Overview

**e-GRAD** is a dynamic web application that enables students to take online examinations in a secure, interactive, and user-friendly environment.

The project follows the **Model-View-Controller (MVC)** architecture, ensuring a clean separation between the application's business logic, user interface, and database operations.

Students can register, log in, attend timed examinations, navigate between questions efficiently, and receive instant results after completing an exam.

---

# ✨ Features

## 👤 User Authentication

- Secure user registration
- User login and logout
- Session management
- Protected dashboard access

## 📝 Online Examination

- Timed online examinations
- Real-time countdown timer
- Automatic submission when time expires
- Previous and Next question navigation
- Responsive exam interface

## 📍 Smart Question Navigation

- Dynamic Question Map
- Indicates:
  - Current question
  - Answered questions
  - Visited questions
  - Unanswered questions

## 📊 Result Management

- Automatic score calculation
- Stores results in MySQL database
- Displays final score after exam completion

## 🗄 Database Integration

- MySQL database
- JDBC connectivity
- DAO Pattern implementation
- Efficient CRUD operations

## 🏗 MVC Architecture

The application follows the MVC pattern:

- **Model** → Java Classes
- **View** → JSP Pages
- **Controller** → Java Servlets
- **Database Layer** → DAO Classes

---

# 🛠 Technology Stack

| Technology | Purpose |
|------------|---------|
| Java | Backend Development |
| JSP | Dynamic Web Pages |
| Servlets | Request Handling |
| JDBC | Database Connectivity |
| MySQL | Database |
| Apache Tomcat 9+ | Application Server |
| HTML5 | Page Structure |
| CSS3 | Styling |
| JavaScript | Client-side Logic |
| Font Awesome | Icons |
| Google Fonts (Inter) | Typography |

---

# 📂 Project Structure

```text
e-GRAD/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/egrad/
│       │       ├── connection/      # Database configuration
│       │       ├── models/          # Java model classes
│       │       ├── dao/             # Data Access Objects
│       │       └── servlets/        # Controllers
│       │
│       └── webapp/
│           ├── assets/              # CSS, JS, Images
│           ├── components/          # Navbar, Footer
│           ├── views/               # Protected JSP Pages
│           ├── WEB-INF/
│           │   └── lib/
│           └── index.jsp
│
├── database_setup.sql
└── README.md
```

---

# ⚙ Prerequisites

Before running the project, install the following software:

- Java JDK 17 or later
- Eclipse IDE for Enterprise Java Developers
- Apache Tomcat 9.0 or later
- MySQL Server
- MySQL Workbench
- MySQL Connector/J

---

# 🚀 Getting Started

## Step 1: Clone the Repository

Clone the project using Git:

```bash
git clone https://github.com/YOUR_USERNAME/e-GRAD.git
```

Or

- Click **Code**
- Select **Download ZIP**
- Extract the downloaded folder.

---

## Step 2: Set Up the Database

Open **MySQL Workbench**.

Create a new database:

```sql
CREATE DATABASE egrad_db;
```

Import the database:

1. Go to **Server → Data Import**
2. Select **Import from Self-Contained File**
3. Choose:

```
database_setup.sql
```

4. Select **egrad_db** as the target schema.
5. Click **Start Import**.

This will create all required tables and insert sample data.

---

## Step 3: Configure Database Credentials

For security reasons, database credentials are not included in the repository.

Navigate to:

```
src/main/java/
```

Create a file named:

```
db.properties
```

Add the following:

```properties
db.url=jdbc:mysql://localhost:3306/egrad_db
db.user=root
db.password=your_mysql_password
```

Replace the username and password with your local MySQL credentials.

---

## Step 4: Import the Project into Eclipse

1. Open **Eclipse IDE**.
2. Go to:

```
File → Import
```

3. Choose one of the following:

- **General → Projects from Folder or Archive**
- **Web → WAR File** (if importing a WAR package)

4. Select the **e-GRAD** project folder.
5. Click **Finish**.

---

## Step 5: Add MySQL Connector/J

Download the latest MySQL Connector/J from the official MySQL website.

Locate the downloaded JAR file:

```
mysql-connector-j-X.X.XX.jar
```

Copy it into:

```
src/main/webapp/WEB-INF/lib/
```

If the **lib** folder doesn't exist:

- Right-click **WEB-INF**
- Select **New → Folder**
- Name it **lib**
- Paste the connector JAR file inside it.

---

## Step 6: Run the Project

Ensure Apache Tomcat (9.0+) is configured in Eclipse.

Then:

- Right-click the project
- Select:

```
Run As → Run on Server
```

Choose your configured Tomcat server.

Click **Finish**.

The application will build and start automatically.

---

# 🌐 Access the Application

Open your browser and visit:

```
http://localhost:8080/e-GRAD/
```

---
