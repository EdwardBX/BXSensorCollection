<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sd" uri="/struts-dojo-tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>  
<head>  
<link href="css/1.css" rel="stylesheet" type="text/css" /> 
<base href="<%=basePath%>"> 
<title>title</title>  
<style type="text/css"> 
.div{border:1px solid #D1E1F4} 
.div{font-family:"方正姚体"}
</style>
</head>  
	
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/highstock.js"></script>
	<script src="js/raphael-2.1.4.min.js"></script>
	<script src="js/justgage.js"></script>
	<script src="js/RGraph.common.core.js" ></script>  
	<script src="js/RGraph.common.dynamic.js" ></script>  
    <script src="js/RGraph.gauge.js" ></script>  


  <script type="text/javascript">
	$.ajax({
		type:"GET",
		url:"inittemperatureAction",
		dataType:"json",
		success: function(data){
			var tem=new Array();
			var hum=new Array();
			var dust=new Array();
			var beam = new Array();
			var num=-1;
			for(var i=0;i<data.length;i++){
				var arr1=new Array();
				var arr2=new Array();
				var arr3=new Array();
				var arr4=new Array();
				arr1[0]= parseInt(data[i].time);
				arr1[1]=data[i].temp;
				arr2[0]= parseInt(data[i].time);
				arr2[1]=data[i].humi;
				arr3[0]= parseInt(data[i].time);
				arr3[1]=data[i].dust;
				arr4[0]= parseInt(data[i].time);
				arr4[1]=data[i].beam;
				tem[i]=arr1;
				hum[i]=arr2;
				dust[i]=arr3; 
				beam[i]=arr4;
				num++;
			}	
		var nowtemp = parseFloat(Number(data[num].temp).toFixed(2));
		var nowhum = parseFloat(Number(data[num].humi).toFixed(2));
		var nowdust = parseFloat(Number(data[num].dust).toFixed(2));
		var nowbeam = parseFloat(Number(data[num].beam).toFixed(2));

		var gauge1 = new RGraph.Gauge('cvs1', -20, 80, nowtemp);  
            gauge1.Set('chart.scale.decimals', 0);  
            gauge1.Set('chart.tickmarks.small', 50);  
            gauge1.Set('chart.tickmarks.big',5);   
            gauge1.Set('chart.title.bottom', nowtemp+'℃');  
            gauge1.Set('chart.title.bottom.color', '#000');
            gauge1.Set('chart.title.bottom.size', 15); 
            gauge1.Set('chart.colors.ranges', [[32, 40, 'yellow'], [40, 80, 'red']]);    
            gauge1.Draw();              
         
		var gauge2 = new RGraph.Gauge('cvs2', 0, 100, nowhum);  
            gauge2.Set('chart.scale.decimals', 0);  
            gauge2.Set('chart.tickmarks.small', 50);  
            gauge2.Set('chart.tickmarks.big',5);  
            gauge2.Set('chart.title.bottom', nowhum+'%');  
            gauge2.Set('chart.title.bottom.color', '#000');
            gauge2.Set('chart.title.bottom.size', 15); 
            gauge2.Set('chart.colors.ranges', [[80, 90, 'yellow'], [90, 100, 'red']]);    
            gauge2.Draw();              
          
            
		var gauge3 = new RGraph.Gauge('cvs3', 0, 3000, nowdust);  
            gauge3.Set('chart.scale.decimals', 0);  
            gauge3.Set('chart.tickmarks.small', 30);  
            gauge3.Set('chart.tickmarks.big',10);  
            gauge3.Set('chart.title.bottom', nowdust+'ug/m³');  
            gauge3.Set('chart.title.bottom.color', '#000');
            gauge3.Set('chart.title.bottom.size', 15); 
            gauge3.Set('chart.colors.ranges', [[1000, 1500, 'yellow'], [1500,3000, 'red']]);    
            gauge3.Draw();              
           
            
		var gauge4 = new RGraph.Gauge('cvs4', 0, 100, nowbeam);  
            gauge4.Set('chart.scale.decimals', 0);  
            gauge4.Set('chart.tickmarks.small', 50);  
            gauge4.Set('chart.tickmarks.big',10);  
            gauge4.Set('chart.title.bottom', nowbeam+'lx');  
            gauge4.Set('chart.title.bottom.color', '#000');
            gauge4.Set('chart.title.bottom.size', 15); 
            gauge4.Set('chart.colors.ranges', [[1, 5, 'yellow'], [0, 1, 'red']]);    
            gauge4.Draw();              
            
       
		}
	});
	
	function myrefresh()
	{
		window.location.reload();
	}
	setTimeout('myrefresh()',20000);
	
  </script>
  
  <body>

	<div style="float:center">
		<div style="float:left;width: 50%">
			<div style="height: 300px" class="div"><h1>当前温度<h1><canvas id="cvs1" width="250" height="250">[No canvas support]</canvas></div>
			<div style="height: 300px" class="div"><h1>当前湿度<h1><canvas id="cvs2" width="250" height="250">[No canvas support]</canvas></div>
		</div>
		<div style="float:right;width:50%">
			<div style="height: 300px" class="div"><h1>当前灰尘<h1><canvas id="cvs3" width="250" height="250">[No canvas support]</canvas> </div>
			<div style="height: 300px" class="div"><h1>当前光照<h1><canvas id="cvs4" width="250" height="250">[No canvas support]</canvas> </div>
		</div>
	</div>
	</iframe>
	</body>
</html>  
