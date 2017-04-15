package com.techelevator.capstone.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.gargoylesoftware.htmlunit.javascript.host.intl.DateTimeFormat;
import com.techelevator.capstone.dao.AppointmentDAO;
import com.techelevator.capstone.dao.DoctorDAO;
import com.techelevator.capstone.dao.OfficeDAO;
import com.techelevator.capstone.dao.PatientDAO;
import com.techelevator.capstone.dao.ReviewDAO;
import com.techelevator.capstone.model.Appointment;
import com.techelevator.capstone.model.Doctor;
import com.techelevator.capstone.model.Patient;


@Controller
@Scope("session")
@SessionAttributes({"currentPatientId","currentDoctorId","currentDoctorId2"})
public class AppointmentController {
		
		@Autowired
		private PatientDAO patientDAO;
		@Autowired
		private OfficeDAO officeDAO;
		@Autowired
		private DoctorDAO doctorDAO;
		@Autowired
		private ReviewDAO reviewDAO;
		@Autowired
		private AppointmentDAO appointmentDAO;
		
		private static final LocalTime eight = LocalTime.of(8, 00);
		private static final LocalTime eightThirty = LocalTime.of(8, 30);
		private static final LocalTime nine = LocalTime.of(9, 00);
		private static final LocalTime nineThirty = LocalTime.of(9, 30);
		private static final LocalTime ten = LocalTime.of(10, 00);
		private static final LocalTime tenThirty = LocalTime.of(10, 30);
		private static final LocalTime eleven = LocalTime.of(11, 00);
		private static final LocalTime elevenThirty = LocalTime.of(11, 30);
		private static final LocalTime noon = LocalTime.of(12, 00);
		private static final LocalTime noonThirty = LocalTime.of(12, 30);
		private static final LocalTime one = LocalTime.of(13, 00);
		private static final LocalTime oneThirty = LocalTime.of(13, 30);
		private static final LocalTime two = LocalTime.of(14, 00);
		private static final LocalTime twoThirty = LocalTime.of(14, 30);
		private static final LocalTime three = LocalTime.of(15, 00);
		private static final LocalTime threeThirty = LocalTime.of(15, 30);
		private static final LocalTime four = LocalTime.of(16, 00);
		private static final LocalTime fourThirty = LocalTime.of(16, 30);
		private LocalTime[] agenda = {eight, eightThirty, nine, nineThirty, ten, tenThirty, eleven, elevenThirty, noon, noonThirty, one, oneThirty, two, twoThirty, three, threeThirty, four, fourThirty};
		
		
		@RequestMapping(path="/doctorsAppointment", method=RequestMethod.GET)
		public String showDoctorsSelectedAppointment(@RequestParam int id, HttpServletRequest request){
			Appointment appointment  = appointmentDAO.getAppointmentById(id);
			int patientsId = appointment.getPatientId();
			Patient thePatient = patientDAO.getPatientById(patientsId);
			
			LocalTime time = appointment.getStartDate().toLocalTime();
			request.setAttribute("patient", thePatient);
			request.setAttribute("appointment", appointment);
			request.setAttribute("time", time);
			
			return "/doctorsAppointment";
		}
		
		@RequestMapping(path="/doctorScheduling", method=RequestMethod.GET)
		public String goToDoctorsSchedulingPage(@RequestParam String time, @RequestParam String date, @RequestParam int id, HttpServletRequest request) {
			
			request.setAttribute("time", time);
			request.setAttribute("date", date);
			request.setAttribute("id", id);
			request.setAttribute("appointment", agenda);
			
		return "doctorScheduling"; 
		}
		
		@RequestMapping(path="/submitAppointment", method=RequestMethod.POST)
		public String doctorSubmitAnAppointment(@RequestParam String time, @RequestParam String date, @RequestParam String message, HttpServletRequest request, ModelMap model) {
			
			Appointment appt = new Appointment();
			int doc = (int) model.get("currentDoctorId2");
			System.out.println(doc);
			appt.setDoctorId(doc);
			appt.setMessage(message);
			appt.setPatientId(-1);
			String str = date + " " + time;
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
			LocalDateTime dateTime = LocalDateTime.parse(str, formatter);
			appt.setEndDate(dateTime);
			appt.setStartDate(dateTime);
			
			
			appointmentDAO.createAppointment(appt);
			
			return "redirect:/providerView";
		}
		
		
}
