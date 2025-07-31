package com.aashdit.pallishree.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aashdit.pallishree.repository.distRepo;

@Service
public class DistictServiceImpl implements DistictServicee {

	
	@Autowired
	private distRepo distRepo;
	
	
}
