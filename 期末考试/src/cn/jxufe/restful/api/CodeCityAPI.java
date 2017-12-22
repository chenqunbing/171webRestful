package cn.jxufe.restful.api;

import java.util.List;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import cn.jxufe.database.entity.CodeCity;
import cn.jxufe.database.entity.Status;
import cn.jxufe.database.helper.EM;

@Path("/app/city")
public class CodeCityAPI {
	@POST
	@Path("/list")
	@Produces("application/json;charset=UTF-8")
	public List<CodeCity> getList(CodeCity codeCity) {	
		return EM.getEntityManager().createNamedQuery("CodeCity.findByContinent",CodeCity.class).setParameter("continent",codeCity.getContinent()).getResultList();
	}
	
	@POST
	@Path("/add")
	@Produces("application/json;charset=UTF-8")
	public Status add(CodeCity codeCity) throws Exception {
		Status status = new Status();
		try{
			codeCity.setId(0);
			codeCity = EM.getEntityManager().merge(codeCity);
			EM.getEntityManager().persist(codeCity);
			EM.getEntityManager().getTransaction().commit();
			EM.getEntityManager().flush();
			status.setCode(Status.SUCCESS);
			status.setMessage(Status.SUCCESS_ADD_MSG);
			status.setO(codeCity.getId());
		}catch(Exception e){
			status.setCode(Status.FAILED);
			status.setMessage(Status.FAILED_ADD_MSG);
			e.printStackTrace();
		}
	    return status;
	}
	
	@POST
	@Path("/save")
	@Produces("application/json;charset=UTF-8")
	public Status save(CodeCity codeCity) throws Exception {
		Status status = new Status();
		try{
			codeCity = EM.getEntityManager().merge(codeCity);
			EM.getEntityManager().persist(codeCity);
			EM.getEntityManager().getTransaction().commit();
			EM.getEntityManager().flush();
			status.setCode(Status.SUCCESS);
			status.setMessage(Status.SUCCESS_UPDATE_MSG);
			status.setO(codeCity.getId());
		}catch(Exception e){
			status.setCode(Status.FAILED);
			status.setMessage(Status.FAILED_UPDATE_MSG);
			e.printStackTrace();
		}
		return status;
	}
	
	@POST
	@Path("/delete")
	@Produces("application/json;charset=UTF-8")
	public Status delete(CodeCity codeCity) throws Exception {
		Status status = new Status();
		try{
			EM.getEntityManager().remove(EM.getEntityManager().merge(codeCity));
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
