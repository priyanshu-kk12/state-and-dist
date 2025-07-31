package com.aashdit.pallishree.service;

import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aashdit.framework.core.ServiceOutcome;
import com.aashdit.pallishree.dto.StateDto;
import com.aashdit.pallishree.entity.Statee;
import com.aashdit.pallishree.repository.stateRepo;

@Service
public class StateServiceImpll implements StateServiceee {

	@Autowired
	private stateRepo repo;
	

	@Override
	public ServiceOutcome<Statee> saveData(StateDto stateDto) {
		ServiceOutcome<Statee> outcome=new ServiceOutcome<Statee>();

		Statee statee=new Statee();
		System.out.println(stateDto.getStateid());
		if(stateDto.getStateid()!=null)
		{
			statee.setStateid(stateDto.getStateid());
			outcome.setMessage("Record Updated successfully");
		}
		else
		{
			outcome.setMessage("Record Saved Successfully");
		}
		
		BeanUtils.copyProperties(stateDto, statee);
		System.out.println(statee.getStateName());
		statee.setIsActive(true);
		repo.save(statee);
		
		outcome.setData(statee);
		
		outcome.setOutcome(true);
		
		return outcome;
	}
	
	
	


	@Override
	public boolean existsByStateName(String stateName) {
	    return repo.existsByStateNameIgnoreCase(stateName.trim());
	}





	@Override
	public ServiceOutcome<List<Statee>> findAllStates() {
		ServiceOutcome<List<Statee>> serviceOutcome=new ServiceOutcome<List<Statee>>();
		
		List<Statee> findAll = repo.findAll();
		serviceOutcome.setData(findAll);
		return  serviceOutcome;
	}


	
	/*
	 * public ServiceOutcome<List<Statee>> findAllStatesIsactiveTrue() {
	 * ServiceOutcome<List<Statee>> serviceOutcome=new
	 * ServiceOutcome<List<Statee>>();
	 * 
	 * List<Statee> findAll = repo.findAllStatesTrue();
	 * serviceOutcome.setData(findAll); return serviceOutcome; }
	 */


	@Override
	public ServiceOutcome<Statee> stateById(Long id) {
		ServiceOutcome<Statee> serviceOutcome=new ServiceOutcome<Statee>();
		Statee statee = repo.findById(id).get();
		System.out.println(statee.getStateName() );
		if(statee!=null)
		{
			serviceOutcome.setData(statee);
			serviceOutcome.setMessage("Active");
			serviceOutcome.setOutcome(true);

		}
		
		return serviceOutcome;
	}





	@Override
	public boolean isLock(Long id)
	{

		Statee statee =repo.findById(id).get();
		
		if(statee!=null)
		{
			if(statee.getIsActive())
			{
				statee.setIsActive(false);
			}
			else
			{
				statee.setIsActive(true);
			}
			repo.save(statee);
			return statee.getIsActive();
		}
		return false;
			
	}
		
		


	
	
}
