package com.aashdit.pallishree.service;

import java.util.List;

import com.aashdit.framework.core.ServiceOutcome;
import com.aashdit.pallishree.dto.StateDto;
import com.aashdit.pallishree.entity.Statee;

public interface StateServiceee {
	public ServiceOutcome<Statee> saveData(StateDto stateDto);
	boolean existsByStateName(String stateName);
	public ServiceOutcome<List<Statee>> findAllStates();
	//public ServiceOutcome<List<Statee>> findAllStatesIsactiveTrue();
	public ServiceOutcome<Statee> stateById(Long id);
	
	public boolean isLock(Long id);


}
