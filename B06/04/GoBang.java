package cn.jxufe.database.entity;

import java.util.Date;
import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "T_GoBang")
@NamedQueries({
    @NamedQuery(name = "GoBang.fetchIDAndCaption", query = "SELECT new Map(goBang.id as id,goBang.caption as caption) FROM GoBang goBang"),    
    @NamedQuery(name = "GoBang.fetchByID", query = "SELECT goBang FROM GoBang goBang where goBang.id=:id")
})
public class GoBang extends IdEntity {
	
	private String caption;
	private String goBang;
	
	public String getCaption() {
		return caption;
	}
	public void setCaption(String caption) {
		this.caption = caption;
	}
	public String getGoBang() {
		return goBang;
	}
	public void setGoBang(String goBang) {
		this.goBang = goBang;
	}
}
