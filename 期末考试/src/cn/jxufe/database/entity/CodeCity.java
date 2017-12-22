package cn.jxufe.database.entity;

import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name="T_CodeCity")
@NamedQueries({
	@NamedQuery(name="CodeCity.findByContinent",query="select c from CodeCity c where continent=:continent "),
})
public class CodeCity extends IdEntity{
	private String code;
	private String caption;
	private String country;
	private String flag;
	private float timeZone;
	private float x;
	private float y;
	private float referenceCity;
	private String continent;
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getCaption() {
		return caption;
	}
	public void setCaption(String caption) {
		this.caption = caption;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public float getTimeZone() {
		return timeZone;
	}
	public void setTimeZone(float timeZone) {
		this.timeZone = timeZone;
	}
	public float getX() {
		return x;
	}
	public void setX(float x) {
		this.x = x;
	}
	public float getY() {
		return y;
	}
	public void setY(float y) {
		this.y = y;
	}
	public float getReferenceCity() {
		return referenceCity;
	}
	public void setReferenceCity(float referenceCity) {
		this.referenceCity = referenceCity;
	}
	public String getContinent() {
		return continent;
	}
	public void setContinent(String continent) {
		this.continent = continent;
	}
	@Override
	public String toString() {
		return "CodeCity [code=" + code + ", caption=" + caption + ", country=" + country + ", flag=" + flag
				+ ", timeZone=" + timeZone + ", x=" + x + ", y=" + y + ", referenceCity=" + referenceCity
				+ ", continent=" + continent + "]";
	}
	
}
