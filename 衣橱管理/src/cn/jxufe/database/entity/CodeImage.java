package cn.jxufe.database.entity;

import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name="T_CodeImage")
@NamedQueries({
	@NamedQuery(name="CodeImage.findByKind",query="select c from CodeImage c where kind=:kind"),
})
public class CodeImage extends IdEntity{
	
	private String code;
	private String caption;
	private String url;
	private int x;
	private int y;
	private int w;
	private int zIndex;
	private String kind;
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
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public int getX() {
		return x;
	}
	public void setX(int x) {
		this.x = x;
	}
	public int getY() {
		return y;
	}
	public void setY(int y) {
		this.y = y;
	}
	public int getW() {
		return w;
	}
	public void setW(int w) {
		this.w = w;
	}

	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public int getzIndex() {
		return zIndex;
	}
	public void setzIndex(int zIndex) {
		this.zIndex = zIndex;
	}
	@Override
	public String toString() {
		return "CodeImage [code=" + code + ", caption=" + caption + ", url=" + url + ", x=" + x + ", y=" + y + ", w="
				+ w + ", zIndex=" + zIndex + ", kind=" + kind + "]";
	}
	
	
	
}
