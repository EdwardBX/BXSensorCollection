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
	<base href="<%=basePath%>"> 
	<title>title</title>  
	<link href="css/1.css" rel="stylesheet" type="text/css" />
	<style type="text/css"> 
	.div{border:1px solid #D1E1F4} 
	.div{font-family:"方正姚体"}
	</style>
	<style>
   
    </style>
 
</head>  
	<body>
		<div style="float:left;width: 80%">
			<div style="float:left;width: 50%">
				<div id="container1" style="height: 300px" class="div"></div>
				<div id="container2" style="height: 300px" class="div"></div>
			</div>
			<div style="float:right;width: 50%">
				<div id="container3" style="height: 300px" class="div"></div>
				<div id="container4" style="height: 300px" class="div"></div>
			</div>
		</div>
			<div style="float:right;width: 20%">
			<div id="container5" style="height: 160" class="div"></div>
			<div id="container6" style="height: 160" class="div"></div>
			<div id="container7" style="height: 160" class="div"></div>
			<div id="container8" style="height: 160" class="div"></div>
			</div>
		</body>
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
			var gas=new Array();
			var beam=new Array();
			var num=-1;
			for(var i=0;i<data.length;i++){
				var arr1=new Array();
				var arr2=new Array();
				var arr3=new Array();
				var arr4=new Array();
				var arr5=new Array();
				arr1[0]= parseInt(data[i].time);
				arr1[1]=Number(data[i].temp);
				arr2[0]= parseInt(data[i].time);
				arr2[1]=Number(data[i].humi);
				arr3[0]= parseInt(data[i].time);
				arr3[1]=Number(data[i].dust);
				arr4[0]= parseInt(data[i].time);
				arr4[1]=Number(data[i].gas);
				arr5[0]= parseInt(data[i].time);
				arr5[1]=Number(data[i].beam);
				tem[i]=arr1;
				hum[i]=arr2;
				dust[i]=arr3; 
				gas[i]=arr4; 
				beam[i]=arr5;
				num++;
			}
		var nowtemp = data[num].temp;
		var nowhum = data[num].humi;
		var nowdust = data[num].dust;
		var nowgas = data[num].gas;
		var nowbeam = data[num].beam;
		var view = null;
		if(nowdust>150){
			if(nowdust>300){
				view = "(危害)";
			}else{
				view = "(不健康)";
			}
		}else{
			view = "(良好)";
		}
		var g1 = new JustGage({
          id: "container5",
          value: nowtemp,
          min: -20,
          max: 80,
          title: "当前温度",
          titleFontColor: "black",
          label: "摄氏度℃",
          labelFontColor: "black",
          customSectors: [{
		      color : "#D1E1F4",
		      lo : 0,
		      hi : 32
		    },{
		      color : "yellow" ,
		      lo : 32,
		      hi : 40
		    }, {
		      color : "red",
		      lo : 40,
		      hi : 80
		    }],
        });
        var g2 = new JustGage({
          id: "container6",
          value: nowdust,
          min: 0,
          max: 3000,
          title: "当前灰尘度"+view,
          titleFontColor: "black",
          label: "ug/m³",
          labelFontColor: "black",
          customSectors: [{
		      color : "#D1E1F4",
		      lo : 0,
		      hi : 1000
		    },{
		      color : "yellow" ,
		      lo : 1000,
		      hi : 1500
		    }, {
		      color : "red",
		      lo : 1500,
		      hi : 3000
		    }],
        });
        var g3 = new JustGage({
          id: "container7",
          value: nowhum,
          min: 0,
          max: 100,
          title: "当前湿度",
          titleFontColor: "black",
          label: "%",
          labelFontColor: "black",
          customSectors: [{
		      color : "#D1E1F4",
		      lo : 0,
		      hi : 80
		    },{
		      color : "yellow" ,
		      lo : 80,
		      hi : 90
		    }, {
		      color : "red",
		      lo : 90,
		      hi : 100
		    }], 
        });
        var g4 = new JustGage({
          id: "container8",
          value: nowbeam,
          min: 0,
          max: 100,
          title: "光照强度",
          titleFontColor: "black",
          label: "lx",
          labelFontColor: "black",
          customSectors: [{
		      color : "#D1E1F4",
		      lo : 5,
		      hi : 100
		    },{
		      color : "yellow" ,
		      lo : 1,
		      hi : 5
		    }, {
		      color : "red",
		      lo : 0,
		      hi : 1
		    }],   
        });
		var chart1 = new Highcharts.StockChart({
			    chart: {
			        renderTo: 'container1'//指向的div的id属性
			    },
			    exporting: {  
		            enabled: false //是否能导出趋势图图片
		        }, 
				title : {
						text : '温度传感器',//图表标题
						style:{
							fontFamily:"方正姚体",
							fontSize: '26px'
						}
					},
			    xAxis: {
			    	tickPixelInterval: 200,//x轴上的间隔
				//	title :{
				//		text:"title"
				//	},
					type: 'datetime', //定义x轴上日期的显示格式
					labels: {
						formatter: function() {
							var vDate=new Date(this.value);
							//alert(this.value);
							return (vDate.getHours()+16)%24 + ":" + vDate.getMinutes();
						},
						align: 'center'
					}
			    },
			    yAxis : {  
		                  
		              title: {  
		                  text: '温度（temperature）'  //y轴上的标题
		              }  
		         },  
				tooltip: {
		            xDateFormat: '%Y/%m/%d %H：%M：%S',//鼠标移动到趋势线上时显示的日期格式
		            shared: true
		        },
			    rangeSelector: {
					buttons: [/* {//定义一组buttons,下标从0开始
					type: 'day',
					count: 1,
					text: '一天'
				},{
					type: 'week',
					count: 1,
					text: '一周'
				},{
					type: 'month',
					count: 1,
					text: '一个月'
				}, {
					type: 'month',
					count: 3,
					text: '三个月'
				}, {
					type: 'month',
					count: 6,
					text: '六个月'
				},  {
					type: 'year',
					count: 1,
					text: '一年'
				},  */{
					type: 'all',
					text: '全部'
				}],
					selected: 6//表示以上定义button的index,从0开始
			    },
			    
			    series: [{
			        name: '温度（℃）',//鼠标移到趋势线上时显示的属性名
			        data: tem//属性值
			    }]
			});
			
			var chart2 = new Highcharts.StockChart({
			    chart: {
			        renderTo: 'container2'//指向的div的id属性
			    },
			    exporting: {  
		            enabled: false //是否能导出趋势图图片
		        }, 
				title : {
						text : '湿度传感器',//图表标题
						style:{
							fontFamily:"方正姚体",
							fontSize: '26px'
						}
					},
			    xAxis: {
			    	tickPixelInterval: 200,//x轴上的间隔
				//	title :{
				//		text:"title"
				//	},
					type: 'datetime', //定义x轴上日期的显示格式
					labels: {
						formatter: function() {
							var vDate=new Date(this.value);
							//alert(this.value);
							return (vDate.getHours()+16)%24 + ":" + vDate.getMinutes();
						},
						align: 'center'
					}
			    },
			    yAxis : {  
		                  
		              title: {  
		                  text: '湿度（humidity）'  //y轴上的标题
		              }  
		         },  
				tooltip: {
		            xDateFormat: '%Y/%m/%d %H:%M:%S'//鼠标移动到趋势线上时显示的日期格式
		        },
			    rangeSelector: {
					buttons: [/* {//定义一组buttons,下标从0开始
					type: 'day',
					count: 1,
					text: '一天'
				},{
					type: 'week',
					count: 1,
					text: '一周'
				},{
					type: 'month',
					count: 1,
					text: '一个月'
				}, {
					type: 'month',
					count: 3,
					text: '三个月'
				}, {
					type: 'month',
					count: 6,
					text: '六个月'
				},  {
					type: 'year',
					count: 1,
					text: '一年'
				},  */{
					type: 'all',
					text: '全部'
				}],
					selected: 6//表示以上定义button的index,从0开始
			    },
			    
			    series: [{
			        name: '湿度(%)',//鼠标移到趋势线上时显示的属性名
			        data: hum//属性值
					//marker : {
					//		enabled : true,
					//		radius : 3
					//	},
					//shadow : true
			    }]
			});
			
			var chart3 = new Highcharts.StockChart({
			    chart: {
			        renderTo: 'container3'//指向的div的id属性
			    },
			    exporting: {  
		            enabled: false //是否能导出趋势图图片
		        }, 
				title : {
						text : '灰尘传感器',//图表标题
						style:{
							fontFamily:"方正姚体",
							fontSize: '26px'
						}
					},
			    xAxis: {
			    	tickPixelInterval: 200,//x轴上的间隔
				//	title :{
				//		text:"title"
				//	},
					type: 'datetime', //定义x轴上日期的显示格式
					labels: {
						formatter: function() {
							var vDate=new Date(this.value);
							//alert(this.value);
							return (vDate.getHours()+16)%24 + ":" + vDate.getMinutes();
						},
						align: 'center'
					}
			    },
			    yAxis : {  
		                  
		              title: {  
		                  text: '灰尘（dust）' , //y轴上的标题
		              }  
		         },  
				tooltip: {
		            xDateFormat: '%Y/%m/%d %H:%M:%S'//鼠标移动到趋势线上时显示的日期格式
		        },
			    rangeSelector: {
					buttons: [/* {//定义一组buttons,下标从0开始
					type: 'day',
					count: 1,
					text: '一天'
				},{
					type: 'week',
					count: 1,
					text: '一周'
				},{
					type: 'month',
					count: 1,
					text: '一个月'
				}, {
					type: 'month',
					count: 3,
					text: '三个月'
				}, {
					type: 'month',
					count: 6,
					text: '六个月'
				},  {
					type: 'year',
					count: 1,
					text: '一年'
				}, */ {
					type: 'all',
					text: '全部'
				}],
					selected: 6//表示以上定义button的index,从0开始
			    },
			    
			    series: [{
			        name: '灰尘（ug/m³）',//鼠标移到趋势线上时显示的属性名
			        data: dust//属性值
					//marker : {
					//		enabled : true,
					//		radius : 3
					//	},
					//shadow : true
			    }]
			});
			
			var chart4 = new Highcharts.StockChart({
			    chart: {
			        renderTo: 'container4'//指向的div的id属性
			    },
			    exporting: {  
		            enabled: false //是否能导出趋势图图片
		        }, 
				title : {
						text : '光照传感器',//图表标题
						style:{
							fontFamily:"方正姚体",
							fontSize: '26px'
						}
					},
			    xAxis: {
			    	tickPixelInterval: 200,//x轴上的间隔
				//	title :{
				//		text:"title"
				//	},
					type: 'datetime', //定义x轴上日期的显示格式
					labels: {
						formatter: function() {
							var vDate=new Date(this.value);
							//alert(this.value);
							return (vDate.getHours()+16)%24 + ":" + vDate.getMinutes();
						},
						align: 'center'
					}
			    },
			    yAxis : {  
		                  
		              title: {  
		                  text: '光照强度（lx）'  //y轴上的标题
		              }  
		         },  
				tooltip: {
		            xDateFormat: '%Y/%m/%d %H:%M:%S'//鼠标移动到趋势线上时显示的日期格式
		        },
			    rangeSelector: {
					buttons: [/* {//定义一组buttons,下标从0开始
					type: 'day',
					count: 1,
					text: '一天'
				},{
					type: 'week',
					count: 1,
					text: '一周'
				},{
					type: 'month',
					count: 1,
					text: '一个月'
				}, {
					type: 'month',
					count: 3,
					text: '三个月'
				}, {
					type: 'month',
					count: 6,
					text: '六个月'
				},  {
					type: 'year',
					count: 1,
					text: '一年'
				}, */ {
					type: 'all',
					text: '全部'
				}],
					selected: 6//表示以上定义button的index,从0开始
			    },
			    
			    series: [{
			        name: '光照强度（lx）',//鼠标移到趋势线上时显示的属性名
			        data: beam//属性值
					//marker : {
					//		enabled : true,
					//		radius : 3
					//	},
					//shadow : true
			    }]
			});
		}
	});
	
	function myrefresh()
	{
		window.location.reload();
	}
	setTimeout('myrefresh()',20000);

  </script>
  
</html>  
