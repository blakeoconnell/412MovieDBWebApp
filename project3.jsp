<head>
<title>Simple Database Example (JSP)</title>
</head>
<body bgcolor=#FFFFFF>

<h2>
Simple Database JSP Example
</h2>

<%@ page import="java.sql.*" %>

<%!
String jdbcDriver = "org.postgresql.Driver";
String jdbcURL    = "jdbc:postgresql:postgres";
String user       = "webuser";
String password   = "webuser";
%>

<%
try {

        Class.forName(jdbcDriver).newInstance();
        Connection conn = DriverManager.getConnection(jdbcURL, user, password);
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("select g.name, round(AVG(r.rating),2) from ratings r, genres g, hasagenre h where g.genreid = h.genreid and r.movieid = h.movieid group by g.name;");
        ResultSetMetaData rsmd = rs.getMetaData();
        int numOfCols = rsmd.getColumnCount();

        out.print("<center>");
        out.print("<h3>Data in table: test_table</h3>");
        out.print("<table width=400 cellspacing=5 cellpadding=5><tr>");

        for ( int i=1; i<numOfCols+1; i++ ) {
                out.print("<td><b>" + rsmd.getColumnName(i) +
                "</b></td>");
        }

        out.print("</tr>");

        while (rs.next()) {
                out.print("<tr>");
                for ( int i=1; i<numOfCols+1; i++ ) {
                        out.print("<td>" + rs.getString(i) + "</td>");
                }
                out.print("</tr>");
        }
        out.print("</table>");

        rs.close();
        stmt.close();
        conn.close();

    } catch (Exception e) {
        out.print("<p><pre>" + e.toString() + "</pre>");
    }

%>

<p>
</body>
</html>
