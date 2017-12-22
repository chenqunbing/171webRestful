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
		<link rel="stylesheet" type="text/css" href="css/index.css">		
		<title>五子棋</title>
		<script>
				var chessboard = {
						rows	:	15,
						cols	:	15,
						cellSize:	40,
						winCondition:5
				}	
				
				var blackOrWhite = 0;
				var duration = -8*3600*1000;
				var gameTimer = {};
				var curGameID = 0;
				
		
				$(document).ready(function(){
					loadSavedGameListData();
				});
				
				function showMessage(data){
					if(data!=undefined){
					 	alert(data.message);
					 }
				}
				
				function loadSavedGameListData (data) {
					//补充获取列表数据代码
					 if(data!=undefined){
					 	alert(data.message);
					 	if(typeof data.o === 'number'){
					 		curGameID = data.o; 
					 	}
					 }
					 request({},"POST","app/goBang/list",loadSavedGameList);
				 }
				 
				 function loadSavedGameList(data){	 
						//补充列表显示代码					 		
					 	var savedGames = $("#savedGames");
					 	savedGames.html("");
					 	$(data).each(function(index,game){
					 		 var option = $("<option>").val(game.id).text(game.caption);
					 		 savedGames.append(option);							
						});
					 	savedGames.val(curGameID);
					 	$("#goBang").attr("gameID",curGameID);
					 }
				 
				function newGame(){
					iniBoard();
					duration = -8*3600*1000;
					clearInterval(gameTimer);
					gameTimer = setInterval(showCurDuration,1000);					
				}
				
				function loadGame(){
					var game = new Object();
					game.id = $("#savedGames").val();
					request(game,"POST","app/goBang/fetchByID",loadGameBoard);
				}
				
				function loadGameBoard(game){
					newGame();
					var board=$("#goBang");
					curGameID = game.id;
					board.attr("gameID",curGameID);
					blackOrWhite = JSON.parse(game.goBang).blackOrWhite;
					
					$(JSON.parse(game.goBang).cells).each(function(index , cellData){
						var cell =$(board.find("div[row="+cellData.row+"][col="+cellData.col+"]"));
						if(cellData.chessPieceColor!="none"){
							cell.attr("chessPieceColor",cellData.chessPieceColor);
						    cell.css("background-size",chessboard.cellSize*2+"px "+chessboard.cellSize+"px");						 
							cell.css("background-position",((cellData.chessPieceColor-1)*chessboard.cellSize)+"px  0px");
							cell.css("background-image","url(images/chessPieces.png)");
							cell.css("background-repeat","none");
						}
					});
					
					$("#curPiece").css("background-size","100px 50px");						 
					$("#curPiece").css("background-position",(blackOrWhite-1)*50+"px  0px");
					$("#curPiece").css("background-image","url(images/chessPieces.png)");
					$("#curPiece").css("background-repeat","none");
				}
				
				
				function saveGame(){
					var board=$("#goBang");
					var game = new Object();					 
					game.id=board.attr("gameID");
					if(game.id==0){
						game.caption = prompt("请输入存档名称");
					}else{
						game.caption = $("#savedGames").find("option:selected").text();
					}
					var data=$("#goBang div[chessPieceColor!='none']");
					var goBang = new Object();
					var cells = new Array(); 
					$(data).each(function(index,datum){
						 datum = $(datum);
						 var cell = new Object();
						 cell.row = datum.attr("row");
						 cell.col = datum.attr("col");
						 cell.chessPieceColor = datum.attr("chessPieceColor");
						 cells.push(cell);
					}); 
					goBang.cells = cells; 
					goBang.blackOrWhite = blackOrWhite;
					game.goBang = JSON.stringify(goBang);
					request(game,"POST","app/goBang/save",loadSavedGameListData);
				}
				
				function iniBoard(){
					var board=$("#goBang");
					 board.html("");
					 curGameID = 0;
					 board.attr("gameID",curGameID);
					 board.css("width",chessboard.cols*chessboard.cellSize);
					 board.css("height",chessboard.rows*chessboard.cellSize);
					 board.css("background-size",chessboard.cols*chessboard.cellSize+" "+chessboard.rows*chessboard.cellSize);
					 
					 curWinner= $("#curWinner");
					 curWinner.css("background-image","url(images/unKnown.png)");
					 curWinner.css("background-size","50px 50px");
					 
					 for(var row = 0;row<chessboard.rows;row++){
						 for(var col = 0;col<chessboard.cols;col++){
							 var cell = $("<div onclick='placeChessPiece($(this))'>");
							 cell.css("position","absolute");
							 cell.css("width",chessboard.cellSize);
							 cell.css("height",chessboard.cellSize);
							 cell.css("border","1px solid #885204");
							 cell.css("left",col*chessboard.cellSize);
							 cell.css("top",row*chessboard.cellSize);
							 cell.attr("chessPieceColor","none");
							 cell.attr("row",row);
							 cell.attr("col",col);
							 board.append(cell);
						 }
					 }
					 
					 blackOrWhite = 0;
					 
					 $("#curPiece").css("background-size","100px 50px");						 
					 $("#curPiece").css("background-position",(blackOrWhite-1)*50+"px  0px");
					 $("#curPiece").css("background-image","url(images/chessPieces.png)");
					 $("#curPiece").css("background-repeat","none");
					 
				}
					
				function placeChessPiece(cell){
					// console.log(cell.attr("chessPieceColor"));
					 if(pieceCountInLine()>=chessboard.winCondition){
						 alert("此游戏已经结束，请重新开局或加载存档");
						 return;
					 }
					 if(cell.attr("chessPieceColor")=="none"){
						 cell.attr("chessPieceColor",blackOrWhite);
						 blackOrWhite = (blackOrWhite+1)%2;
						 cell.css("background-size",chessboard.cellSize*2+"px "+chessboard.cellSize+"px");						 
						 cell.css("background-position",(0-blackOrWhite*chessboard.cellSize)+"px  0px");
						 cell.css("background-image","url(images/chessPieces.png)");
						 cell.css("background-repeat","none");		
						 
						 $("#curPiece").css("background-size","100px 50px");						 
						 $("#curPiece").css("background-position",(blackOrWhite-1)*50+"px  0px");
						 $("#curPiece").css("background-image","url(images/chessPieces.png)");
						 $("#curPiece").css("background-repeat","none");
						 
						 if(pieceCountInLine()==chessboard.winCondition){
							 $("#curWinner").css("background-size","100px 50px");						 
							 $("#curWinner").css("background-position",(0-blackOrWhite)*50+"px  0px");
							 $("#curWinner").css("background-image","url(images/chessPieces.png)");
							 $("#curWinner").css("background-repeat","none");
							 if(blackOrWhite==0){
							 	alert("执白胜"); 
							 }else{
								alert("执黑胜");
							 }
						 }
					 }else{
						 alert("此处不可落子！");
					 }
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
				 
				 function showCurDuration(){
					 duration=duration+1000;
					 $("#curDuration").html("游戏计时"+new Date(duration).Format("hh:mm:ss"));
				 }
				</script>
</head>
<body>
<table>
	<tr>
		<td width="40px"><button onclick="newGame()" style="width:50px;height:50px;float:left">新开一局</button></td>
		<td width="10px"></td>
		<td width="35px">当前执子</td>
		<td><div id="curPiece" style="width:50px;height:50px;"></div></td>
		<td width="10px"></td>
		<td width="35px">本局赢家</td>
		<td><div id="curWinner" style="width:50px;height:50px;background-image:url(images/unKnown.png);background-size:50px 50px"></div></td>
		<td width="10px"></td>
		<td   id="curDuration"  width="70px"  rowspan=2  style="text-align:center;vertical-align:middle"></td>		
	</tr>
</table>			
		
<div id="goBang"></div>

<table>
	<tr>
		<td width="70px">游戏存档</td>
		<td width="10px">
				<select id="savedGames" style="width:140px"></select>
		</td>
		<td width="80px"><button onclick="loadGame()" style="width:80px;height:25px;float:left">加载游戏</button></td>
		<td width="10px"></td>
		<td width="8px"><button onclick="saveGame()" style="width:80px;height:25px;float:left">保存游戏</button></td>
	</tr>
</table>	

</body>
</html>

