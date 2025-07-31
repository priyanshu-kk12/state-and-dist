package com.aashdit.pallishree.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.PrePersist;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Data
@Table(name ="distict") 
public class Distict {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long distId;
	private String distName;
	
	private String distCode;
	private boolean isActive;
	
	
	@ManyToOne
	@JoinColumn(name="stateId")
	private Statee statee;
	
	 /*@PrePersist
	    public void generateDistCode() {
	        if (this.distCode == null || this.distCode.isEmpty()) {
	            // Simple code logic: first 3 letters of distName + ID
	            this.distCode = (distName != null ? distName.substring(0, Math.min(3, distName.length())).toUpperCase() : "DIS")
	                          + distId;
	        }
	    }
	*/
}
