<%@page import="java.sql.*" %>
  <%@page import="java.util.*" %>
  <%@page import="org.json.JSONObject" %>

<%
String jdbcDriver = "org.postgresql.Driver";
String jdbcURL    = "jdbc:postgresql:postgres";
String user       = "webuser";
String password   = "webuser";
Connection conn = DriverManager.getConnection(jdbcURL, user, password);


           JSONObject ratingObj = null;
        List ratingdetails = new LinkedList();
        JSONObject responseObj = new JSONObject();

	try {

        Class.forName(jdbcDriver).newInstance();
        //Connection conn = DriverManager.getConnection(jdbcURL, user, password);
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("select g.name Genre, count(*) Rating from genres g, hasagenre h where g.genreid = h.genreid  and h.movieid in (select movieid from search_helper) group by g.name");
        ResultSetMetaData rsmd = rs.getMetaData();
        int numOfCols = rsmd.getColumnCount();


        while (rs.next()) {
            String Genre = rs.getString("Genre");
            int Rating = rs.getInt("Rating");
            ratingObj = new JSONObject();
            ratingObj.put("Genre", Genre);
            ratingObj.put("Rating", Rating);
            ratingdetails.add(ratingObj);
        }
        responseObj.put("ratingdetails", ratingdetails);
    out.print(responseObj.toString());
    }
    catch(Exception e){
        e.printStackTrace();
    }finally{
        if(conn!= null){
            try{
            conn.close();
            }catch(Exception e){
                e.printStackTrace();
            }
        }
    }
 %>
