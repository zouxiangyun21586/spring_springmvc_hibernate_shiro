<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
  <%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Insert title here</title>
	<style type="text/css">
	.button{
					background-color: white;
				    color: black;
				    border: 2px solid #e7e7e7;
				    background-color: #4CAF50; 
				    border: none;
				    color: white;
				    padding: 5px 15px;
				    text-align: center;
				    text-decoration: none;
				    display: inline-block;
				    font-size: 10px;
				    margin: 10px 20px;
				    -webkit-transition-duration: 0.4s; 
				    transition-duration: 0.4s;
				    cursor: pointer;
				    border-radius: 12px;
				} 
	.button:hover {
			background-color: #e7e7e7;
			}
			
			
			
	.input{
            border: 1px solid #ccc;
            padding: 10px 0px;
            border-radius: 3px;
            padding-left:5px;
            -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
            box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
            -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
            -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
            transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s
          }
	.input:focus{
			        border-color: #66afe9;
			        outline: 0;
			        -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(102,175,233,.6);
			        box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(102,175,233,.6)
				}		
	
	table{
			border-collapse:collapse;
			width:100%;
		}
	th{
		  background-color:#C0C0C0;
		  color:white;
		  height:30px;
		  width:100px;	
	  }
	td{
	  	text-align:center;
	  	font-size: 20px;
	  }
	    #add,#update
	    {  
	        display:none;  
	        height:40%;  
	        width:25%;  
	        position:absolute;/*让节点脱离文档流,我的理解就是,从页面上浮出来,不再按照文档其它内容布局*/  
	        top:24%;/*节点脱离了文档流,如果设置位置需要用top和left,right,bottom定位*/  
	        left:40%;  
	        z-index:2;/*个人理解为层级关系,由于这个节点要在顶部显示,所以这个值比其余节点的都大*/  
	        background: white;  
	    }  
	    #add_over,#update_over
	    {  
	        width: 100%;  
	        height: 100%;  
	        opacity:0.8;/*设置背景色透明度,1为完全不透明,IE需要使用filter:alpha(opacity=80);*/  
	        filter:alpha(opacity=80);  
	        display: none;  
	        position:absolute;  
	        top:0;  
	        left:0;  
	        z-index:1;  
	        background: silver;  
	    }  
	</style>
	</head>
	<body>
		<input type="button" onclick="addUser()" class="button" value="添加用户"/>
		<a href="shiro-logout">注销</a>
		登入账号: <shiro:principal />
		<div align="center">
			<table>
				<tr>
					<th>编号</th>
					<th>用户</th>
					<th>账号</th>
					<th>角色</th>
					<th>操作</th>
				</tr>
				<tbody id="user"></tbody>
			</table>
			<div>
			
			总记录数：<span id="pageSizeCountId"></span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			总页数：<span id="pageCountId"></span>       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			当前页：<span id="pageId"></span>   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="javascript:void(0)" onclick="init(1)">首页</a>
			<a href="javascript:void(0)" onclick="init(2)" id="shang">上页</a>
			<a href="javascript:void(0)" onclick="init(3)" id="xia">下页</a>
			<a href="javascript:void(0)" onclick="init(4)">尾页</a>
			<select id="pageSizeId" onchange="init(5)">
				<option value="5">5</option>
				<option value="10">10</option>
				<option value="15">15</option>
				<option value="20">20</option>
			</select>
		</div>
		</div>
		<div id="add"> 
		  	<div align="right"> 
		      <input type="button" class="button" onclick="add_hide()" value="退出添加" />
		    </div> 
	    	<div align="center">
	    		<form>
    				用户姓名：<input type="text" name="userName" id="registerUserName" placeholder="请输入用户真实姓名" class="input" /><br/><br/>
		  			用户账号：<input type="text" name="account" id="registerAccount" placeholder="请自己输入一个账号" class="input"/><br/><br/>
		  			用户密码：<input type="password" name="afterPassword" id="afterPassword" placeholder="请给你的账号设置一个密码" class="input"/><br/><br/>
		  			确认密码：<input type="password" name="beginPassword" id="beginPassword" placeholder="请确认你输入的密码" class="input"  /><br/>
		  			<input type="button" onclick="adduser()" class="button" value="添加"/><input type="reset" value="重 置" class="button"/>
	    		</form>
	    	</div>  
		</div>  
		<div id="add_over"></div>
		
		<div id="update"> 
		  	<div align="right"> 
		      <input type="button" class="button" onclick="update_hide()" value="取消修改" />
		    </div> 
	    	<div align="center">
	    		<center><h4>修改用户</h4></center>
	    		<form action="<%=request.getContextPath() %>/user"  method="POST">
	    			<input type="hidden" name="_method" value="PUT"/><br/>
	    			<input type="hidden" name="id" id="echoHidden"/>
    				用户姓名：<input type="text" name="userName" id="echoUserName" placeholder="请输入用户真实姓名" class="input" /><br/><br/>
		  			用户账号：<input type="text" name="account" id="echoAccount" placeholder="请自己输入一个账号" class="input"/><br/><br/>
		  			<input type="submit" class="button" value="保存修改"/><input type="reset" value="重 置" class="button"/>
	    		</form>
	    	</div>  
		</div>  
		<div id="update_over"></div>
	</body>
	<script src="<%=request.getContextPath() %>/js/jquery-3.2.1.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			init();
		})
		function init(mark){
			var pageSize = "";
			var page = "";
			if(mark == 1)
			{
				pageSize = $("#pageSizeId").val();
				page = 1;
			}else if(mark == 2)
			{
				pageSize = $("#pageSizeId").val();
				var pageCount = $("#pageId").text();
				page = (parseInt(pageCount)-1);
				
			}else if(mark == 3)
			{
				pageSize = $("#pageSizeId").val();
				var pageCount = $("#pageId").text();
				page = (parseInt(pageCount)+1);
			}else if(mark == 4)
			{
				pageSize = $("#pageSizeId").val();
				page = $("#pageCountId").text();
			}else if(mark == 5)
			{
				pageSize = $("#pageSizeId").val();
				page = 1;
			}
			$.ajax({
				type: "get",  // 请求方式(post或get)
				async:false,  //默认true(异步请求),设置为false(同步请求)
				url:"<%=request.getContextPath() %>/user",
				scriptCharset: 'utf-8',
				data:{pageSize:pageSize,page:page},
				dataType:'json',
				success:function(a){
					$("#user").empty();
					var userJson = eval("("+a+")");
					var list=userJson.t;
					var user = "";
					$("#pageSizeCountId").text(userJson.pageSizeCount);
					$("#pageCountId").text(userJson.pageCount);
					$("#pageId").text(userJson.page);
					$("#pageSizeId").val(userJson.pageSize);
					
				 	if(userJson.page == 1)
					{
						$("#shang").hide();
					}else
					{
						$("#shang").show();
					}
					if(userJson.page == userJson.pageCount)
					{
						$("#xia").hide();
					}
					else
					{
						$("#xia").show();
					}
					for(var i in list){
						user += "<tr><td>"+list[i].id+"</td>"+
					 			"<td>"+list[i].userName+"</td>"+
					 			"<td>"+list[i].account+"</td>"+
					 			"<td>";
									for(var a = 0;a<list[i].roleSet.length;a++){
			 							user +=list[i].roleSet[a].roleName;
					 					if((a+1) !=list[i].roleSet.length){
					 						user +=",";
					 					}
		 							};
								user +="</td>"+ 
						 		"<td><center><input type='button' onclick='update_user("+list[i].id+")' value='编辑' class='button'>&nbsp;"+
						 		"<input type='button' onclick='userDelete("+list[i].id+")' value='删除' class='button'>&nbsp;"
						 		 "<input type='button' onclick='' value='添加角色' class='button'>&nbsp;"+
						 		"</center></td></tr>" ;
					}
					$("#user").append(user);
				}
			});
		}
		function adduser(){
			var account = document.getElementById("registerAccount").value;
			var userName = document.getElementById("registerUserName").value;
			var afterPassword = document.getElementById("afterPassword").value;
			var beginPassword = document.getElementById("beginPassword").value;
			if (account== "") {
				alert("请输入账号");
				return;
			}else if(userName==""){
				alert("请输入用户名");
				return;
			}else if(afterPassword==""){
				alert("请给你的账号设置密码");
				return;
			}else if(beginPassword==""){
				alert("请确定你的密码");
				return;
			}else if(beginPassword !=afterPassword){
				alert("确认密码出错");
				return;
			}else{
				$.ajax({
				type:"post",  // 请求方式(post或get)
				async:false,  //默认true(异步请求),设置为false(同步请求)
				url:"<%=request.getContextPath() %>/user",
				scriptCharset: 'utf-8',
				data:{
				'account':account,
				'password':beginPassword,
				'userName':userName
				},
				success:function(userJson){
					var result = eval("("+userJson+")");
					if(result=="success"){
						alert("添加成功");
						window.location.reload();
					}else if(result="fail"){
						alert("该账号已存在,请重新添加");
					}
				},
				error:function(XMLHttpRequest, textStatus, errorThrown){
					alert(XMLHttpRequest.status);
					alert(XMLHttpRequest.readyState);
					alert(textStatus);
		        }
			}); 
			
			}			
		}
		
		<%-- 
		function updateuser(){
			var userName = document.getElementById("echoUserName").value;
			var account = document.getElementById("echoAccount").value;
			var userId = document.getElementById("echoHidden").value;
			$.ajax({
				type:"post",  // 请求方式(post或get)
				async:false,  //默认true(异步请求),设置为false(同步请求)
				url:"<%=request.getContextPath() %>/user",
				scriptCharset: 'utf-8',
				data:{
				_method : "PUT",
				"userName":userName,
				"account":account,
				"userId":userId
				},
				success:function(userJson){
					
					
				},
				error:function(XMLHttpRequest, textStatus, errorThrown){
					alert(XMLHttpRequest.status);
					alert(XMLHttpRequest.readyState);
					alert(textStatus);
		        }
			}); 
		} --%>
		
		function userDelete(userId){
			if(confirm("确认删除吗?")){
				$.ajax({
					type:"post",  // 请求方式(post或get)
					async:false,  //默认true(异步请求),设置为false(同步请求)
					url:"<%=request.getContextPath() %>/user",
					scriptCharset: 'utf-8',
					data:{
					_method : "DELETE",
					'userId':userId,
					},
					success:function(userJson){
						var result = eval("("+userJson+")");
						if(result=="deleteSuccess"){
							alert("删除成功");
							window.location.reload();
						}else if("null"){
							window.location.replace("/jsp/login.jsp");
						}
					},
					error:function(XMLHttpRequest, textStatus, errorThrown){
						alert(XMLHttpRequest.status);
						alert(XMLHttpRequest.readyState);
						alert(textStatus);
			        }
				});
			}
		}
		
		
			function echo(userId){
				$.ajax({
					type:"post",  // 请求方式(post或get)
					async:false,  //默认true(异步请求),设置为false(同步请求)
					url:"<%=request.getContextPath() %>/queryToId",
					scriptCharset: 'utf-8',
					data:{
					'userId':userId,
					},
					dataType:'json',
					success:function(userJson){
						var result = eval("("+userJson+")");
						$("#echoUserName").val(result.userName);
						$("#echoAccount").val(result.account);
						$("#echoHidden").val(userId);
					},
					error:function(XMLHttpRequest, textStatus, errorThrown){
						alert(XMLHttpRequest.status);
						alert(XMLHttpRequest.readyState);
						alert(textStatus);
						window.location.reload();
			        }
				}); 
				
			}
		
			var add = document.getElementById('add');
			var add_over = document.getElementById('add_over'); 
			function addUser()  
			{  
				add.style.display = "block";  
				add_over.style.display = "block";
			}  
			function add_hide()  
			{  
				add.style.display = "none";  
				add_over.style.display = "none";  
			} 
			
			
			var update = document.getElementById('update');
			var update_over = document.getElementById('update_over'); 
			function update_user(id)  
			{  
				echo(id);
				update.style.display = "block";  
				update_over.style.display = "block";
			}  
			function update_hide()  
			{  
				update.style.display = "none";  
				update_over.style.display = "none";  
			} 
	</script>
</html>