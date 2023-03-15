<%@page contentType="text/html" import="java.io.*, java.sql.Connection, 
com.adventnet.persistence.*, com.adventnet.ds.query.*, com.adventnet.ds.query.util.*, 
com.adventnet.db.persistence.metadata.*, 
com.adventnet.persistence.personality.*, com.adventnet.persistence.xml.*,
com.adventnet.ds.query.DataSet,com.adventnet.db.api.RelationalAPI,com.adventnet.ds.query.*"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.adventnet.mfw.bean.BeanUtil"%>
<%@page import="java.util.*" %>  

<html>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body>
<div class="w3-bar w3-border w3-card w3-round w3-light-blue">
  <a href="Add.jsp" class="w3-bar-item w3-button w3-hover-red">ADD Details</a>
  <a href="Display.jsp" class="w3-bar-item w3-button w3-hover-green">Display Details</a>
  <a href="Update.jsp" class="w3-bar-item w3-button w3-hover-blue">Update Details</a>
  <a href="Delete.jsp" class="w3-bar-item w3-button w3-hover-teal">Delete Details</a>
  <a href="ww.jsp" class="w3-bar-item w3-button w3-hover-yellow w3-right">Cloud_Table</a>
</div>
<style>
table, td, th {
  border: 1px solid black;
}

table {
  border-collapse: collapse;
  width: 70%;
}

td,th {
  text-align: center;
  padding: 8px;
}
tr:nth-child(even){background-color: #f2f2f2}

th {
  background-color: #04AA6D;
  color: white;
}
div {
  border-radius: 5px;
  background-color: white;
  padding: 10px;
}
input[type=submit] {
  background-color: grey ;
  color: white;
  padding: 4px 8px;
  margin: 8px 0;
  border: none;
  border-radius: 50%;
  cursor: pointer;
}
input[type=submit]:hover {
  background-color: red;
  box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24), 0 17px 50px 0 rgba(0,0,0,0.19);
}
</style>

<% 


SelectQuery sq = new SelectQueryImpl(new Table("Employee"));
//sq = new SelectQueryImpl(new Table("Cloud_Accounts"));
Persistence per = (Persistence)BeanUtil.lookup("Persistence");
DataObject dataObject;
Iterator it;
Criteria c;
DataSet ds = null;
java.sql.Connection conn = null;
SortColumn sortcolumn;

out.print("<center><h1>DISPLAY</h1></center>");

sq.addSelectColumn(Column.getColumn("Employee","*"));
sq.addSelectColumn(Column.getColumn("Cloud_Accounts","*"));
c = new Criteria(Column.getColumn("Employee","USER_ID"),Column.getColumn("Cloud_Accounts","user_id"), QueryConstants.EQUAL);
Join J=new Join("Employee","Cloud_Accounts",c ,Join.INNER_JOIN);
sq.addJoin(J);
String asc = request.getParameter("ASC");
String dsc = request.getParameter("DSC");
if(asc!=null){
  sortcolumn = new SortColumn("Employee","DOJ",true);
  sq.addSortColumn(sortcolumn);
}
else if(dsc != null){
  sortcolumn = new SortColumn("Employee","DOJ",false);
  sq.addSortColumn(sortcolumn);
}
try{
     conn=RelationalAPI.getInstance().getConnection();
     ds=RelationalAPI.getInstance().executeQuery(sq, conn);
     out.print("<div><center><table border=2px >");
     out.print("<tr><th>EmployeeID</th><th>EmployeeName</th><th>Department</th><th>UserID</th><th>DateOfJoining        <form action = \"Display.jsp\" method = \"post\"> <input type = \"submit\" name = \"ASC\" value=\"ASC\"/> <input type=\"submit\" name=\"DSC\" value=\"DSC\">          </th><th>CloudType</th></tr>");
     while(ds.next()){
          out.print("<tr>");
          out.print("<td>"+ds.getValue(1)+"</td>");
          out.print("<td>"+ds.getValue(2)+"</td>");
          out.print("<td>"+ds.getValue(3)+"</td>");
          out.print("<td>"+ds.getValue(4)+"</td>");  
          out.print("<td>"+ds.getValue(5)+"</td>");  
          out.print("<td>"+ds.getValue(8)+"</td>");
          out.print("</tr>");
     }
     out.print("</table></center></div>");     
}
catch(Exception ex){
     out.print("Error while Fetching Data");
     System.out.println("Error while displaying -->"+ex);
}
finally{
     if(ds != null){
          ds.close();
     }
     if(conn != null){
          conn.close();
     }
}

//dataObject = per.get(sq);
////dataObject = per.get(sq1);
//it = dataObject.getRows("Employee",(Criteria)null);
//out.print("<center><table border=2px >");
//out.print("<tr><th>EmployeeID</th><th>EmployeeName</th><th>Department</th><th>UserID</th></tr>");
//if(it.hasNext()){
//     Row rw=(Row)it.next();
//     out.print("<tr>");
//     out.print("<td>"+rw.get(1)+"</td>");
//     out.print("<td>"+rw.get(2)+"</td>");
//     out.print("<td>"+rw.get(3)+"</td>");
//     out.print("<td>"+rw.get(4)+"</td>");
//     out.print("<td>"+rw.get(5)+"</td>");
//     out.print("</tr>");
//}
//out.print("</table></center>");

%> 

</body>
</html>