<%@page contentType="text/html" import="java.io.*, java.sql.Connection, 
com.adventnet.persistence.*, com.adventnet.ds.query.*, com.adventnet.ds.query.util.*, 
com.adventnet.db.persistence.metadata.*, 
com.adventnet.persistence.personality.*, com.adventnet.persistence.xml.*,
com.adventnet.ds.query.DataSet,com.adventnet.db.api.RelationalAPI,com.adventnet.ds.query.*"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.adventnet.mfw.bean.BeanUtil"%>
<%@page import="java.util.*" %>  

<html>
<body>

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
ArrayList clist=new ArrayList();
clist.add(col1);
clist.add(col2);
clist.add(col3);
clist.add(col4);
sq.addSelectColumns(clist);

out.print("<center><h1>CRUD</h1></center>");

out.print("<h3>1. Show Details </h3>");
sq.addSelectColumn(Column.getColumn("Employee","*"));
dataObject = per.get(sq);
it = dataObject.getRows("Employee",(Criteria)null);
out.print("<table border=2px >");
out.print("<tr><th>EmployeeID</th><th>EmployeeName</th><th>Department</th><th>UserID</th></tr>");
while(it.hasNext()){
     Row rw=(Row)it.next();
     out.print("<tr>");
     out.print("<td>"+rw.get(1)+"</td>");
     out.print("<td>"+rw.get(2)+"</td>");
     out.print("<td>"+rw.get(3)+"</td>");
     out.print("<td>"+rw.get(4)+"</td>");
     out.print("</tr>");
}
out.print("</table>");

out.print("");
String name = request.getParameter("name");
String id = request.getParameter("id");
String department=request.getParameter("department");
String uid=request.getParameter("uid");

try{
     if (name != null && !name.equals("") && id != null && !id.equals("")) {
     	Row r = new Row("Employee");
          r.set("EMP_ID",Long.parseLong(id));
          r.set("EMP_NAME",name);
          r.set("DEPT",department);
          r.set("USER_ID",uid);

          dataObject = new WritableDataObject();
          dataObject.addRow(r);
          per.add(dataObject);
          out.print("<br> Successfully Added the Data <br>");
          response.sendRedirect("CRUD.jsp");
     }
}
catch(Exception e){
     out.print(e);
     out.print("<br> The ID already Exists <br>");
     System.out.println("Exception while adding --> "+e);
}


out.print("");
String id1 = request.getParameter("id1");
try{
     if (id1 != null && !id1.equals("")) {
          dataObject = per.get("Employee",(Criteria)null);  
          c = new Criteria(new Column("Employee","EMP_ID"),Integer.parseInt(id1),QueryConstants.EQUAL);  
          dataObject.deleteRows("Employee",c);
          per.update(dataObject);
          out.print("<br> Successfully Deleted <br>");
     }
}
catch(Exception ex){
     out.print("<br> The ID Doesn't Exist <br>");
     System.out.println("Exception while Deleting --> "+ex);
}


out.print("");
String id2 = request.getParameter("eid");
String ename = request.getParameter("ename");
String dept = request.getParameter("dept");
String uuid = request.getParameter("uuid");
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
          else{
               out.print("Error while Updating Name");               
          }
          if(dept != null && !dept.equals("")){
               Row r=dataObject.getRow("Employee");
               r.set("DEPT",dept);  
               dataObject.updateRow(r);
               per.update(dataObject); 
               out.print("<br> Successfully Updated Department <br>");
          }
          else{
               out.print("Error while Updating Department");               
          }
          if(uuid != null && !uuid.equals("")){
               Row r=dataObject.getRow("Employee");
               r.set("USER_ID",uuid);  
               dataObject.updateRow(r);
               per.update(dataObject); 
               out.print("<br> Successfully Updated UserID <br>");
          }
          else{
               out.print("Error while Updating UserID");               
          }
     }
}
catch(Exception e2){
     out.print("<br> The ID Doesn't Exist <br>");
     System.out.println("Exception while Updating --> "+e2);
}

%> 
<br>
<h3>2. Add Details </h3>
<form method="post">
    <label for="ID">Employee ID:</label>    
    <input type="text" id="id" name="id" required/>
    <label for="name">Name:</label>    
    <input type="text" id="name" name="name"  required/>
    <label for="department">Department:</label>    
    <input type="text" id="department" name="department" required/>
    <label for="department">User ID:</label>    
    <input type="text" id="uid" name="uid" required/>
    <input type="submit" value="Submit" />
</form>
<br>

<br>
<h3>3. Delete Details </h3>
<form method="post">
    <label for="id1">Employee ID:</label>
    <input type="text" id="id1" name="id1" required/>
    <input type="submit" value="Submit" />
</form>
<br>

<br>
<h3>4. Update Details (type the employee id and update the details for that )</h3>
<form method="post">
    <label for="eid">Employee ID:</label>
    <input type="text" id="eid" name="eid" required/>
    <label for="ename">Name:</label>    
    <input type="text" id="ename" name="ename" />
    <label for="det">Department:</label>    
    <input type="text" id="dept" name="dept" />
    <label for="department">User ID:</label>    
    <input type="text" id="uuid" name="uuid" />
    <input type="submit" value="Submit" />
</form>
<br>

<form action="ww.jsp" method="post">
<label for="redirect">Click this to add data to Cloud table!!</label>
<input type="submit" value="GGGooooooo" />



</body>
</html>