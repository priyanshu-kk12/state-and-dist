package com.aashdit.pallishree.controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aashdit.framework.core.ServiceOutcome;
import com.aashdit.pallishree.dto.StateDto;
import com.aashdit.pallishree.entity.Statee;
import com.aashdit.pallishree.service.StateServiceee;

@Controller
@RequestMapping("/state")
public class StatteController {
	
	@Autowired
	private StateServiceee service;

	@GetMapping("/home")
	public String homePage(Model model)
	{
		 model.addAttribute("states",service.findAllStates().getData());
		return "site.state";
	}
	
	@GetMapping("/addDistict")
	public String distictPage()
	{
		return "site.distict";
	}
	
	@GetMapping("/generateStateCode")
	@ResponseBody
	public String generateStateCode(@RequestParam("stateName") String stateName) {
	    String stateCode = "";

	    if (stateName != null && !stateName.trim().isEmpty()) {
	        // Create dummy code (first 3 letters in uppercase + random digits or timestamp)
	        String prefix = stateName.substring(0, Math.min(3, stateName.length())).toUpperCase();
	        stateCode = prefix + System.currentTimeMillis() % 10000; // or some other unique logic
	    }

	    return stateCode;
	}
	
	
	  @PostMapping("/saveData") 
	  public String saveState(StateDto stateDto,RedirectAttributes attr) {
		  ServiceOutcome<Statee> outcome = service.saveData(stateDto);
		  if(outcome.getOutcome()!=null)
		  {
			  attr.addFlashAttribute("success_msg", outcome.getMessage()); 
		  }
		  else
		  {
			  attr.addFlashAttribute("erro_msg", "Record Did Not Saved");
		  }
	   return "redirect:/state/show-all";
	  }
	  
	  
	  @GetMapping("/checkIfExists")
	  @ResponseBody
	  public boolean checkStateExists(@RequestParam("stateName") String stateName) {
	      boolean isExist=false;
	      try {
		      isExist = service.existsByStateName(stateName);

		} catch (Exception e) {
				System.out.println(e.getMessage());
		}
		  return isExist; 
	  }
	  
	  @GetMapping("/show-all")
	  public String getAllStates(Model model)
	  {
		  model.addAttribute("states",service.findAllStates().getData());
		  return "site.state";
	  }

	  @GetMapping("/editState/{id}")
	  public String showData(@PathVariable Long id,Model model)
	  {
		  System.out.println("edit route");
		  model.addAttribute("oneState", service.stateById(id).getData());
			 model.addAttribute("states",service.findAllStates().getData());
		  return "site.state";
	  }
	  
	  @GetMapping("/lockState/{id}")
	  @ResponseBody
	  public String locking(@PathVariable Long id) {
	      boolean isNowActive = service.isLock(id); 
	      return isNowActive ? "active" : "inactive";
	  }

}
