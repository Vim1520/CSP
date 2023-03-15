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

<style>
input[type=text],input[type=date] {
  width: 50%;
  padding: 8px 10px;
  margin:1px 0;
  display: block;
  border: 1px solid #ccc;
  border-radius: 2px;
  box-sizing: border-box;
}

input[type=submit] {
  background-color: #4CAF50;
  color: white;
  padding: 14px 20px;
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

<body>
<div class="w3-bar w3-border w3-card w3-round w3-light-blue">
  <a href="Add.jsp" class="w3-bar-item w3-button w3-hover-red">ADD Details</a>
  <a href="Display.jsp" class="w3-bar-item w3-button w3-hover-green">Display Details</a>
  <a href="Update.jsp" class="w3-bar-item w3-button w3-hover-blue">Update Details</a>
  <a href="Delete.jsp" class="w3-bar-item w3-button w3-hover-teal">Delete Details</a>
  <a href="ww.jsp" class="w3-bar-item w3-button w3-hover-yellow w3-right">Cloud_Table</a>
</div>

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

sq.addSelectColumn(Column.getColumn("Employee","*"));
dataObject = per.get(sq);
it = dataObject.getRows("Employee",(Criteria)null);

out.print("");
String id2 = request.getParameter("eid");
String ename = request.getParameter("ename");
String dept = request.getParameter("dept");
String uuid = request.getParameter("uuid");
String doj = request.getParameter("doj");
try{
     if (id2 != null && !id2.equals("")) {
          c = new Criteria(new Column("Employee","EMP_ID"),Integer.parseInt(id2),QueryConstants.EQUAL);  
          dataObject = DataAccess.get("Employee",c);  
          if(ename != null && !ename.equals("")){
               Row r=dataObject.getRow("Employee");
               r.set("EMP_NAME",ename);  
               dataObject.updateRow(r);
               per.update(dataObject); 
               out.print("<br> Successfully Updated Name <br>");
          }
          if(dept != null && !dept.equals("")){
               Row r=dataObject.getRow("Employee");
               r.set("DEPT",dept);  
               dataObject.updateRow(r);
               per.update(dataObject); 
               out.print("<br> Successfully Updated Department <br>");
          }
          if(doj != null && !doj.equals("")){
               Row r=dataObject.getRow("Employee");
               r.set("DOJ",doj);  
               dataObject.updateRow(r);
               per.update(dataObject); 
               out.print("<br> Successfully Updated Date Of Joining <br>");
          }
          try{
               if(uuid != null && !uuid.equals("")){
                    Row r=dataObject.getRow("Employee");
                    r.set("USER_ID",uuid);  
                    dataObject.updateRow(r);
                    per.update(dataObject); 
                    out.print("<br> Successfully Updated UserID <br>");
               }
          }
          catch(Exception euid){
               out.print("<br> The User ID you are Entering is Not Present in the Cloud Accounts Table !!!");
          }
          response.sendRedirect("Update.jsp");
     }
}
catch(Exception e2){
     out.print("<br> The ID Doesn't Exist <br>");
     System.out.println("Exception while Updating --> "+e2);
}

%> 


<br>
<center><h1>UPDATE</h1>
<div>
<form method="post">
    <label for="eid">Employee ID:</label>
    <input type="text" id="eid" name="eid" required/>
    <label for="ename">Name:</label>    
    <input type="text" id="ename" name="ename" />
    <label for="det">Department:</label>    
    <input type="text" id="dept" name="dept" />
    <label for="department">Date of Joining:</label>    
    <input type="date" id="doj" name="doj" />
    <label for="department">User ID:</label>    
    <input type="text" id="uuid" name="uuid" />
    <input type="submit" value="UPDATE" />
</form>
</div></center>
<br>

</body>
</html>