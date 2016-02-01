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
	
	<style type="text/css"> 
	.div{border:1px solid #D1E1F4} 
	.div{font-family:"方正姚体"}
	</style>
	<script>
	        $(document).ready(function () {
            var currentPosition = 0;
            var slideWidth = 920;
            var slides = $('.slide');
            var numberOfSlides = slides.length;

            // Remove scrollbar in JS
            $('#slidesContainer').css('overflow', 'hidden');

            // Wrap all .slides with #slideInner div
            slides
                    .wrapAll('<div id="slideInner"></div>')
                // Float left to display horizontally, readjust .slides width
                    .css({
                        'float': 'left',
                        'width': slideWidth
                    });

            // Set #slideInner width equal to total width of all slides
            $('#slideInner').css('width', slideWidth * numberOfSlides);

            // Insert controls in the DOM
            $('#slideshow')
                    .prepend('<span class="control" id="leftControl">Clicking moves left</span>')
                    .append('<span class="control" id="rightControl">Clicking moves right</span>');

            // Hide left arrow control on first load
            manageControls(currentPosition);

            // Create event listeners for .controls clicks
            $('.control')
                    .bind('click', function () {
                        // Determine new position
                        currentPosition = ($(this).attr('id') == 'rightControl') ? currentPosition + 1 : currentPosition - 1;

                        // Hide / show controls
                        manageControls(currentPosition);
                        // Move slideInner using margin-left
                        $('#slideInner').animate({
                            'marginLeft': slideWidth * (-currentPosition)
                        });
                    });

            // manageControls: Hides and Shows controls depending on currentPosition
            function manageControls(position) {
                // Hide left arrow if position is first slide
                if (position == 0) {
                    $('#leftControl').hide()
                } else {
                    $('#leftControl').show()
                }
                // Hide right arrow if position is last slide
                if (position == numberOfSlides - 1) {
                    $('#rightControl').hide()
                } else {
                    $('#rightControl').show()
                }
            }

            $('#navbody').find('li').hover(
                    function () {
                        //show its submenu
                        $('ul', this).stop().slideDown(100);

                    },
                    function () {
                        //hide its submenu
                        $('ul', this).stop().slideUp(100);
                    }
            );
        });
	</script>
</head>  
	<body>
		<div id="nav">
			<ul id="navbody"> 
				<li><a href="http://localhost:8080/sensor/index.jsp" target="iframe_a">首页</a></li> 
				<li><a href="http://localhost:8080/sensor/gauge.jsp" target="iframe_a">当前</a></li> 
				<li><a href="http://localhost:8080/sensor/total.jsp" target="iframe_a">总览</a></li>
				<li><a href="http://localhost:8080/sensor/temp.jsp" target="iframe_a">分览</a>
					<ul> 
						<li><a href="http://localhost:8080/sensor/temp.jsp" target="iframe_a">温度</a></li> 
						<li><a href="http://localhost:8080/sensor/humi.jsp" target="iframe_a">湿度</a></li> 
						<li><a href="http://localhost:8080/sensor/dust.jsp" target="iframe_a">灰尘度</a></li>
						<!-- <li><a href="http://localhost:8080/sensor/gas.jsp" target="iframe_a">可燃气体</a></li>  -->
						<li><a href="http://localhost:8080/sensor/beam.jsp" target="iframe_a">光照</a></li> 
					</ul> 
				</li> 
			</ul> 
		</div>
		<br>
		  <iframe width="100%" height="88%" scrolling="no" frameborder="0" src="http://localhost:8080/sensor/gauge.jsp" name="iframe_a" ></iframe>
 </body>
  
</html>  
