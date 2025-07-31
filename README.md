# 📘 Pahan Edu Web - Bookshop Management System

**Pahan Edu Web** is a Java Maven-based web application built using **JSP** and **Servlets**, developed for managing billing, customers, and item data for the **Pahan Edu Bookshop**.

---

## ⚙️ Technologies Used

- Java 21
- Maven (WAR packaging)
- JSP + Servlets (Jakarta EE)
- MySQL (schema + seed data included)
- Apache Tomcat 11 (for deployment)
- JUnit 5 (unit testing)
- IntelliJ IDEA (recommended IDE)

## 📂 Project Structure
```
pahan-edu-web/
├── pom.xml
├── README.md
├── LICENSE
└── src/
├── sql/
└── main/
├── java/
│ └── com/uni/
│   └── controller/
│     └── BillServlet.java
│   └── dao/
│     └── BillDAO.java
│   └── model/
│     └── Bill.java
│   └── service/
│     └── BillService.java
│   └── util/
│     └── DatabaseUtil.java
├── resources/
└── webapp/
├── index.jsp
└── WEB-INF/
└── web.xml
```

---

## 🚀 How to Run Locally

> No EXE installer — you can run locally via WAR deployment on Tomcat.

### 📦 Prerequisites

- Java 21+
- Apache Tomcat 11+
- MySQL Server (5.7+) / WAMP Server / XAMPP Server
- Maven 3.8+

### 🔧 Setup Instructions

1. **Install dependencies**
    - Java JDK 21
    - Apache Tomcat
    - MySQL

2. **Configure the database**
    - Create a database `pahana_edu` in MySQL.
    - Import schema and seed data:
      ```bash
      mysql -u root -p pahana_edu < sql/schema.sql
      mysql -u root -p pahana_edu < sql/seed_data.sql
      ```

3. **Configure properties**
    - Create a new file:  
      `src/main/resources/application.properties`
    - Use the template provided in:  
      `application-template.properties`

4. **Build the WAR**
   ```bash
   mvn clean package
    ```

5. **Deploy on Tomcat**
    - Copy the generated WAR file from `target/pahan-edu-web.war` to the `webapps` directory of your Tomcat installation.
    - Start Tomcat:
      ```bash
      cd /path/to/tomcat/bin
      ./startup.sh
      ```
6. **Access the application**
    - Open your web browser and go to:  
      `http://localhost:8080/pahan-edu-web/`
    - Login with default credentials:
      - Username: `test`
      - Password: `test`

## 📖 Documentation
- [JSP Documentation](https://docs.oracle.com/javaee/7/tutorial/jsp.htm)
- [Servlet Documentation](https://docs.oracle.com/javaee/7/tutorial/servlets.htm)
- [Maven Documentation](https://maven.apache.org/guides/index.html)
- [Tomcat Documentation](https://tomcat.apache.org/tomcat-11.0-doc/index.html)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [Java Documentation](https://docs.oracle.com/en/java/javase/21/)
- [Jakarta EE Documentation](https://jakarta.ee/specifications/servlet/5.0/)
- [Apache Commons Documentation](https://commons.apache.org/)
- [JUnit Documentation](https://junit.org/junit5/docs/current/user-guide/)

## 🛠️ Testing
- Unit tests are written using JUnit 5.
- Run tests using:
  ```bash
  mvn test
  ```
- All testing checklists available in PR: [PR #8](https://github.com/dmkwelivitage/pahan-edu-web/pull/8)

## 📫 Contact
For any issues or contributions, please open an issue or submit a pull request on the [pahan-edu-web](https://github.com/dmkwelivitage/pahan-edu-web) repository.

## 📈 Versioning and Changelog
This project uses [Semantic Versioning](https://semver.org/).
- Version: 1.0.0
- Changelog: [CHANGELOG.md](CHANGELOG.md)

## 📣 Author
- **D.M.K. Welivitage** - [dmkwelivitage](https://github.com/dmkwelivitage)
- Developed as part of the **Pahan Edu** project for university coursework CIS6003

## 📝 License

This project is licensed under the [MIT License](LICENSE).
