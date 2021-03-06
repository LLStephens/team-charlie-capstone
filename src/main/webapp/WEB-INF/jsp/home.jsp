<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 <c:import url="/WEB-INF/jsp/header.jsp" />
 
 <div class="container-fluid alignmid">
		<img  id = "jumbo" src="img/abstract.jpg">	
</div>
<div class = "container-fluid centerText">
<p class = "welcomeText" >Welcome to Neutralspace Personal Healthcare </p>
<c:url var="topDocs" value = "/topDoctors"/>
<a href="${topDocs}">(Visit one of our top rated doctors)</a>
</div>
<div class = "lrPadding" >
 
	<div class="container-fluid">

	</div>
	
	 <div class="container-fluid">
		<c:forEach var="office" items="${officeList}">
	
			<c:url var="detail" value="/offices">
				<c:param name="officeId" value="${office.id}"></c:param>
			</c:url>
		<div class = "col-sm-12 col-md-6 zeros " >
			<div class = "offices">
			<div>
				<c:url var="officePicture" value="img/office/${office.imageName}.jpg" />
				<a href="${detail}" > <img class = "officePic" src="${officePicture}" /></a>
			</div>
			
			<div>
				<h4>
					<a href="${detail}"><c:out value="${office.name}" /> </a>
				</h4>
				<p>
					<c:out value="${office.address}" /><br>
					<c:out value="${office.phoneNumber}" />
				</p>
			</div>
			</div>
		</div>
	
		</c:forEach>
	</div> 
</div>
<c:import url="/WEB-INF/jsp/footer.jsp" />