<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="js/jquery-3.1.0.min.js" type="text/javascript"></script>
		<title>宠物管理</title>
		<style>
		         body{
		         	margin:0px;
		         }
		        
		        table {						
						color:#333333;
						border-width: 1px;
						border-color: #999999;
						border-collapse: collapse;
					}

 				table thead td{
		         	color:white;
					border:1px solid #888888;
					background:#666666;
					height:30px;
					line-height:30px;
					text-align:center;
				 }		         
		         
				table tr {
						background-color:#d4e3e5;						
					}
				
				table td {
						border-width: 1px;
						padding: 8px;
						border-style: solid;
						border-color: #a9c6c9;
						text-align:center;
					}
		         
				#petData{
					top:0px;
					height:32px;
					line-height:32px;
					border:1px solid green;
					background:green;
					color:white;
					padding:5px;
				}
				
				#petList{
					width:100%;					
					border:1px solid #AAAAAA;
					background:#EEEEEE;
					color:black;
					padding:5px;
				}
				
		</style>
		
		<script>
				$(document).ready(function(){
					fetchPetListData();	
				});
				
				 function Pet(id, code, name, kind, price){
					 var o = {};
					 o.id = id;
					 o.code = code;
					 o.name = name;
					 o.kind = kind;
					 o.price = price;
					 return o;
				 }
				 
				 function refreshPetList(data){	 
					//补充列表显示代码
					 var tBody=$("#gridList tbody");
					 tBody.html("");
					 $(data).each(function (index,pet){
						 var row = "<tr>"+
						 		   "<td width='30px'>"+pet.id+"</td>"+
						 		   "<td  width='200px'>"+pet.code+"</td>"+						 		   
						 		   "<td  width='200px' >"+pet.name+"</td>"+
						 		   "<td  width='200px' >"+pet.kind+"</td>"+
						 		   "<td  width='200px' >"+pet.price+"</td>"+
						 		   "<td  width='100px'> "+
						 		   "	<input type='button' value='删除' onclick='deletePet("+pet.id+")' >"+
						 		   "</td>"+
						 		   "</tr>";
						 tBody.append(row);
					 });
				 }
				
				 function fetchPetListData (data) {
					//补充获取列表数据代码
					 if(data!=undefined){
					 	alert(data.message);
					 }
					 request({},"POST","app/pet/list",refreshPetList);
				 }
				 
				 function createPet(){
					 //补充向表添加数据的代码
					 var pet = new Pet(0,		
							 $("#petCode").val(),
							 $("#petName").val(),
							 $("#petKind").val(),
							 $("#petPrice").val()
					 );
					 request(pet,"POST","app/pet/add",fetchPetListData);	 
				 }
				 
				 function deletePet(id){
					 //补充向表删除数据的代码
					 var pet = new Pet(id);
					 request(pet,"POST","app/pet/delete",fetchPetListData);	
				 }
				 
			
				 function request(object,method,methodURL,successFunction){	
					//补充ajax调用API接口实现通信的代码         
					$.ajax({
				        cache: true,
				        type: method,
				        datatype:"json",
				        contentType: "application/json",
				        url:methodURL,
				        data:JSON.stringify(object),
				        error: function(XMLHttpRequest, textStatus, errorThrown) {
				        	 alert(XMLHttpRequest.status+"\r\n"+XMLHttpRequest.readyState+"\r\n"+textStatus);
				        },
				        success: successFunction
				    });
				 } 
				</script>
</head>
<body>
<div id="petData">
    宠物编号：<input id="petCode" type="text">
    宠物名称：<input id="petName" type="text">
    宠物类型：<input id="petKind" type="text">
    宠物价格：<input id="petPrice" type="text">
	<input type="button" value="添加" onclick="createPet()">
</div>
<div id="petList">
	<center>
		<table id='gridList'>
			<thead><tr><td>ID</td><td>编号</td><td>名称</td><td>类型</td><td>价格</td><td>操作</td></tr></thead>
			<tbody></tbody>
		</table>
	</center>	
</div>	
</body>
</html>