<%@page contentType="text/html" import="java.io.*, java.sql.Connection, 
com.adventnet.persistence.*, com.adventnet.ds.query.*, com.adventnet.ds.query.util.*, 
com.adventnet.db.persistence.metadata.*, 
com.adventnet.persistence.personality.*, com.adventnet.persistence.xml.*,
com.adventnet.ds.query.DataSet,com.adventnet.db.api.RelationalAPI,com.adventnet.ds.query.*,
com.adventnet.db.persistence.NonGapSequenceGenerator,com.adventnet.db.persistence.SequenceGenerator"%>
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


<% 


SelectQuery sq = new SelectQueryImpl(new Table("Employee"));
SelectQuery sq1 = new SelectQueryImpl(new Table("Cloud_Accounts"));
UpdateQuery uq = new UpdateQueryImpl("Cloud_Accounts");
SequenceGenerator sg=new NonGapSequenceGenerator();
sg.init("Emp__DB");
SequenceGenerator sg1=new NonGapSequenceGenerator();
sg1.init("CA__DB");
Persistence per = (Persistence)BeanUtil.lookup("Persistence");
DataObject dataObject,dataObject1;
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
sq1.addSelectColumn(new Column("Cloud_Accounts","uid"));
sq1.addSelectColumn(new Column("Cloud_Accounts","user_id"));
sq1.addSelectColumn(new Column("Cloud_Accounts","cloud_type"));
sq.addSelectColumn(Column.getColumn("Employee","*"));
sq1.addSelectColumn(Column.getColumn("Cloud_Accounts","*"));
dataObject = per.get(sq);
dataObject = per.get(sq1);
out.print("<center><h1>ADD Details</h1></center>");
String name = request.getParameter("name");
String department=request.getParameter("department");
String uid=request.getParameter("uid");
String doj = request.getParameter("doj");
String cloud_type = request.getParameter("cloud_type");

try{
     if (name != null && !name.equals("") && department != null && !department.equals("") && uid != null && !uid.equals("") && cloud_type != null && !cloud_type.equals("")) {
     	Row r = new Row("Employee");
          r.set("EMP_ID",sg.nextValue());
          r.set("EMP_NAME",name);
          r.set("DEPT",department);
          r.set("DOJ",doj);
          
          c = new Criteria(new Column("Cloud_Accounts","user_id"),uid,QueryConstants.EQUAL);  
          Row r1 = new Row("Cloud_Accounts");
          it = dataObject.getRows("Cloud_Accounts",c);
          dataObject = new WritableDataObject();
          if(it.hasNext()){
               uq.setCriteria(c);
               uq.setUpdateColumn("cloud_type",cloud_type);
               per.update(uq); 
          }
          else{
               out.print("illa");
               r1.set("uid",sg1.nextValue());
               r1.set("user_id",uid);
               r1.set("cloud_type",cloud_type);
               dataObject.addRow(r1);
          }
               r.set("USER_ID",uid);
               dataObject.addRow(r);
               per.add(dataObject);
          response.sendRedirect("Add.jsp");
          out.print("<br> Successfully Added the Data <br>");
     }
}
catch(Exception e){
     out.print(e);
     out.print("<br> Error While Adding Data !!!<br>");
     System.out.println("Exception while adding --> "+e);
}


%> 
<br>
<h3>  </h3>
<center>
<div>
<form method="post">
    <label for="name">Name:</label>    
    <input type="text" id="name" name="name"  required/>
    <label for="department">Department:</label>    
    <input type="text" id="department" name="department" required/>
    <label for="department">User ID:</label>    
    <input type="text" id="uid" name="uid" required/>
    <label for="department">Date of Joining:</label>    
    <input type="date" id="doj" name="doj" required/>
    <label for="ID">Cloud Type:</label>    
    <input type="text" id="cloud_type" name="cloud_type" required/>
    <input type="submit" value="Submit" />
</form>
</div>
</center>
<br>
<style>
input[type=text],[type=date] {
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



</body>
</html>