package cn.jxufe.restful.api;

import java.util.List;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import cn.jxufe.database.entity.GoBang;
import cn.jxufe.database.helper.EM;
import cn.jxufe.restful.bean.Status;

@Path("/app/goBang")
public class GoBangAPI {
	
	@POST
	@Path("/list")
	@Produces("application/json;charset=UTF-8")
	public List<GoBang> getList() {	
	    return EM.getEntityManager().createNamedQuery("GoBang.fetchIDAndCaption").getResultList();
	}
	
	@POST
	@Path("/fetchByID")
	@Produces("application/json;charset=UTF-8")
	public GoBang fetchByID(GoBang goBang) {	
	    return EM.getEntityManager()
	    		.createNamedQuery("GoBang.fetchByID", GoBang.class)
	    		.setParameter("id", goBang.getId())
	    		.getSingleResult();
	}
	
	@POST
	@Path("/add")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Status add(GoBang goBang) throws Exception {
		Status status = new Status();
		try{
			goBang.setId(0);
			goBang = EM.getEntityManager().merge(goBang);
			EM.getEntityManager().persist(goBang);
			EM.getEntityManager().getTransaction().commit();
			EM.getEntityManager().flush();
			status.setCode(Status.SUCCESS);
			status.setMessage(Status.SUCCESS_ADD_MSG);
			status.setO(goBang.getId());
		}catch(Exception e){
			status.setCode(Status.FAILED);
			status.setMessage(Status.FAILED_ADD_MSG);
			e.printStackTrace();
		}
	    return status;
	}
	
	@POST
	@Path("/save")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Status save(GoBang goBang) throws Exception {
		Status status = new Status();
		try{
			goBang = EM.getEntityManager().merge(goBang);
			EM.getEntityManager().persist(goBang);
			EM.getEntityManager().getTransaction().commit();
			EM.getEntityManager().flush();
			status.setCode(Status.SUCCESS);
			status.setMessage(Status.SUCCESS_UPDATE_MSG);
			status.setO(goBang.getId());
		}catch(Exception e){
			status.setCode(Status.FAILED);
			status.setMessage(Status.FAILED_UPDATE_MSG);
			e.printStackTrace();
		}
		return status;
	}
	
	@POST
	@Path("/delete")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Status delete(GoBang goBang) throws Exception {
		Status status = new Status();
		try{
			EM.getEntityManager().remove(EM.getEntityManager().merge(goBang));
			EM.getEntityManager().getTransaction().commit();
			status.setCode(Status.SUCCESS);
			status.setMessage(Status.SUCCESS_REMOVE_MSG);
		}catch(Exception e){
			status.setCode(Status.FAILED);
			status.setMessage(Status.FAILED_REMOVE_MSG);
			e.printStackTrace();
		}	
	    return status;
	}
		
}
