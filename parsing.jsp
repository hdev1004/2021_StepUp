<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.w3c.dom.*"%>
<%@ page import="javax.xml.parsers.*" %>
<%@ page import="java.util.*" %>    
    
<%
//map을 담을 리스트 만들기
List<Map> pubList = new ArrayList();

//xml 데이터 호출하기
String url = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic?serviceKey=tcxFOnkwx%2FY%2Bx1N38JCOXpS3ITqYOdiM%2FwnC%2B6slZFJtnPkOXjyOKnnNLaxlHgdEO4tMJcHbO7bTX%2BETC0hTKA%3D%3D&bgnde=20200501&endde=20210630&upkind=417000&state=notice&pageNo=1&numOfRows=10&neuter_yn=Y";
DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
DocumentBuilder builder = factory.newDocumentBuilder();
Document document = builder.parse(url);
NodeList items = document.getElementsByTagName("item");

String[] elements = {"popfile", "noticeNo", "kindCd", "colorCd", "weight", "sexCd", "happenPlace", "noticeEdt", "noticeSdt"};

for(int i=0; i < items.getLength(); i++) {
	Node n = items.item(i);
	Element e = (Element) n;
	
	Map<String, String> pub = new HashMap<String, String>();
	//child를 기준으로 for문 만들기
	for(String element : elements) {
		NodeList titleList = e.getElementsByTagName(element);
		Element titleElement = (Element)titleList.item(0);
		Node titleNode = titleElement.getChildNodes().item(0);
		pub.put(element, titleNode.getNodeValue());
	}
	//리스트에 map 담기
	//out.print(pub);
	pubList.add(pub);
}

%>  

<%!
//쉼표 추가를 위한 메소드 선언
DecimalFormat df = new DecimalFormat("#,##0");
public String myFormat(String str) {
	return df.format( Long.parseLong(str) );
}
%>  

<!DOCTYPE html>
<html>
<head>
 	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <style>
    
    	div.cards {
            position: relative;
    		width:450px;
    		height:200px;
            border: 1px solid black;
    		
    	}
    	
    	div.cards_img {
            position: absolute;
    		width: 120px;
    		height: 120px;
            left: 20px;
            top: 40px;
            border: 1px solid black;
    	}

        div.cards_txt {
            position: absolute;
            left: 170px;
            top: 33px;
        }

        div.cards_txt span:nth-child(1) {
            font-weight: bold;
        }

        div.cards_txt span {
            display: block;
            margin-bottom: -13px;
        }
    </style>
</head>

<body>
	<%
	for(int i = 0; i < pubList.size(); i ++) { %>
	<div class="cards">
		<div class="cards_img" style="background: no-repeat url(<%=pubList.get(i).get("popfile")%>); background-size: cover;"></div>
	    <div class="cards_txt">
	        <span><%=pubList.get(i).get("noticeNo")%> </span> <br>
	        <span>품종 > <%=pubList.get(i).get("kindCd")%>, <%=pubList.get(i).get("sexCd")%></span> <br>
	        <span>털색 > <%=pubList.get(i).get("colorCd")%> | 체중 <%=pubList.get(i).get("weight") %></span> <br>
	        <span>발견 > <%=pubList.get(i).get("happenPlace")%></span> <br>
	        <span>공고 > <%=pubList.get(i).get("noticeSdt")%> ~ <%=pubList.get(i).get("noticeEdt")%></span>
	    </div>
	</div>
	 <br>
	<%} %>
	
</body>
</html>