package com.aashdit.pallishree.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aashdit.framework.core.ServiceOutcome;
import com.aashdit.pallishree.entity.Student;
import com.aashdit.pallishree.service.StudentDto;
import com.aashdit.pallishree.service.StudentService;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
//@RequestMapping("/student")
public class StudentController {
	
	@Autowired
	private StudentService studentService;
	
	@GetMapping("/studentPage")
	public String welcomeStudent()
	{
		log.info("controller hitted");
		return "site.student";
	}
	
	@GetMapping("/addStudent")
	public String addStudent(Model model)
	{
		log.info("opened Add Student Form Page");
		model.addAttribute("studentList",studentService.getStudentList());
		return "site.student.addstudent";
	}
	
	@PostMapping("/saveStudentData")
	public String saveData(StudentDto dto,RedirectAttributes redirectAttributes)
	{
		System.out.println("Entered"+dto.getStudentId());

		try
		{
			ServiceOutcome<Student> saveDetails = studentService.saveDetails(dto);
			
			if(saveDetails.getData().getStudentId()!=null)
			{
				redirectAttributes.addFlashAttribute("success_msg","Employee Added !!");
			}
			else
			{
				redirectAttributes.addFlashAttribute("error_msg"," Employee Updated Successfully !!");
			}

		}
		catch (Exception e) {

			redirectAttributes.addFlashAttribute("error_msg", "Something went wrong");
			System.out.println("error occured at saveData method");
			
		}
		return"redirect:/studentList";
	}
	
	@GetMapping("/studentList")
	public String getAllStudentDetail(Model model)
	{
		try
		{
			model.addAttribute("studentList",studentService.getStudentList());
		}
		catch (Exception e) {
			System.out.println("error occured at getAllStudentDetails Method");		
			}
		//return "site.listOfStudent";
		return "site.student.addstudent";
	}
	
	
	@GetMapping("/viewStudent/{id}")
	public String oneStudentDetail(@PathVariable Long id,Model model)
	{
		log.info("view method hitted");
		
		model.addAttribute("StudentObject", studentService.oneStudentDetail(id).getData());
		System.out.println(studentService.oneStudentDetail(id).getData());
		model.addAttribute("studentList",studentService.getStudentList());

		return "site.student.addstudent";
	}
	
	@GetMapping("/deleteStudent/{id}")
	public String deleteStudent(@PathVariable Long id,Model model)
	{
		studentService.deleteStudent(id);
		model.addAttribute("studentList",studentService.getStudentList());

		return "site.student.addstudent";
	}

}
