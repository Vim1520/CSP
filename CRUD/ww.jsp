<%@page contentType="text/html" import="java.io.*,java.util.*, java.sql.Connection, 
com.adventnet.persistence.*, com.adventnet.ds.query.*, com.adventnet.ds.query.util.*, 
com.adventnet.db.persistence.metadata.*, 
com.adventnet.persistence.personality.*, com.adventnet.persistence.xml.*,
com.adventnet.ds.query.DataSet,com.adventnet.db.api.RelationalAPI,com.adventnet.ds.query.UpdateQuery,
com.adventnet.db.persistence.NonGapSequenceGenerator,com.adventnet.db.persistence.SequenceGenerator,
com.adventnet.ds.query.UpdateQueryImpl,com.adventnet.ds.query.Operation.operationType.*"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.adventnet.mfw.bean.BeanUtil"%>
<%@page import="java.util.*" %>  
<!DOCTYPE html>
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
input[type=text]{
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
     
SelectQuery sq = new SelectQueryImpl(new Table("Cloud_Accounts"));
Persistence per = (Persistence)BeanUtil.lookup("Persistence");
DataObject dataObject;
Iterator it;
Criteria c;

SequenceGenerator sg1=new NonGapSequenceGenerator();
sg1.init("CA__DB");
Column col1=new Column("Cloud_Accounts","uid");
Column col2=new Column("Cloud_Accounts","user_id");
Column col3=new Column("Cloud_Accounts","cloud_type");
ArrayList clist=new ArrayList();
clist.add(col1);
clist.add(col2);
clist.add(col3);
sq.addSelectColumns(clist);
sq.addSelectColumn(Column.getColumn("Cloud_Accounts","*"));
dataObject = per.get(sq);
it = dataObject.getRows("Cloud_Accounts",(Criteria)null);
out.print("<br><center><h1>Details in Cloud Table</h1></center><br>");
out.print("<center><center><table border=2px >");
out.print("<tr><th>UID</th><th>UserID</th><th>CloudType</th>");
while(it.hasNext()){
     Row r = (Row)it.next();
     out.print("<tr>");
     out.print("<td>"+r.get(1)+"</td>");
     out.print("<td>"+r.get(2)+"</td>");
     out.print("<td>"+r.get(3)+"</td>");
     out.print("</tr>");
}
     out.print("</table></center></center><br><br><BR>");     
     SelectQuery sq12 = new SelectQueryImpl(new Table("Employee"));
     Column clm = new Column("Employee","EMP_ID");
     Column clm1 = Column.createOperation(Operation.operationType.ADD, new Column("Employee", "EMP_ID"), new Integer(1000));
     clm1.setDataType("INTEGER");
     c = new Criteria(Column.getColumn("Employee","DEPT"),"CSE",QueryConstants.EQUAL);   
     sq12.addSelectColumn(clm1);
     sq12.setCriteria(c);

  //   GroupByColumn gc = new GroupByColumn(new Column("Employee","EMP_ID"),true);
  //   GroupByColumn gc1 = new GroupByColumn(new Column("Employee","EMP_NAME"),true);
  //   GroupByColumn gc2 = new GroupByColumn(new Column("Employee","DEPT"),true);
  //   GroupByColumn gc3 = new GroupByColumn(new Column("Employee","USER_ID"),true);
  //   GroupByColumn gc4 = new GroupByColumn(new Column("Employee","DOJ"),true);
  //   List <GroupByColumn> gcl=new ArrayList<GroupByColumn>();
  //   gcl.add(gc);
  //   gcl.add(gc1);
  //   gcl.add(gc2);
  //   gcl.add(gc3);
  //   gcl.add(gc4);
  //   GroupByClause gbc = new GroupByClause(gcl, new Criteria(new Column("Employee","EMP_ID"),1,QueryConstants.EQUAL));
  //   sq12.setGroupByClause(gbc);

  java.sql.Connection conn=null;
  DataSet ds = null;
  long[] count = new long[10];
  int index = 0;
  try{
     conn=RelationalAPI.getInstance().getConnection();
     ds=RelationalAPI.getInstance().executeQuery(sq12, conn);
     while(ds.next()){
          out.print("<br> -->"+ds.getValue(1)+"<br>");
          //out.print("<br> -->"+ds.getValue(2)+"<br>");
          //out.print("<br> -->"+ds.getValue(3)+"<br>");
          //out.print("<br> -->"+ds.getValue(4)+"<br>");
          //out.print("<br> -->"+ds.getValue(5)+"<br>");
     }
     for(int i=0;i<index;i++)
     out.print("<br>"+count[i]+"<br>");
     if(ds!=null){
          ds.close();
     }
     if(conn!=null){
          conn.close();
     }
  }
  catch(Exception e){
     out.print(e);
  }
String userid = request.getParameter("userid");
String ctype = request.getParameter("ctype");

try{
     if (userid != null && !userid.equals("") && ctype != null && !ctype.equals("")) {
     	Row r = new Row("Cloud_Accounts");
          r.set("uid",sg1.nextValue());
          r.set("user_id",userid);
          r.set("cloud_type",ctype);
          dataObject = new WritableDataObject();
          dataObject.addRow(r);
          per.add(dataObject);
          out.print("<br> Successfully Added the Data <br>");
     }
}
catch(Exception e){
     out.print(e);
     out.print("<br> The ID already Exists in Cloud Table<br>");
     System.out.println("Exception while adding --> "+e);
}

	%>
     <center>
     <div>
     <h2>Add to Cloud Table</h2>
	<form method="post">
		<label for="name">userid:</label>
		<input type="text" id="userid" name="userid" />
		<label for="name">cloud_type:</label>
		<input type="text" id="ctype" name="ctype" />
		<input type="submit" value="Submit" />
	</form>
     </div>
     </center> 
     <BR>
</body>
</html>


