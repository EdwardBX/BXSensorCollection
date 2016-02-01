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
	<link rel="stylesheet" href="css/jquery-ui.min.css">
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/highstock.js"></script>
	<script src="js/raphael-2.1.4.min.js"></script>
	<script src="js/justgage.js"></script>
	<script src="js/jquery-ui.min.js"></script>
	<script src="js/RGraph.common.core.js" ></script>  
	<script src="js/RGraph.common.dynamic.js" ></script>  
	<script src="js/RGraph.gauge.js" ></script>  
	<script>
	</script>
	<style type="text/css"> 
	.div{border:1px solid #D1E1F4} 
	.div{font-family:"方正姚体"}
	</style>
</head>  
	<body>
	<div id="container" class="div"></div>
	<script type="text/javascript">
		$.ajax({
			type:"GET",
			url:"initdayAction",
			dataType:"json",
			success: function(data){
				var dust=new Array();
				for(var i=0;i<data.length;i++){
					var arr1=new Array();
					arr1[0]= parseInt(data[i].time);
					arr1[1]=Number(data[i].dust);
					dust[i]=arr1;
				}	
			var chart = new Highcharts.StockChart({
				    chart: {
				        renderTo: 'container'//指向的div的id属性
				    },
				    exporting: {  
			            enabled: false //是否能导出趋势图图片
			        }, 
					title : {
							text : '灰尘度传感器',//图表标题
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
								return vDate.getFullYear()+"-"+(vDate.getMonth()+1)+"-"+(vDate.getDate()-1);
							},
							align: 'center'
						}
				    },
				    yAxis : {  
			                  
			              title: {  
			                  text: '灰尘度（dust）'  //y轴上的标题
			              }  
			         },  
					tooltip: {
			            xDateFormat: '%Y/%m/%d %H：%M：%S'//鼠标移动到趋势线上时显示的日期格式
			        },
				    rangeSelector: {
						buttons: [{//定义一组buttons,下标从0开始
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
					}, {
						type: 'all',
						text: '全部'
					}],
						selected: 6//表示以上定义button的index,从0开始
				    },
				    
				    series: [{
				        name: '灰尘（ug/m³）',//鼠标移到趋势线上时显示的属性名
				        data: dust//属性值
				    }]
				});
			}
		});
	</script>
</html>  
