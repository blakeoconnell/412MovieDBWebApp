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
//////String submit_clicked;
%>


<form method="post" action="movie_search.jsp">

    <div data-role="rangeslider">
        <label for="rating-min">Rating min:</label>
        <input type="range" name="rating-min" id="rating-min" value="1" min="1" max="5">
	<br><br>
        <label for="rating-max">Rating max:</label>
        <input type="range" name="rating-max" id="rating-max" value="5" min="0" max="5">
    </div>
<br><br>

    By Title: <input type="text" name="title" />
    <br><br>
    By Keyword: <input type="text" name="keyword" />
    <br><br>
    <input type="submit" name="submit" />
    <br><br>
    <hr>
    <input type="button" name="Refresh rating" value="Refresh Rating Frame" onclick="parent.left_buttom.location.reload()"> 
    <br><br>
    <input type="button" name="Refresh count" value="Refresh Count Frame" onclick="parent.left_top.location.reload()"> 
    <hr>
</form>



<%
ResultSet rs = null;
ResultSet rs2 = null;


try {
	
        Class.forName(jdbcDriver).newInstance();
        Connection conn = DriverManager.getConnection(jdbcURL, user, password);
        Statement stmt = conn.createStatement();
	Statement stmt_insert = conn.createStatement();
	Statement stmt_delete = conn.createStatement();



	String title_type = request.getParameter("title");
	String keyword_type = request.getParameter("keyword");
	String min_range_type = request.getParameter("rating-min");
	String max_range_type = request.getParameter("rating-max");

	if (("".equals(title_type))  && ("".equals(keyword_type)) ){
		title_type = "ZZZZZ";
		keyword_type = "ZZZZZ";
		//out.print(title_type);
	};


	rs = stmt.executeQuery("select title, content, round(avg_rating, 2) as average_rating from (select movieid, title, content, avg(rating) as avg_rating from (select distinct m.movieid, m.title, i.content, r.rating from movies m, tags t, taginfo i, ratings r where m.title like '%" + title_type + "%' and i.content like '%" + keyword_type + "%' and t.tagid = i.tagid and t.movieid = m.movieid	and m.movieid = r.movieid) as a	group by movieid, title, content) as b	where avg_rating  between " + min_range_type + " and " + max_range_type + "; "); //e and 5;");


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

	int delete = stmt_insert.executeUpdate("delete from search_helper;");

	int insert = stmt_insert.executeUpdate("insert into search_helper select distinct movieid from (select movieid, title, content, avg(rating) as avg_rating from (select distinct m.movieid, m.title, i.content, r.rating from movies m, tags t, taginfo i, ratings r where m.title like '%" + title_type + "%' and i.content like '%" + keyword_type + "%' and t.tagid = i.tagid and t.movieid = m.movieid	and m.movieid = r.movieid) as a	group by movieid, title, content) as b	where avg_rating  between " + min_range_type + " and " + max_range_type + "; "); //e and 5;");



        rs.close();
        stmt.close();
        stmt_insert.close();
        stmt_delete.close();
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
