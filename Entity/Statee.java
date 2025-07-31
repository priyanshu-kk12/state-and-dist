package com.aashdit.pallishree.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data; 

@Entity(name = "PallishreeState")
@Data
@Table(name ="statee") 
public class Statee { 

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long stateid;
	@Column(name="statename")
	private String stateName;
	@Column(name="statecode")
	private String stateCode;
	@Column(name = "isactive")
	private Boolean isActive;
	
}
  