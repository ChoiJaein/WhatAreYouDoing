<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
	<title>로그인</title>
	<%@ include file="../module/head.jsp" %>  
	
	<style type="text/css">
	
		.mainlogo {
		width: auto;
		height: auto;
		margin: 100px auto 0px;
		display: block;
		}   
		
		.login-box {
		margin:auto;
		background-color: rgba(250, 237, 197, 0.5);
		border-radius: 10px;
		padding:20px 30px;
		width:460px;
		}
		
		.text-button {
		color: gray;
		margin-top: 5px;
		}
		
		.form-control {
		height: 45px;
		}
	 
		.kakao-button {
		border: none;
		padding: 0;
		margin-right: 0.5rem;
		width: 200px;
		}
	</style>
</head>


<body>
	<header class="mb-3">
		<div class="center-block">
			<img id="previewImg" class="mainlogo" alt="mainlogo" src="./static/img/mainlogo.png">     
		</div>
	</header>
	
	
	<c:url var="mainUrl" value="." />
	<section class="container" style="width: 480px;">
		<c:url var="loginUrl" value="/login" />
		<form action="${loginUrl}" method="post" name ="loginForm">
		
		<br><br>
		
		<input type="hidden" name="url" value="${param.url}">
		<div class="login-box">
			<div class="d-grid gap-2">
				<input class="form-control" type="text" name="userId" value="" placeholder="아이디">
				<input class="form-control" type="password" name="userPw" value="" placeholder="비밀번호">
			</div>
		</div>
		
		<div class="text-button">
			<div class="d-grid gap-3 d-md-flex justify-content-md-end">
				<div onclick="location.href='./findIdPw'" style="cursor:pointer">아이디/비밀번호 찾기</div>
				<div onclick="location.href='./register'" style="cursor:pointer">회원가입</div>
			</div>
		</div>
		
		<br>
		
		<div class="d-grid gap-2 mx-auto">
			<button class="btn btn-outline-secondary" type="submit">로그인</button>
		</div>
		</form>
		
		<br>
		<br>
		<br>
		
	        <div align= 'center' style="display: inline-flex;">
	         <!-- 카카오 로그인 -->
		        <button class="kakao-button" onclick="kakaoLogin();">
		        <a href="javascript:void(0)">
		            <span><img src="//k.kakaocdn.net/14/dn/btqCn0WEmI3/nijroPfbpCa4at5EIsjyf0/o.jpg" width="210"" alt="카카오계정 로그인" style="height: 50px;"/></span>
		        </a>
		  	   </button>
		  	   
		       <!-- 
		       <button onclick="kakaoLogout();">
		        <a href="javascript:void(0)">
		            <span>카카오 로그아웃</span>
		        </a>
		  	   </button>
		        -->
		  <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
		  <script type="text/javascript">
		  Kakao.init('d0ef6b76e117277cb82e82d03cff8759'); 
		  console.log(Kakao.isInitialized()); 
		  //카카오로그인
		  function kakaoLogin() {
		      Kakao.Auth.login({
		    	  scope: 'profile_nickname, account_email, gender',
		        success: function (response) {
		          Kakao.API.request({
		            url: '/v2/user/me',
		            success: function (response) {
		          	  console.log(response)
		          	  alert("로그인 성공 !");
		            },
		            fail: function (error) {
		              console.log(error)
		            },
		          })
		        },
		        fail: function (error) {
		          console.log(error)
		        },
		      })
		    }
		  //카카오로그아웃 
		  function kakaoLogout() {
		      if (Kakao.Auth.getAccessToken()) {
		        Kakao.API.request({
		          url: '/v1/user/unlink',
		          success: function (response) {
		          	console.log(response)
		          },
		          fail: function (error) {
		            console.log(error)
		          },
		        })
		        Kakao.Auth.setAccessToken(undefined)
		      }
		    }  
            </script>
			<!-- 네이버 로그인 -->
			<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>		  
		    <div id ="naverIdLogin" style="margin-left: 1rem"></div>
		    </div>
		   <script type="text/javascript">
		      var naverLogin  = new naver.LoginWithNaverId(
				   {
					   clientId : "q379z6OiAG3HfRfviHRi",
					   callbackUrl : "http://localhost/home/",
					   isPopup: false,
					   loginButton : {color: "green" ,type:3 , height:50}
				   }
		         );
		   
		     naverLogin.init();
           </script>
	  </section>
    </body>
</html>