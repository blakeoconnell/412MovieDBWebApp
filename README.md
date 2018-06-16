CSE412 Project 3 

The project 3 implementation uses the following technologies:
▪ Apache Tomcat
▪ Postgresql
▪ Java Server Page (JSP) ▪ JSON
▪ HTML/Javascript

The following instructions is done on a Windows 10 laptop:

1. Install Postgressql version 10. The location is C:\Program Files\PostgreSQL\10.

2. Create and load the movies database from Project1

3. Create user webuser in the postgres database. The password is also webuser.

4. Execute the following command in the database: create table search_helper (movieid integer);

5. Install Apache Tomcat 9.0. The location is C:\Program Files\Apache Software
Foundation\Tomcat 9.0

6. Create a directory for this project under webapps as shown here: C:\Program Files\Apache
Software Foundation\Tomcat 9.0\webapps\CSE412-Project3

7. Copy the 6 files that come with this project in the above directory.

8. Download the following jar files and place them in the directory C:\Program Files\Apache
Software Foundation\Tomcat 9.0\webapps\CSE412-Project3\WEB-INF\lib: postgresql-42.2.2.jar
and java-json.jar

9. Create an environment variable for CLASSPATH as show here: C:\Program Files\Apache Software
Foundation\Tomcat 9.0\lib\postgresql-42.2.2.jar;C:\Program Files\Apache Software
Foundation\Tomcat 9.0\lib\java-json.jar;

10. Stop and start tomcat service

11. Start IW and use the this link to connect to this app: http://localhost:8080/CSE412-
Project3/project3_frames.html
