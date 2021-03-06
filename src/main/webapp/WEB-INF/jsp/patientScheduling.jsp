<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:import url="/WEB-INF/jsp/header.jsp" />
<script type="text/javascript">
	function changeHiddenInput(objDropDown) {
		var objHidden = document.getElementById("hiddenInput");
		objHidden.value = objDropDown.value;
	}

	window.test = function(e) {
		if (e.value == "invalid") {
			alert("Please choose a valid reason from the drop-down menu");
		}
	}
</script>
<div class="container-fluid">
	<div class="loginBox">
		<div class="innerBox">
			<div class="row">
			<div class="container col-xs-12" > 
				<legend id="legend">Book an appointment</legend>
				<div class="container-fluid alignmid">
					<div class="apptDetails">
						<h3>This appointment is currently open</h3>
						<c:out value="${appointment[id]}" />
						<c:out value="${date}" />
					</div>
				</div>

				<div class="alignmid">

					<c:url var="submitAppointment" value="/submitPatientAppointment" />

					<form method="POST" action="${submitAppointment}">
						<input type="hidden" name="CSRF_TOKEN" value="${CSRF_TOKEN}" />
						<div class="container-fluid">
							<div class="apptSelect">
								<select id="dropdown" name="dropdown"
									onchange="changeHiddenInput(this); test(this);">
									<option value="invalid">Choose</option>
									<option value="New patient">New patient</option>
									<option value="Follow-up">Follow-up</option>
									<option value="Other">Other</option>
									<input value="invalid" type="hidden" name="reason"
									id="hiddenInput" value="" />
								</select>
							</div>
							<textarea class="textBox" rows="4" cols="50" name="message"
								id="message"
								placeholder="Please explain your purpose for are seeing the doctor."></textarea>
						</div>
						<button id="login_button" type="submit" class="btn btn-default">
							<c:out value="Book this appointment" />
						</button>
						<input type="hidden" name="doctorId" value="${doctorId}" /> <input
							type="hidden" name="date" value="${date}" /> <input
							type="hidden" name="time" value="${time}" />

					</form>

				</div>
			</div>
		</div>
	</div>
</div>
</div>
<c:import url="/WEB-INF/jsp/footer.jsp" />