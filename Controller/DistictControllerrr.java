package com.aashdit.pallishree.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import com.aashdit.pallishree.service.DistictServicee;
import com.aashdit.pallishree.service.StateServiceee;

@Controller
@RequestMapping("/dist")
public class DistictControllerrr {

	
	@Autowired
	private DistictServicee distictService;
	
	@Autowired
	private StateServiceee stateService;
	
	
	@GetMapping("/home")
	private String getDistPage(Model model)
	{
		//System.out.println(stateService.findAllStatesIsactiveTrue().getData());
		model.addAttribute("states", stateService.findAllStates().getData());
		return "site.distict";
	}
	
	@GetMapping("/generateDistCode")
	@ResponseBody
	public String generateStateCode(@RequestParam("distName") String distName) {
		String distCode = "";
		try {
			System.out.println("generate Dist Controller");
		    

		    if (distName != null && !distName.trim().isEmpty()) {
		        // Create dummy code (first 3 letters in uppercase + random digits or timestamp)
		        String prefix = distName.substring(0, Math.min(3, distName.length())).toUpperCase();
		        distCode = prefix + System.currentTimeMillis() % 10000; // or some other unique logic
		    }

		} catch (Exception e) {
				System.out.println(e.getMessage());
		}
	    return distCode;

	}
	
	@PostMapping("/dist/add-dist")
	public String addDistict()
	{
		
		return "";
	}
	
	 
}
