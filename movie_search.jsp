<head>
<title>CSE412 Project 3 (JSP)</title>
</head>
<body bgcolor=#FFFFFF>

<h2>
CSE412 Project 3 
</h2>


<%@ page import="java.sql.*" %>

<%!
String jdbcDriver = "org.postgresql.Driver";
String jdbcURL    = "jdbc:postgresql:postgres";
String user       = "webuser";
String password   = "webuser";
String submit_clicked;
%>


<form method="post" action="movie_search.jsp">
    Title search: <input type="text" name="title" />
    <input type="submit" name="submit" value="Search Title" />
    <br><br>
    Tag search: <input type="text" name="tag" />
    <input type="submit" name="submit"  value="Search Tag" />
</form>

<%
ResultSet rs;
String search_title = "ZZZZZZZZ";
String search_tag = "ZZZZZZZZ";
//String search_title = request.getParameter("title");
//String search_tag = request.getParameter("tag");

try {

        Class.forName(jdbcDriver).newInstance();
        Connection conn = DriverManager.getConnection(jdbcURL, user, password);
        Statement stmt = conn.createStatement();

	String button = request.getParameter("submit");
	if(button == null)
	{
		out.print("no result to show");
		return;
	}
	else if ("Search Title".equals(button)) {
		search_title = request.getParameter("title");
		rs = stmt.executeQuery("select title from movies where title like '%" + search_title + "%';");
	}
	else  {
		search_tag = request.getParameter("tag");
		rs = stmt.executeQuery("select m.title , i.content  from tags t, taginfo i, movies m where i.content like '%" + search_tag + "%' and t.tagid = i.tagid and t.movieid = m.movieid;");
	}



        ResultSetMetaData rsmd = rs.getMetaData();
        int numOfCols = rsmd.getColumnCount();

        out.print("<center>");
        out.print("<h3>Result of your query</h3>");
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

<c:if test="${!empty param.Add}">
  <c:set var="bid" value="${param.Add}"/>

<p>
</body>
</html>
