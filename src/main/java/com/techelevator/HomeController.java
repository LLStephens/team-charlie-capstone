package com.techelevator;


import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.techelevator.dao.DoctorDAO;
import com.techelevator.dao.OfficeDAO;
import com.techelevator.dao.ReviewDAO;

@Controller
public class HomeController {
	@Autowired
	private OfficeDAO officeDAO;
	@Autowired
	private DoctorDAO doctorDAO;
	@Autowired
	private ReviewDAO reviewDAO;
	

	@RequestMapping("/")
	public String showHome(HttpServletRequest request) {
		List<Office> officeList =officeDAO.getAllOffices();
		request.setAttribute("officeList", officeList);
		return "home";
	}
	
	@RequestMapping(path="/offices", method=RequestMethod.GET)
	public String showOffice(@RequestParam int officeId, HttpServletRequest request) {
		List<Doctor> doctorList = doctorDAO.getAllDoctorsByOfficeId(officeId);
		request.setAttribute("doctorList", doctorList);
		String officeName = officeDAO.getOfficeById(officeId).getName();
	    request.setAttribute("officeName", officeName);
	    List<Review> reviewList = reviewDAO.getAllReviews();
		request.setAttribute("reviewList", reviewList);
		return "offices";
	}

	@RequestMapping(path="/readReviews", method=RequestMethod.GET)
	public String showReviews(@RequestParam int doctorId, HttpServletRequest request) {
		List<Review> reviewList = reviewDAO.getAllReviewsByDoctorId(doctorId);
		request.setAttribute("reviewList", reviewList);
		return "readReviews";
	}
	
	@RequestMapping(path="/writeReview", method=RequestMethod.GET)
	public String inputReview(@RequestParam int doctorId, HttpServletRequest request) {
		return "writeReview";
	}

	
	@RequestMapping(path="/offices", method=RequestMethod.POST)
	public String processReview(Review review){
		reviewDAO.addReview(review);
		return "redirect:/offices";
	}

}
