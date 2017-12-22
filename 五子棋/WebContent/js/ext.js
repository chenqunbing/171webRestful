Date.prototype.Format = function (fmt) { //author: meizz 
    var o = {
        "M+": this.getMonth() + 1, //月份 
        "d+": this.getDate(), //日 
        "h+": this.getHours(), //小时 
        "m+": this.getMinutes(), //分 
        "s+": this.getSeconds(), //秒 
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
        "S": this.getMilliseconds() //毫秒 
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}

function pieceCountInLine(){
	var board=$("#goBang");
	var count = 0;
	var curColor = -1;
	var oldColor = -1;
	//行扫描					
	for(var row = 0;row<chessboard.rows;row++){
		curColor = -1;
		oldColor = -1;
		 for(var col = 0;col<chessboard.cols;col++){
			 	var cell =$(board.find("div[row="+row+"][col="+col+"]"));
			 	curColor = cell.attr("chessPieceColor");
			 	if(curColor!="none"){
				 	if(curColor==oldColor){
				 		count++;
				 	}else{
				 	   count = 1;
				 	}
				 	if(count>=5){
						return count;
					}
			 	}
			 	oldColor = curColor;
		 }
	 }
	
	//列扫描	
	count = 0;
	for(var col = 0;col<chessboard.cols;col++){					
		curColor = -1;
		oldColor = -1;
		for(var row = 0;row<chessboard.rows;row++){
			 	var cell =$(board.find("div[row="+row+"][col="+col+"]"));
			 	curColor = cell.attr("chessPieceColor");
			 	if(curColor!="none"){
				 	if(curColor==oldColor){
				 		count++;
				 	}else{
				 	   count = 1;
				 	}
				 	if(count>=5){
						return count;
					}
			 	}
			 	oldColor = curColor;
		 }
	 }
	
	
	//斜向扫描左上-中间
	count = 0;	
	for(var col = 0;col<chessboard.cols;col++){					
		curColor = -1;
		oldColor = -1;	
		var stepX = col;
		var stepY = 0;
		for(var i = 0 ;i <=col ;i++){
			 	var cell =$(board.find("div[row="+stepY+"][col="+stepX+"]"));
			 	curColor = cell.attr("chessPieceColor");
			 	if(curColor!="none"){
				 	if(curColor==oldColor){
				 		count++;
				 	}else{
				 	   count = 1;
				 	}
				 	if(count>=5){
						return count;
					}
			 	}
			 	oldColor = curColor;
			 	stepY++;
				stepX--;
		 }
	}
	
	//斜向扫描中间-右下
	count = 0;	
	for(var col = 0;col<chessboard.cols;col++){					
		curColor = -1;
		oldColor = -1;	
		var stepX = 0;
		var stepY = chessboard.cols-1;
		for(var i = 0 ;i <=col ;i++){
			 	var cell =$(board.find("div[row="+stepY+"][col="+stepX+"]"));
			 	curColor = cell.attr("chessPieceColor");
			 	if(curColor!="none"){
				 	if(curColor==oldColor){
				 		count++;
				 	}else{
				 	   count = 1;
				 	}				 	
				 	if(count>=5){
						return count;
					}				
			 	}
			 	oldColor = curColor;			 	
			 	stepY--;
				stepX++;
		 }
	}	
	
	
	//斜向扫描左下-中间
	count = 0;	
	for(var col = 0;col<chessboard.cols;col++){					
		curColor = -1;
		oldColor = -1;	
		var stepX = col;
		var stepY = chessboard.cols-1;
		for(var i = 0 ;i <=col ;i++){
			 	var cell =$(board.find("div[row="+stepY+"][col="+stepX+"]"));
			 	curColor = cell.attr("chessPieceColor");
			 	if(curColor!="none"){
				 	if(curColor==oldColor){
				 		count++;
				 	}else{
				 	   count = 1;
				 	}
				 	if(count>=5){
						return count;
					}
			 	}
			 	oldColor = curColor;
			 	stepY--;
				stepX--;
		 }
	}
	
	//斜向扫描中间-右上
	count = 0;	
	for(var col = 0;col<chessboard.cols;col++){					
		curColor = -1;
		oldColor = -1;	
		var stepX = col;
		var stepY = 0;
		for(var i = 0 ;i <chessboard.cols-col ;i++){
			 	var cell =$(board.find("div[row="+stepY+"][col="+stepX+"]"));
			 	curColor = cell.attr("chessPieceColor");
			 	if(curColor!="none"){
				 	if(curColor==oldColor){
				 		count++;
				 	}else{
				 	   count = 1;
				 	}
				 	if(count>=5){
						return count;
					}
			 	}
			 	oldColor = curColor;
			 	stepY++;
				stepX++;
		 }
	}
	return 0;
}