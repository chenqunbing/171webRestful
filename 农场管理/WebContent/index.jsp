<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="js/jquery-3.1.0.min.js" type="text/javascript"></script>
		<title>农场管理</title>
		<style>
			#plantMyFarm {
				border: 1px solid green;
				background: #b8e1fb;
				text-align: center;
				vertical-align: middle;
				line-height: 22px;
			}
			
			table {
				border: 0px solid #ccc;
				border-collapse: collapse;
				padding: 0px;
			}
			
			.field {
				position: relative;
				top: 0px;
				width: 250px;
				height: 260px;
				text-align: left;
				font-size: 14px;
				background: url(images/field.png) no-repeat;
				padding: 0px 0px 10px 0px;
			}
			
			#btDelete {
				position: relative;
				top: 2px;
				left: 2px;
				width: 64px;
				height: 22px;
				line-height: 16px;
				background: #CC0000;
				color: yellow;
				border: 1px solid #FF0000;
				z-index: 255;
			}
			
			#btWater {
				position: relative;
				top: 2px;
				left: 2px;
				width: 64px;
				height: 22px;
				line-height: 16px;
				background: #00FF00;
				color: #005500;
				border: 1px solid #009900;
				z-index: 255;
			}
		</style>
		<script>
			$(document).ready(function() {
				iniFarm();
				refreshFarm();
			});

			//初始化土地布局
			function iniFarm() {
				$("#plantMyFarm").css("position", "relative");
				for(var i = 1; i <= 4; i++) {
					$("#field" + i).css("position", "absolute")
						.css("width", "250px").css("height", "250px");
					$("#field" + i).css("left", (500 + 125 * i) + "px")
						.css("top", (0 + 125 * i) + "px");
				}
				for(var i = 1; i <= 4; i++) {
					$("#field" + (i + 4)).css("position", "absolute")
						.css("width", "250px").css("height", "250px");

					$("#field" + (i + 4)).css("left", (0 + 125 * i) + "px")
						.css("top", (20 + 125 * i) + "px");
				}

			}

			function Plant(id, plantCode, plantCaption, fieldCode, lifeCycle) {
				var o = {};
				o.id = id;
				o.plantCode = plantCode;
				o.plantCaption = plantCaption;
				o.fieldCode = fieldCode;
				o.lifeCycle = lifeCycle;
				return o;
			}

			function refreshFields(data) {

				for(var i = 1; i <= 8; i++) {
					$("#field" + i).html("");
				}

				$(data).each(function(index, fieldData) {
					
					var field = $("#field" + fieldData.fieldCode);
					var infStr = "<img src='images/" + fieldData.plantCode + "" + fieldData.lifeCycle + ".png'/>"
						 +  "<div dataid=" + fieldData.id + "> <button id='btDelete'  onclick='deletePlant(" + fieldData.id + ")'>铲除</button>" +
						"<button id='btWater' onclick=\"waterPlant($(this).parent())\">浇水</button>" +
						" <p>个性化名称:" + fieldData.plantCaption + "</p>" +
						" <p cycle=" + fieldData.lifeCycle + " >成长周期：第" + fieldData.lifeCycle + "期</p>" +
						" <p>土地编号" + fieldData.fieldCode + "</p>" +
						"</div>";
				
					field.append(infStr);
				})
			}

			function refreshFarm(data) {
				//补充获取列表数据代码
				if(data != undefined) {
					alert(data.message);
				}
				request({}, "POST", "http://localhost:8080/restfulPro/app/farm/all", refreshFields);
			}

			function plant() {
				var plant = new Plant(0, $("#plantCode").val(), $("#plantCaption").val(), $("#fieldCode").val(), 1);
				request(plant, "POST", "http://localhost:8080/restfulPro/app/farm/add", refreshFarm);
			}

			function deletePlant(id) {
				console.log(id);
				var plant = new Plant(id, null, null, null, null);
				request(plant, "POST", "http://localhost:8080/restfulPro/app/farm/delete", refreshFarm);
			}

			function waterPlant(plant) {
				var id = plant.attr("dataid");
				var lifeCycle = parseInt(plant.find("p:nth-of-type(2)").attr("cycle")) + 1;
				var p = new Plant(id, null, null, null, lifeCycle);
				request(p, "POST", "http://localhost:8080/restfulPro/app/farm/water", refreshFarm);
			}

			function request(object, method, methodURL, successFunction) {
				$.ajax({
					cache: true,
					type: method,
					datatype: "json",
					contentType: "application/json",
					url: methodURL,
					data: JSON.stringify(object),
					error: function(XMLHttpRequest, textStatus, errorThrown) {
						alert(XMLHttpRequest.status + "\r\n" + XMLHttpRequest.readyState + "\r\n" + textStatus);
					},
					success: successFunction
				});
			}
		</script>
	</head>

	<body>
		<div class="plantMyFarm">
			选择植物：
			<select id="plantCode">
				<option value=1>哇哈哈营养果粒</option>
				<option value=2>星之愿</option>
				<option value=3>杨桃</option>
				<option value=4>甘蔗</option>
			</select>
			植物个性化名称：<input id="plantCaption" type="text" size="20" maxLength="50"> 播种土地：

			<select id="fieldCode">
				<option value=1>1</option>
				<option value=2>2</option>
				<option value=3>3</option>
				<option value=4>4</option>
				<option value=5>5</option>
				<option value=6>6</option>
				<option value=7>7</option>
				<option value=8>8</option>
			</select>
			<input id="btPlant" type="button" value="播种" onclick="plant()">
		</div>

		<div id="field1" class="field"></div>
		<div id="field2" class="field"></div>
		<div id="field3" class="field"></div>
		<div id="field4" class="field"></div>
		<div id="field5" class="field"></div>
		<div id="field6" class="field"></div>
		<div id="field7" class="field"></div>
		<div id="field8" class="field"></div>

	</body>

</html>