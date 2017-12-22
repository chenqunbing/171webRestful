package cn.jxufe.database.entity;

public class Status {
	
	public final static int SUCCESS = 0;
	public final static int FAILED = -1;
	
	public final static String SUCCESS_ADD_MSG = "添加成功";
	public final static String SUCCESS_REMOVE_MSG = "删除成功";
	public final static String SUCCESS_UPDATE_MSG = "修改成功";
	
	public final static String FAILED_ADD_MSG = "添加失败";
	public final static String FAILED_REMOVE_MSG = "删除失败";
	public final static String FAILED_UPDATE_MSG = "修改失败";
	
	private int code;
	private String message;
	private Object o;
	
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public Object getO() {
		return o;
	}
	public void setO(Object o) {
		this.o = o;
	}
	
}
