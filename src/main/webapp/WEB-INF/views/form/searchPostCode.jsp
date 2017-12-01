<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:url var="css" value="/resources/css/" />
<c:url var="js" value="/resources/js/" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${css}searchPostCode.css">
<script src="${js }searchPostCode.js"></script>
</head>
<div class="graybox" style="line-height:220%">
    <div id="ex2_postcodify" class="postcodify_search_form postcode_search_form"><div class="postcodify_search_controls postcode_search_controls"><label for="postcodify_15112608064594652" style="display: none;">검색 키워드</label><input type="text" class="keyword" value="" id="postcodify_15112608064594652" style="width: 550px;"><button type="button" class="search_button" id="postcodify_15112608064594652_button">검색</button></div></div>
    <label for="ex2_input06">우편번호</label>
    <input type="text" id="ex2_input0" class="example_pcfull" value="">
    <br>
    <label for="ex2_input1">도로명주소</label>
    <input type="text" id="ex2_input1" class="example_input" value="" style="width: 550px;">
    <br>
    <label for="ex2_input2">상세주소</label>
    <input type="text" id="ex2_input2" class="example_input" value="" style="width: 550px;">
    <br>
    <label for="ex2_input3">참고항목</label>
    <input type="text" id="ex2_input3" class="example_input" value="" style="width: 550px;">
    <br>
    <label for="ex2_input4">지번주소</label>
    <input type="text" id="ex2_input4" class="example_input" value="" style="width: 550px;">
    <br>
    <label for="ex2_input5">영문주소</label>
    <input type="text" id="ex2_input5" class="example_input" value="" style="width: 550px;">
    <br>
</div>
<script type="text/javascript">
    $(function() { $("#ex2_postcodify").postcodify({
        insertPostcode5 : "#ex2_input0",
        insertAddress : "#ex2_input1",
        insertDetails : "#ex2_input2",
        insertExtraInfo : "#ex2_input3",
        insertJibeonAddress : "#ex2_input4",
        insertEnglishAddress : "#ex2_input5",
        hideOldAddresses : false,
        forceDisplayPostcode5 : true,
        focusKeyword : false,
        afterSelect : function() {
            $("#ex2_postcodify").find(".postcodify_search_result,.postcodify_search_status").remove();
        },
        onReady: function() {
            $("#guide_content div.section input.keyword").each(function() {
                $(this).width($(this).parents("div.section").width() - 130);
            });
        }
    }); });
</script>
</html>
