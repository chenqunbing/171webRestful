package cn.jxufe.restful.api;

import java.util.List;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import cn.jxufe.database.entity.Farm;
import cn.jxufe.database.entity.Status;
import cn.jxufe.database.helper.EM;

@Path("/app/farm")
public class PlantAPI {
	
	@Path("/all")
	@POST
	@Produces("application/json;charset=UTF-8")
	public List<Farm> getAll(){
		return EM.getEntityManager().createNamedQuery("farm.all",Farm.class).getResultList();
	}
	
	
	@POST
	@Path("/add")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Status add(Farm farm) throws Exception {
		Status status = new Status();
		try{
			farm.setId(0);
			EM.getEntityManager().persist(EM.getEntityManager().merge(farm));
			EM.getEntityManager().getTransaction().commit();
			status.setCode(Status.SUCCESS);
			status.setMessage(Status.SUCCESS_ADD_MSG);
		}catch(Exception e){
			status.setCode(Status.FAILED);
			status.setMessage(Status.FAILED_ADD_MSG);
			e.printStackTrace();
		}
	    return status;
	}
	
	@POST
	@Path("/water")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Status save(Farm farm) throws Exception {
		Status status = new Status();
		try{
			
			Farm f = EM.getEntityManager().find(Farm.class, farm.getId());
			f.setLifeCycle(farm.getLifeCycle());
			EM.getEntityManager().persist(EM.getEntityManager().merge(f));
			EM.getEntityManager().getTransaction().commit();
			
			status.setCode(Status.SUCCESS);
			status.setMessage(Status.SUCCESS_UPDATE_MSG);
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
	public Status delete(Farm farm) throws Exception {
		Status status = new Status();
		try{
			EM.getEntityManager().remove(EM.getEntityManager().merge(farm));
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
