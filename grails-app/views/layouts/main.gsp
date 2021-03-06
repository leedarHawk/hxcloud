<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="Grails"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="shortcut icon" href="${assetPath(src: 'favicon.ico')}" type="image/x-icon">
		<link rel="apple-touch-icon" href="${assetPath(src: 'apple-touch-icon.png')}">
		<link rel="apple-touch-icon" sizes="114x114" href="${assetPath(src: 'apple-touch-icon-retina.png')}">
  		<asset:stylesheet src="application.css"/>
		<asset:javascript src="application.js"/>
		<g:layoutHead/>
	</head>
	<body>
		<div class="">
			<div class="header">
				<div class="logo fl"><a href="index.html"><img src="${request.getContextPath()}/images/logo.png" /></a></div>
			</div>
			<div class="navbar-default sidebar" role="navigation">
				<div class="sidebar-nav navbar-collapse">
					<ul class="nav" id="side-menu">
						<li>
							<a href="index.html"><i class="fa fa-dashboard fa-fw"></i> 首页</a>

						</li>
						<li>
							<a href=""><i class="fa fa-dashboard fa-fw"></i> 用户<span class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li>
									<a href="flot.html">完善用户信息</a>
								</li>
								<li>
									<a href="morris.html">修改密码</a>
								</li>
							</ul>
						</li>
						<li>
							<a href="#"><i class="fa fa-bar-chart-o fa-fw"></i> 产品<span class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li>
									<a href="flot.html">添加产品</a>
								</li>
								<li>
									<a href="morris.html">添加产品属性</a>
								</li>
							</ul>
							<!-- /.nav-second-level -->
						</li>
						<li>
							<a href="tables.html"><i class="fa fa-table fa-fw"></i> 订单</a>
						</li>

					</ul>
				</div>
				<!-- /.sidebar-collapse -->
			</div>
			<div id="page-wrapper">
			<g:layoutBody/>
				</div>
			<div class="copy">Copyright © 2016 北京华信信通科技发展有限公司  版权所有  京ICP备112334421号</div>
		</div>
	</body>
</html>
