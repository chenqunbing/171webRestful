<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%    
if(!request.getRemoteAddr().equals("127.0.0.1")){
		out.println("本资源并未授权给您的地址使用");
		return;
}
%>
<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="js/jquery-3.1.0.min.js" type="text/javascript"></script>
		<style>
			body{
				background-color:#e7e7e9;
				background-image: url(images/pageBack.png);
				background-repeat:no-repeat;
				background-size:100% 100%; 
			}
			table{
				box-shadow:0 0 20px 0 #000000;
				border-collapse:collapse;
				margin:10px;
			}
			button{
				margin:2px; 
				width:100px;
				height:36px;
				line-height:32px;
				font-family: "Microsoft YaHei";
				font-size:16px;
				color:white;
				background-image: url(images/button.png);
				background-repeat:no-repeat;
				border-radius:5px;
				border: 1px solid #AAAAAA;
			}
			
			#modelCanvas{
				background-image: url(images/background.png);
				background-size:1024 800; 
				background-repeat:no-repeat;
			}
			
			#imageList{
				height:800;
				overflow:scroll;
				background-image: url(images/imageList.png);				
			}
			
			#imageList img{
				width:160;
				margin:5px;				
			}
			
			#imageList img:hover{
				box-shadow:0px 0px 32px #FFFFFF;		
			}
		</style>
		<script>
				/* 初始化，向衣橱填充类型为 1 的物品 */
				$(document).ready(function(){
					requestCodeImage(1);
				});
				
				/* 向衣橱填充类型为 kind 的物品 */
				function requestCodeImage(kind){
					var data=DBEntity(null,null,null,null,null,null,null,null,kind);
					fetchCodeImageListData(data);				
				}
				
				/* 实体bean对象 */
				function DBEntity(id,code,caption,url,x,y,w,zIndex,kind){
					 var o = {};
					 o.id = id;//标识字段
					 o.code = code;//物品编号
					 o.caption = caption;//物品名称
					 o.url = url;//物品对应图片地址
					 o.x = x;//物品在modelCanvas中的x坐标位置
					 o.y = y;//物品在modelCanvas中的y坐标位置
					 o.w = w;//物品在modelCanvas中的宽度
					 o.zIndex = zIndex;//物品在modelCanvas中z轴上的显示层次
					 o.kind = kind;
					 return o;
				 }
				 
				/* 获取衣橱物品数据 */
				function fetchCodeImageListData (data) {
					request(data,"POST","app/codeImage/list",refreshCodeImageList);
				}
				 function buildImg(item){
					 var img=$("<img></img>").attr("src",item.url).css("display","block").css("margin","0 auto");
						img.attr("imgId",item.id);
						img.attr("code",item.code);
						img.attr("caption",item.caption);
						img.attr("url",item.url);
						img.attr("x",item.x);
						img.attr("y",item.y);
						img.attr("w",item.w);
						img.attr("zIndex",item.zIndex);
						img.attr("kind",item.kind);
					return img;
				 }
				/* 使用衣橱物品数据进行用户界面展示 */
				function refreshCodeImageList(data){	 
					$("#imageList").empty();
					
					$.each(data,function(index,item){
						var img=buildImg(item);
						img.attr("onclick","wearIt(this)");
						$("#imageList").append(img);
					});
				}
				 
				/* 给模特穿戴物品 */
				function wearIt(object){
					var img=$(object).clone();
					var id=img.attr("imgId");
					img.css("width",img.attr("w")+"px");
					img.attr("onclick","takeoff("+id+")");
					// img.attr("display","in");
					var div=$("<div></div>").append(img).attr("class","suit");
					div.attr("id",img.attr("imgId"));
					div.attr("code",img.attr("code"));
					div.attr("url",img.attr("src"));
					div.attr("caption",img.attr("caption"));
					div.attr("kind",img.attr("kind"));
					div.css("position","absolute");
					div.css("left",img.attr("x")+"px");
					div.css("top",img.attr("y")+"px");
					div.css("z-index",img.attr("zIndex"));
					$("#modelCanvas").append(div);
					var suit=DBEntity(0,div.attr("code"),div.attr("caption"),div.attr("url"),img.attr("x"),img.attr("y"),img.attr("w"),div.css("z-index"),div.attr("kind"));
						
					saveSuitPart(suit);
				}
				
				/* 给模特脱掉物品 */
				function takeoff(id){
					
					$("#"+id).remove();
					
					saveSuitPart(DBEntity(id));
					
				}

				/* 保存模特穿戴的物品 */
				function saveSuitPart(suit){
					
					if(suit.code!=null&&suit.code!=undefined){
						
						request(suit,"POST","app/suits/save",null);
					}else{
						request(suit,"POST","app/suits/delete",null);
					}
				}
				
				/* 从数据库加载模特穿戴的物品数据 */
				function loadSuit(){
					request(null,"POST","app/suits/list",showMessage);
				}
				
				/* 使用从数据库加载的模特所穿戴物品数据恢复模特着装 */
				function displaySuit(data){
					console.log(data);
					if(data!=null){
						$(".suit").remove();
						$.each(data,function(index,item){
							
							var img=buildImg(item);
							var id=img.attr("imgId");
							img.css("width",img.attr("w")+"px");
							img.attr("onclick","takeoff("+id+")");
							// img.attr("display","in");
							var div=$("<div></div>").append(img).attr("class","suit");
							div.attr("id",img.attr("imgId"));
							div.attr("code",img.attr("code"));
							div.attr("caption",img.attr("caption"));
							div.css("position","absolute");
							div.css("left",img.attr("x")+"px");
							div.css("top",img.attr("y")+"px");
							div.css("z-index",img.attr("zIndex"));
							$("#modelCanvas").append(div);
							
						});
					}
					
				}

				function showMessage(data){
					if(data!=undefined){
						
						displaySuit(data);
					}
				}
				
				/* ajax调用API接口实现通信的代码 */
				function request(object,method,methodURL,successFunction){	
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
	<center>
			<table>
				<tr>
					<td colspan=2 style="background-color:#a84142">
							<center>
								<button onclick="requestCodeImage(4);">头发</button>
								<button onclick="requestCodeImage(3);">帽子</button>
								<button onclick="requestCodeImage(5);">胡子</button>
								<button onclick="requestCodeImage(8);">衬衫/T恤</button>
								<button onclick="requestCodeImage(2);">外套</button>
								<button onclick="requestCodeImage(7);">裤子</button>
								<button onclick="requestCodeImage(6);">鞋</button>
								<button onclick="requestCodeImage(1);">包</button>
							</center>
					</td>
				</tr>
				<tr>
					<td width="360px">
						<div id="imageList">
						
						</div>
					</td>
					<td>
						<div id="modelCanvas"  style="position:relative;width:1024px; height:800px">
							<button onclick="loadSuit();">加载方案</button>
							<div style="position:absolute;top:100px;left:700px;"><img src="images/body.png"></div>				
						</div>
					</td>
				</tr>
			</table>
		</center>
</body>	