<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<c:url var="img" value="/resources/img/" />
<c:url var="css" value="/resources/css/" />
<link rel="stylesheet" href="${css }main.css" >
		<div class="fade">
			<div style="align:center; margin-left:300px; margin-right: 0px;">
			<img alt="메인" src="${img }mainpage.png" width="90%" height="394px">
			</div>
		</div>
		<div style="height: 500px; padding: 5px, 17px, 13px, 0px; margin-top: 100px; margin-left: 300px;">
			<div style="background-color: #e71d36; color: #FFFFFF; width: 350px; float: left; margin-top: 2px; margin-right: 15px; margin-bottom: 2px; margin-left: 0px;" >
				<ul class="list">
					<li class="a"><a href="">게시글1</a></li>
					<li class="a"><a href="">게시글2</a></li>
					<li class="a"><a href="">게시글3</a></li>
					<li class="a"><a href="">게시글4</a></li>
				</ul>
			</div>
			<div style="background-color: #2ec4b6; color: #FFFFFF; display: block; width: 350px; float: left; margin-top: 2px; margin-right: 15px; margin-bottom: 2px; margin-left: 0px;">
				<ul class="list2">
					<li class="a"><a href="">게시글1</a></li>
					<li class="a"><a href="">게시글2</a></li>
					<li class="a"><a href="">게시글3</a></li>
					<li class="a"><a href="">게시글4</a></li>
				</ul>
			</div>
			<div style="background-color: #011627;  display: block; width: 350px; float: left; margin-top: 2px; margin-right: 15px; margin-bottom: 2px; margin-left: 0px;">
				<ul class="list3">
					<li class="a" style="font-color: #FFFFFF;"><a href="">게시글1</a></li>
					<li class="a" style="font-color: #FFFFFF;"><a href="">게시글2</a></li>
					<li class="a" style="font-color: #FFFFFF;"><a href="">게시글3</a></li>
					<li class="a" style="font-color: #FFFFFF;"><a href="">게시글4</a></li>
				</ul>
			</div>
		</div>