<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%    
if(!request.getRemoteAddr().equals("127.0.0.1")){
		out.println("本资源并未授权给您的地址使用");
		return;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="js/jquery-1.10.2.min.js" type="text/javascript"></script>
		<script src="js/ext.js" type="text/javascript"></script>
		<title>宠物管理</title>
		<style>
		        body{
		         	margin:2px;
		         	font-size:16px;
		        	font-family: "Microsoft YaHei";
		         }
		         
		        img{
		        	margin:5px 10px 5px 5px;
		        	border:1px solid #999999;
		        } 
		        
		        input[type="button"]{
		        	width:70px;
		        	height:32px;
		        	font-family: "Microsoft YaHei";			        		        	
		        }
		        
		        #btLoadImgUrl{background:#fdf8de;}
		        
		        #btAdd,#btSave{background:#7ec6fd;}
		        
		        #btDelete{background:#fd7e84;}
		         
				div[type=card]{
					top:0px;
					width:400px;
					height:210px;
					line-height:26px;
					border:1px solid #999999;
					background:#ebbffc;
					color:black;
					padding:5px;
					float:left;
				}
				
				#petCard{
					background:#fbcfae;
				}
				
				#pets{
					width:100%;		
					height:100%;				
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
				
				 function Pet(id, code, name, kind, price, buyDate, imageUrl){
					 var o = {};
					 o.id = id;
					 o.code = code;
					 o.name = name;
					 o.kind = kind;
					 o.price = price;
					 o.buyDate = buyDate;
					 o.imageUrl = imageUrl;
					 return o;
				 }
				 
				 function refreshPetList(data){	 
					//补充列表显示代码
					 var list=$("#pets").find("#dataList");
					 list.html("");
					 $(data).each(function (index,pet){
						 var card = $("#petCard").clone();
						 
						 card.attr("id","petCard"+pet.id);
						 
						 var btLoadImgUrl = "<input id=\"btLoadImgUrl\" type=\"button\" value=\"修改照片\" onclick=\"loadImage($('#petCard"+pet.id+"').find('#petImageUrl'))\"> ";
						 var btSave = "<input id=\"btSave\" type=\"button\" value=\"保存\" onclick=\"savePet($('#petCard"+pet.id+"'))\"> ";
						 var btDelete = "<input id=\"btDelete\" type=\"button\" value=\"删除\" onclick=\"deletePet($('#petCard"+pet.id+"'))\">";
						 
						 card.attr("dataID",pet.id);
						 card.find("#petCode").val(pet.code);
						 card.find("#petName").val(pet.name);
						 card.find("#petKind").val(pet.kind);
						 card.find("#petPrice").val(pet.price);						 
						 card.find("#petBuyDate").val(new Date(pet.buyDate).Format("yyyy-MM-dd"));
						 card.find("#petImageUrl").attr("src",pet.imageUrl);
						 card.find("#console").html("");
						 card.find("#console").append(btLoadImgUrl);
						 card.find("#console").append(btSave);
						 card.find("#console").append(btDelete);
						 list.append(card);
					 });
				 }
				
				 function fetchPetListData (data) {
					//补充获取列表数据代码
					 if(data!=undefined){
					 	alert(data.message);
					 }
					 request({},"POST","app/pet/list",refreshPetList);
				 }
				 
				 function createPet(card){
					 //补充向表添加数据的代码
					 var pet = new Pet(card.attr("dataID"),		
							 card.find("#petCode").val(),
							 card.find("#petName").val(),
							 card.find("#petKind").val(),
							 card.find("#petPrice").val(),							 
							 card.find("#petBuyDate").val(),
							 card.find("#petImageUrl").attr("src")
					 );					
					 request(pet,"POST","app/pet/add",fetchPetListData);	 
				 }
				 
				 function savePet(card){
					 //补充向表添加数据的代码
					 var pet = new Pet(card.attr("dataID"),		
							 card.find("#petCode").val(),
							 card.find("#petName").val(),
							 card.find("#petKind").val(),
							 card.find("#petPrice").val(),							 
							 card.find("#petBuyDate").val(),
							 card.find("#petImageUrl").attr("src")
					 );					
					 request(pet,"POST","app/pet/save",fetchPetListData);	 
				 }
				 
				 function deletePet(card){
					 //补充向表删除数据的代码
					 var pet = new Pet(card.attr("dataID"));
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
				 
				 function loadImage(object){
					 object.attr("src",window.prompt("请输入照片地址","images/none.jpg"));
				 }
				</script>
</head>
<body>
<div id="pets">
	<div id="petCard" dataID=0 type="card">
	 <img id="petImageUrl" width="150" height="200" src="images/none.jpg" style="float:left">
	    宠物编号：<input id="petCode" type="text"><br>
	    宠物名称：<input id="petName" type="text"><br>
	    宠物类别：<select id="petKind">
			  <option value ="猫">猫</option>
			  <option value ="狗">狗</option>
			  <option value ="鱼">鱼</option>
			  <option value ="鸟">鸟</option>
			</select><br>
	    购买价格：<input id="petPrice" type="text"><br>
	    购买日期：<input id="petBuyDate" type="text" placeholder="格式：1995-01-07"><br>
	    <hr>
	 <div id="console" style="text-align:right;">   
	 	<input id="btLoadImgUrl" type="button" value="加载照片" onclick="loadImage($('#petCard').find('#petImageUrl'))">
	 	<input id="btAdd" type="button" value="添加" onclick="createPet($('#petCard'))">
	 </div> 
	</div>
	<div id="dataList">
	</div>	
</div>	
</body>
</html>

