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
input[type=text] {
  width: 50%;
  padding: 8px 10px;
  margin:1px 0;
  display: block;
  border: 1px solid #ccc;
  border-radius: 2px;
  box-sizing: border-box;
}

input[type=submit] {
  background-color: green;
  color: white;
  padding: 10px 20px;
  margin: 8px 0;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

input[type=submit]:hover {
  background-color: #45a049;
}

div {
  box-sizing: border-box;
  width: 50%;
  height: auto;
  border: 10px ;
  border-radius: 10 px;
  background-color: #f2f2f2;
  padding: 10px;
}
</style>

<% 


SelectQuery sq = new SelectQueryImpl(new Table("Employee"));
UpdateQuery uq = new UpdateQueryImpl("Employee");
Persistence per = (Persistence)BeanUtil.lookup("Persistence");
DataObject dataObject;
Iterator it;
Criteria c;

Column col1=new Column("Employee","EMP_ID");
Column col2=new Column("Employee","EMP_NAME");
Column col3=new Column("Employee","DEPT");
Column col4=new Column("Employee","USER_ID");
Column col5=new Column("Employee","DOJ");
ArrayList clist=new ArrayList();
clist.add(col1);
clist.add(col2);
clist.add(col3);
clist.add(col4);
clist.add(col5);
sq.addSelectColumns(clist);

out.print("<h1><center>DELETE</center></h1><br>");

sq.addSelectColumn(Column.getColumn("Employee","*"));
dataObject = per.get(sq);
it = dataObject.getRows("Employee",(Criteria)null);
out.print("<center><table border=2px >");
out.print("<tr><th>EmployeeID</th><th>EmployeeName</th><th>Department</th><th>UserID</th><th>DateOfJoining</th></tr>");
while(it.hasNext()){
     Row rw=(Row)it.next();
     out.print("<tr>");
     out.print("<td>"+rw.get(1)+"</td>");
     out.print("<td>"+rw.get(2)+"</td>");
     out.print("<td>"+rw.get(3)+"</td>");
     out.print("<td>"+rw.get(4)+"</td>");
     out.print("<td>"+rw.get(5)+"</td>");
     out.print("</tr>");
}
out.print("</table></center>");

out.print("");
String id1 = request.getParameter("id1");
try{
     
     if (id1 != null && !id1.equals("")) {
          dataObject = per.get("Employee",(Criteria)null);  
          c = new Criteria(new Column("Employee","EMP_ID"),Integer.parseInt(id1),QueryConstants.EQUAL); 
          sq.setCriteria(c);
          it = dataObject.getRows("Employee",c);
          if(it.hasNext()){
               dataObject.deleteRows("Employee",c);
               per.update(dataObject);
               response.sendRedirect("Delete.jsp");
               out.print("<br> Successfully Deleted <br>");
          }
          else{
               out.print("<center><h2>Invalid ID</h2></center>");
          }
     }
}
catch(Exception ex){
     out.print(" <center><h2>Invalid ID</h2></center> ");
     System.out.println("Exception while Deleting --> "+ex);
}


%> 
<br>
<br>
<br>
<center>
<div>
<form method="post">
    <label for="id1">Employee ID:</label>
    <input type="text" id="id1" name="id1"  required/>
    <input type="submit" value="Delete" />
</form>
</div>
</center>
<br>


</body>
</html>