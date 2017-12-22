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
		<script src="js/ext.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="css/index.css">
		<script>
				var timeCharSmallOffsetX = new Array(0,-19,-38,-57,-77,-	96,-115,-134,-153,-172);
				var curTimeZone = 8;
				var worldClocks = new Array();

				/* 初始化页面UI，刷新 B区 C区和D区 数据*/
				$(document).ready(function(){
					requestCity();
					requestClock();
				});
				
				/*根据所选洲，刷新 B区 数据*/
				function requestCity(){
					var data=new CityEntity(null,null,null,null,null,null,null,null,null,null);
					fetchCityListData(data);
				}
				
				/*根据所选洲，刷新 C区 D区 数据*/
				function requestClock(){
					var data=new CityEntity(null,null,null,null,null,null,null,null,null,null);
					fetchClockListData(data);
				}
				
				/* 实体bean*/
				function CityEntity(id,code,caption,country,flag,timeZone,x,y,referenceCity,continent){
					var o={};
					o.id=id;
					o.code=code;
					o.caption=caption;
					o.country=country;
					o.flag=flag;
					o.timeZone=timeZone;
					o.x=x;
					o.y=y;
					o.referenceCity=referenceCity;
					o.continent=continent;

					return o;
			    }
				 
				/* 获取所选洲城市列表数据 */
				function fetchCityListData (data) {
					request(data,"POST","app/city/list",refreshCityList);
				}
				 
				/* 获取所选洲时钟列表数据 */
				function fetchClockListData (data) {
					request(data,"POST","app/worldClocks/list",refreshClockList);
				}
				 
				/* 根据所选洲城市列表数据构建B区城市列表 */
				function refreshCityList(data){	 
					$("#cityList").empty();					
					$.each(data,function(index,item){
						var cityDiv=$("<div></div>").css({
							"display":"block"
						});
						cityDiv.attr("id",item.id);
						cityDiv.attr("code",item.code);
						cityDiv.attr("caption",item.caption);
						cityDiv.attr("country",item.country);
						cityDiv.attr("flag",item.flag);
						cityDiv.attr("x",item.x);
						cityDiv.attr("y",item.y);
						cityDiv.attr("referenceCity",item.referenceCity);
						cityDiv.attr("continent",item.continent);
						cityDiv.attr("src",flag);
						$("#cityList").append(cityDiv);
					});								
				}
				 
				/* 根据所选洲时钟列表数据构建C区 D区 用户界面信息 */
				function refreshClockList(data){
					$("#locationTag").css("display","block");
					$("#clockSmall").css("display","block");
					$("#locationTag").css({
						"position":"absolute",
						"top":data.x+"px",
						"left":data.y+"px"
					});
					$("#clockSmall").css({
						"position":"absolute",
						"bottom":"-90px",
						"left":"400px"					
					});
					$("#info").attr("value",data.caption);	
				}
				 
				/* 根据城市信息在D区创建该城市的时钟信息版块 */
				function createClock(object,cityData,offsetX){
					
					$("#country").val(cityData.country);
					$("#city").val(cityData.city);
					$("#timeZone").val(cityData.timeZone);
					
				}
				 
				/* 更新D区时钟时间 */
				function setClockTime(object,cityData,offsetX){
					var duration=-curTimeZone*3600*1000;
					clearInterval(object.timer);
					object.timer=setInterval(clockRun,1000);								
				} 
				
				/* D区时钟每秒更新一次时钟的时间  */
				function clockRun(){
					duration=duration+1000;
					$("#clockSmall").html(new Date(curTime).Format("hh:mm:ss"));						
				}
				
				/* 移除城市时钟标签信息 */
				function removeCityTag(id){
					var cityEntity = new CityEntity(id);
					request(cityEntity,"POST","app/worldClocks/delete",fetchClockListData);	
				}

				/* 添加城市时钟标签信息 */				
				function addCityTag(object){
					var clock=new CityEntity(0,null,object.find("#caption").val(),
							object.find("#country").val(),object.find("#flag").val(),
							object.find("#timeZone").val(),null,null,null,null)													
					request(clock,"POST","app/worldClocks/save",fetchClockListData);
				}		
			
				
				function showMessage(data){
					if(data!=undefined){
						alert(data.showMessage);
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
	<!-- 城市列表中的城市模板  -->
	<div id="city" class="city" ></div><img src="images/CN.png">
	    <div id="cityDescription">国家：中国<br>首都：北京
	        <hr>
	        时区：8
	        <button onclick="addCityTag(this)">+</button>
	    </div>
   </div>
   
   <!-- 城市标签模板  -->
	<div id="locationTag" style="display:none">
		<img id="flag"><div id="info"></div>
	</div>
	<!-- 时钟信息模板  -->
	<div id="clockSmall" style="display:none">
		<img id="flag">
		<table width="290px" border=1 >
			<tr>
				<td align="center">
					<div id = "number1"></div><div id = "number2"></div>
					<div id = "division"></div>
					<div id = "number3"></div><div id = "number4"></div>
					<div id = "division"></div>
					<div id = "number5"></div><div id = "number6"></div>
						
					<div id="country"></div><div id="city"></div><div id="timeZone"></div><div id="op"></div>														
				</td>
			</tr>
		</table>				
	</div>
	<center>
			<table>
				<tr>
					<td id="continentSelector">
							<center>
							    选择洲：
							    <select onchange="requestCity();requestClock();">
								  <option value ="亚洲">亚洲</option>
								  <option value ="欧洲">欧洲</option>
								  <option value="南美洲">南美洲</option>
								  <option value="非洲">非洲</option>
								  <option value="大洋洲">大洋洲</option>
								  <option value="北美洲">北美洲</option>
								</select>
							</center>
					</td>
					<td  id="mapTitle">世界城市时间地图</td>
				</tr>
				<tr>
					<td width="210px"><div id="cityList"></div></td>
					<td valign="top">
						<!-- 世界地图显示区域  -->
						<div id="worldCanvas"></div>
						<!-- 各州城市时间显示区  -->
						<div id="clockShow" ></div>
					</td>
				</tr>
			</table>
		</center>
</body>	