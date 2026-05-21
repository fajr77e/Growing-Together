# Growing-Together
CSC 236 - OOP2 Project | Community Afforestation &amp; Tree Health System

Key Features
User Roles & Permissions
Administrator (Admin): Full management of environmental campaigns, adding/editing planting locations, managing users, and monitoring volunteer contributions.
Volunteer: Register for active campaigns, log newly planted trees, and submit periodic health status updates for existing trees.
Campaign Management
Create and schedule tree planting campaigns with custom target numbers (Target) for trees to be planted.
Real-time tracking of campaign status (Active, Completed, Cancelled).
Seamless volunteer sign-up and cancellation system for specific events.
Tree & Health Status Tracking
Detailed logging of planted trees including type, quantity, specific location, and the volunteer responsible.
Periodic reporting system to update each tree's condition (Healthy, Not Watered, Dead).
Automated indexing of unhealthy trees to direct care and maintenance teams immediately.
Gamification & Profiles
Dedicated user profiles highlighting bios, specific environmental skills, and join dates.
Incentive-based point system (Points) that rewards volunteers based on their trees planted and reports submitted.
Tech Stack
Programming Language: Java (JDK 8 or higher)
User Interface (GUI): Java Swing & AWT (featuring a custom, nature-inspired palette: Matcha, Moss Green, and Linen).
Database: MySQL Server.
Project Management: Maven (for dependency and automated build management).
Design Pattern: Singleton Pattern implemented for database connection management (DatabaseConnection).
Project Structure
The project is structured into modular packages ensuring clean separation of concerns (MVC architecture):

com.mycompany.mavenproject12
│
├── model (Data Entities)
│   ├── User.java (Base class for all users)
│   ├── Admin.java & Volunteer.java (Subclasses inheriting from User)
│   ├── Campaign.java (Campaign parameters and objectives)
│   ├── Location.java (Geographic location data)
│   ├── Tree.java (Details of planted tree units)
│   ├── TreeStatus.java (Logs for health checks)
│   └── UserProfile.java & VolunteerSkill.java (Profile metadata and skill mapping)
│
├── service (Business Logic & Database Communication)
│   ├── DatabaseConnection.java (Manages JDBC connection pool with MySQL)
│   ├── UserService.java (Handles authentication, registration, and points)
│   ├── CampaignService.java (Core logic for managing campaigns)
│   ├── LocationService.java (Handles location queries)
│   ├── TreeService.java (Manages tree data inputs and metrics calculation)
│   └── TreeStatusService.java (Handles reports on unhealthy tree logging)
│
└── gui (Graphical User Interface Components - JFrames & Views)
    ├── LoginForm.java & RegisterForm.java (Access management screens)
    ├── MainMenuFrame.java (Dynamic navigation dashboard adapted to the user's role)
    ├── VolunteerCampaignsView.java (Campaign overview and registration)
    ├── VolunteerTreesView.java (Portal to plant a tree or report status)
    └── VolunteerLocationsView.java (Displays available planting venues)

UI Color Palette
The interface is styled using a custom-tailored palette reflecting environmental themes:

Linen (#EEE7DD): Primary background color for a clean, minimalist canvas.
Matcha (#D7D799): Accent color applied to table headers and boundaries.
Moss Green (#929433): Prominent color reserved for primary buttons, titles, and major interactive highlights.
Tea Rose (#EBB4B2): Muted tone utilized for auxiliary tasks, cancellations, and back operations.
Setup & Installation
1. Prerequisites
Ensure JDK 8 or newer is installed on your local environment.
An Integrated Development Environment (IDE) such as NetBeans, IntelliJ IDEA, or Eclipse.
MySQL Server instance configured and active.
2. Database Configuration
Access your database management tool (e.g., MySQL Workbench or Command Line Interface).
Create and initialize the greenpath_db schema:
CREATE DATABASE greenpath_db;
USE greenpath_db;
Verify that your local credentials correspond to the parameters specified in DatabaseConnection.java:
Username: root
Password: System (Modify this value if your local configuration uses a different root password).
3. Build & Execution
Clone or download the source code zip archive.
Open the directory within your chosen IDE as a Maven Project.
Allow the IDE to resolve and download the required project dependencies (e.g., mysql-connector-j).
Execute the application entry point located in Mavenproject12.java. Upon a successful connection to the database instance, the login terminal will display.
Future Roadmap
Implementing data visualization dashboards with graphical charts displaying monthly planting analytics.
Integrating a mobile-responsive companion layout with GPS capabilities for accurate geotagging of newly planted trees.
Automated certification engine to reward top-performing volunteers with completion certificates. \
Developed to support environmental sustainability and cultivate a greener future.
