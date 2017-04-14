<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:import url="/WEB-INF/jsp/header.jsp" />

<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script>
  $( function() {
    $( "#datepicker" ).datepicker();
  } );

  function getDate() {
      document.getElementById("datepicker").val();
  }
  </script>


<p>
	Date: <input type="text" id="datepicker">
</p>
<label id="hoursLabel">Hourly Rate</label>
<input id="hourstTxt" type="text">
<br>
<label id="hoursLabel">placeholder</label>
<input id="hourstTxt" type="text">

<%-- <c:url var ="providerViewrUrl" value="get()">
	<c:param name="date" value="${providerViewUrl}"></c:param>
</c:url> --%>

<c:forEach var="appt" items="${apptTimes}">
	<c:out value="${appt}" />
	<br>
</c:forEach>



<div>

	<div class="container alignmid pageTitle" style="color: green">
		<c:out value="Hello ${doctor.name}" />
	</div>

	<div class="container col-xs-12 col-sm-3 zeros alignmid">
		<div class="col-xs-12 " id="doctorSideBar">
			<img style="width: 150px" class="doctorImg"
				src="img/doctors/${doctor.id}.jpg" />
		</div>

	</div>


	<div class="ol-xs-12 col-sm-9 alignmid ">
		<div>
			<c:out value="today's schedule" />
		</div>
		<!-- enter Schedule items here in a list, click to view appointment data -->
		<div class="col-xs-12 ">
			<c:url var="appointment" value="/doctorsAppointment" />
			<a href="${appointment}">Clickable divs here </a>
			<c:set var="counter" value="0" />
			
			<c:forEach var="index" begin="0" end="${fn:length(agenda)-1}">
			
				<c:choose>
				
					<c:when test="${(!empty apptTimes[counter]) && agenda[index].equals(apptTimes[counter])}">
						<div class="col-xs-12 unavailable" id="doctorViewReview">
								
								
								<c:forEach var = "appt" items = "${apptObj}">		
									<c:if test = "${appt.startTime.equals(apptTimes[counter])}">
										<c:url var = "doctorsAppointment" value = "/doctorsAppointment"> 
											<c:param name = "appt"  value = "${appt}"/>
										</c:url>
									</c:if>	
								</c:forEach> 
								
							<form action = "${ doctorsAppointment }" method = "GET">		
								<button type = "submit" class  = "unavailable" style = "width:100%; height:100%"><c:out value = "${agenda[index]} unavailable"/> </button>
							</form>		
						</div>
						<c:set var="counter" value="${counter + 1}" />
					</c:when>
					
					<c:otherwise>
						<div class="col-xs-12 " id="doctorViewReview">
							<button class = "open" style = "width:100%; height:100%"  >
								<c:out value = "${agenda[index]} - open"/>
							</button>
						</div>
								
					</c:otherwise>
					
				</c:choose>
				
			</c:forEach> 
		</div>
	</div>

	<div class="col-xs-12 alignmid">
		<div>
			<c:out value="Your reviews:" />
		</div>

		<div>
			<c:forEach var="review" items="${review}">
				<!-- 		 		<div class = "col-xs-12 col-sm-4 reviewColor" id = "doctorViewReview"> -->
				<c:out value="${review.message}" />
				<br>
				<c:out value="${review.rating}" />
				<br>
				<!-- 				</div>			
 -->
			</c:forEach>
		</div>

	</div>


</div>

<c:import url="/WEB-INF/jsp/footer.jsp" />