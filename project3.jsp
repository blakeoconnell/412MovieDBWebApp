<head>
<title>Simple Database Example (JSP)</title>

</head>
<body bgcolor=#FFFFFF>
<link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
<script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<link rel="stylesheet" type="text/css" href="style.css">
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

<div class="row">
    <div class="col-md-6" id="chartPanel">
        <h2>This is the Chart Panel</h2>

    </div>
    <div class="col-md-6" id="controlPanel">
        <h2>This is the Control Panel</h2>
        <h4>Sort Results:</h4>
        <form>
            By Rating:   
            <div data-role="main" class="ui-content">
                    <div data-role="rangeslider">
                        <label for="rating-min">Rating:</label>
                        <input type="range" name="rating-min" id="rating-min" value="1" min="1" max="10">
                        <label for="rating-max">Rating:</label>
                        <input type="range" name="rating-max" id="rating-max" value="10" min="0" max="10">
                    </div>
            </div>
            By Title: <input type="text" name="title">
            By Keyword: <input type="text" name="keyword">
            <input type="submit" name="Submit" value="Submit">
        </form>
    </div>
</div>

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
