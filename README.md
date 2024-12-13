# sw_project
소융설 텀프

## 구조

Below is an example of how you might include this directory structure in your README file, along with explanations of each folder and its role in the project.

---

### Project Structure

```
MyCommunityProject/
└─ src/main
   ├─ swr/
   │   ├─ model/                  // Domain (Model) classes representing data objects
   │   │   ├─ User.java           // User entity class
   │   │   ├─ Board.java          // Board entity class
   │   │   ├─ Comment.java        // Comment entity class
   │   │   └─ Like.java           // Like entity class
   │   │
   │   ├─ service/                // Service layer (Business logic & DB operations)
   │   │   ├─ DBConnection.java   // Manages database connections (if needed)
   │   │
   │   ├─ util/                   // Utility classes for common tasks
   │       └─ ...UtilityClasses.java
   │
   └─ WebContent/
       ├─ WEB-INF/
       │   └─ lib/                // Libraries and JDBC drivers
       │
       ├─ common/                 // Common JSP pages such as header and footer
       │   ├─ header.jsp
       │   ├─ footer.jsp
       │
       ├─ member/                 // JSP pages related to member operations
       │   ├─ login.jsp
       │   ├─ logout.jsp
       │   └─ register.jsp
       │
       ├─ board/                  // JSP pages related to board functionalities
       │   ├─ list.jsp            // Board list view
       │   ├─ view.jsp            // Detailed board view
       │   ├─ write.jsp           // Create a new post
       │   ├─ delete.jsp          // Delete a post
       │   ├─ comment/
       │   │    ├─ form.jsp       // Comment creation form
       │   │    └─ view.jsp       // Comment listing for a post
       │   │
       │   └─ like/
       │        └─ likebtn.jsp    // "Like" feature UI
       │
       ├─ css/                    // CSS styles
       │   └─ style.css
       │
       ├─ js/                     // JavaScript files
       │   ├─ common.js           // Common JavaScript functions
       │   └─ board.js            // JavaScript specific to board interactions
       │
       ├─ images/                 // Image assets
       │   └─ logo.png
       │
       └─ main.jsp                // Main landing page
```

### Directory Overview

- **`model/`**: Contains the domain model classes that represent the core entities of the application. Each class maps to a database table and includes fields, getters/setters, and basic business logic related to that entity.

- **`service/`**: Encapsulates the business logic of the application. Service classes interact with the `model` layer to fetch, process, and store data. `DBConnection.java` provides a centralized place to manage the database connection logic.

- **`util/`**: Houses utility classes that can be used across different layers of the project, such as string formatters, date helpers, or validators.

- **`WebContent/`**: This directory contains all of the web-facing resources:
  - **`WEB-INF/lib/`**: Holds library JAR files (e.g., JDBC drivers or other third-party libraries).
  - **`common/`**: Includes common JSP fragments like headers and footers, promoting modularity and consistent design.
  - **`member/`**: Focuses on member-related pages such as login, logout, and registration.
  - **`board/`**: Contains pages related to the community board, including viewing, listing, writing, and deleting posts. Subdirectories like `comment/` and `like/` handle related functionalities.
  - **`css/`**, **`js/`**, **`images/`**: Static resources such as stylesheets, JavaScript files, and images are organized here for easy maintenance and a clear separation of concerns.
  - **`main.jsp`**: The main entry page of the application.

This structure aims to keep the code organized, maintainable, and scalable as the application grows. Each layer has its own responsibility, and the directory layout is intuitive enough to quickly locate files related to a particular feature or functionality.
