<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>login</title>
<style>
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
		
.button:hover {
		background-color: #e7e7e7;
		}
			
.center{
    	margin-top:300px;
    }
    
     	#register,#forgetPassword
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
	    #register_over,#forgetPassword_over
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
	    
	    
	 a{
     	color:#666; font-size:15px;
     }
</style>
<script src="<%=request.getContextPath() %>/js/jquery-3.2.1.js"></script>
<script  language="javascript">

		$(document).ready(function(){
			var hiddenInput = document.getElementById("hiddenInput").value;
			if(null==hiddenInput||""==hiddenInput){
				
			}else if("incompleteValues"==hiddenInput){
				alert("请将输入框的值输入完整");
			}else if("loginFailure"==hiddenInput){
				alert("登入失败");
			}else if("Non-existent"==hiddenInput){
				alert("没有该账号");
			}
		})	
		
		function addUser(){
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
						registeredAccount_hide();
					}else if(result="fail"){
						alert("该账号已存在,请重新添加");
						registeredAccount_hide();
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
		
		
		
		function registeredAccount()  
		{  
			register.style.display = "block";  
			register_over.style.display = "block";
		}  
		function registeredAccount_hide()  
		{  
			register.style.display = "none";  
			register_over.style.display = "none";  
		} 
		
		
		function forgetThePassword()  
		{  
			var account = document.getElementById("account").value;
			if(account==""){
				alert("请先输入账号,如若不记得自己的账号,就去注册吧");
				username.focus();
				return;
			}else{
				$.ajax({
					type: "get",  // 请求方式(post或get)
					async:false,  //默认true(异步请求),设置为false(同步请求)
					url:"<%=request.getContextPath() %>/forgetThePassword",
					scriptCharset: 'utf-8',
					data:{"account":account},
					dataType:'json',
					success:function(value){
						if(value !="null"){	
							$("#append").empty();
							add="该账号的密码:<input type='text' class='input' value="+value+"><br/><br/>"+
								"请输入新密码:<input type='password' class='input' name='password' /><br/><br/>";
							$("#append").append(add);
							$("#hidden").val(account);
							forgetPassword.style.display = "block";  
							forgetPassword_over.style.display = "block";
						}else{
							alert("没有该账号");
							return;	
						}
					},error:function(XMLHttpRequest, textStatus, errorThrown){
						alert(XMLHttpRequest.status);
						alert(XMLHttpRequest.readyState);
						alert(textStatus);
			        }
				});
			}
		}  
		function forgetThePassword_hide()  
		{  
			forgetPassword.style.display = "none";  
			forgetPassword_over.style.display = "none";  
		} 
		
</script>
</head>
<body>

	<input type="hidden" id="hiddenInput" name="hidden" value="${value}" />
	<div class="center" style="font-size:22px">
		<center>
			<form action="<%=request.getContextPath() %>/login">
			userName:
				<input type="text" name="account" id="account" class="input" placeholder="请输入用户名">
				<a href="javascript:void(0)" onclick="registeredAccount()">注册账号</a>
				<br/>
				<br/>
			passWord:
				<input type="password" name="password" id="password" class="input" placeholder="请输入密码"/>
				<a href="javascript:void(0)" onclick="forgetThePassword()">忘记密码</a>
				<br/>
				<input type="submit" value="登 录" class="button"/> <input type="reset" value="重 置" class="button"/>
			</form>
		</center>
	</div>
			<div id="register"> 
			  	<div align="right"> 
			      <input type="button" class="button" onclick="registeredAccount_hide()" value="退出注册" />
			    </div> 
			  	<div align="center">
			  		<form>
			  			用户姓名：<input type="text" name="userName" id="registerUserName" placeholder="请输入用户真实姓名" class="input" value="刘聪"/><br/><br/>
			  			用户账号：<input type="text" name="account" id="registerAccount" placeholder="请自己输入一个账号" class="input" value="lc"/><br/><br/>
			  			用户密码：<input type="password" name="afterPassword" id="afterPassword" placeholder="请给你的账号设置一个密码" class="input" value="123"/><br/><br/>
			  			确认密码：<input type="password" name="beginPassword" id="beginPassword" placeholder="请确认你输入的密码" class="input"  value="123" /><br/>
			  			<input type="button" onclick="addUser()" class="button" value="一键注册"/><input type="reset" value="重 置" class="button"/>
			   		</form>
			   	</div>  
			</div>  
			<div id="register_over"></div>
	
			<div id="forgetPassword"> 
			  	<div align="right"> 
			      <input type="button" class="button" onclick="forgetThePassword_hide()" value="退出" />
			    </div> 
			    <center>
				    <form action="<%=request.getContextPath() %>/updatePassword">
				    	<input type="hidden" id="hidden" name="account"/><br/>
					    <div id="append">
					    </div>
					    <input type='submit' value='执行找回' class='button'/> <input type='reset' value='重 置' class='button'/>
				    </form>
			    </center>
			</div>  
			<div id="forgetPassword_over"></div>
</body>
</html> 