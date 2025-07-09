# Pahan Edu Web

This is a Java Maven web application built using JSP and Servlets, intended for the automation and application for online billing for Pahan Edu Bookshop

- JSP frontend
- Servlet backend
- WAR packaging using Maven
- Deployment on Apache Tomcat

## 📂 Project Structure
```
pahan-edu-web/
├── pom.xml
├── README.md
├── LICENSE
└── src/
└── main/
├── java/
│ └── com/
│ └── example/
│ └── HelloServlet.java
├── resources/
└── webapp/
├── index.jsp
└── WEB-INF/
└── web.xml
```


## ⚙️ Technologies Used

- Java 21
- Maven
- Jakarta Servlet API
- JSP
- Apache Tomcat (for deployment)
- IntelliJ IDEA

## 🚀 How to Run

1. Install Java 21 and Apache Tomcat 11.
2. Run `mvn clean package` to build the WAR file.
3. Copy the `target/pahan-edu-web.war` to your Tomcat `webapps` folder.
4. Start Tomcat and visit: `http://localhost:8080/pahan-edu-web/`

## 📝 License

This project is licensed under the [MIT License](LICENSE).
