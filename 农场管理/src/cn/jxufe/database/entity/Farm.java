package cn.jxufe.database.entity;

import javax.persistence.Entity;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name="T_Farm")
@NamedQueries({
	@NamedQuery(name="farm.all",query="select farm from Farm farm")
})
public class Farm  extends IdEntity{

	private String plantCode;
	
	private String plantCaption;
	
	private String fieldCode;
	
	private int lifeCycle;

	public String getPlantCode() {
		return plantCode;
	}

	public void setPlantCode(String plantCode) {
		this.plantCode = plantCode;
	}

	public String getPlantCaption() {
		return plantCaption;
	}

	public void setPlantCaption(String plantCaption) {
		this.plantCaption = plantCaption;
	}
	

	@Override
	public String toString() {
		return "Farm [plantCode=" + plantCode + ", plantCaption=" + plantCaption + ", fieldCode=" + fieldCode
				+ ", lifeCycle=" + lifeCycle + "]";
	}

	public String getFieldCode() {
		return fieldCode;
	}

	public void setFieldCode(String fieldCode) {
		this.fieldCode = fieldCode;
	}

	public int getLifeCycle() {
		return lifeCycle;
	}

	public void setLifeCycle(int lifeCycle) {
		this.lifeCycle = lifeCycle;
	}
	
}
