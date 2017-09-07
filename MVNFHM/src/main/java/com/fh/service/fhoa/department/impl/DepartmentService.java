package com.fh.service.fhoa.department.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.entity.system.Department;
import com.fh.entity.system.Role;
import com.fh.hzy.util.UserUtils;
import com.fh.util.PageData;
import com.fh.util.Tools;
import com.fh.service.fhoa.department.DepartmentManager;

/** 
 * 说明： 组织机构
 * 创建人：FH Q313596790
 * 创建时间：2015-12-16
 * @version
 */
@Service("departmentService")
public class DepartmentService implements DepartmentManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**列出所有公司列表
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Department> listAllDepartmentsByPId(PageData pd) throws Exception {
		return (List<Department>) dao.findForList("DepartmentMapper.listAllDepartmentsByPId", pd);
	}
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("DepartmentMapper.save", pd);
	}
	
	/**获取部门主键
	 * @param pd
	 * @throws Exception
	 */
	public PageData getid(String companyid)throws Exception{
		return (PageData)dao.findForObject("DepartmentMapper.getid",companyid);
	}
	
	/**获取公司主键
	 * @param pd
	 * @throws Exception
	 */
	public PageData getcompanyid(String companyid)throws Exception{
		return (PageData)dao.findForObject("DepartmentMapper.getcompanyid",companyid);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("DepartmentMapper.delete", pd);
	}
	
	/**修改部门
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("DepartmentMapper.edit", pd);
	}
	
	/**修改公司
	 * @param pd
	 * @throws Exception
	 */
	public void editcompany(PageData pd)throws Exception{
		dao.update("DepartmentMapper.editcompany", pd);
	}
	
	/**新增公司
	 * @param pd
	 * @throws Exception
	 */
	public void addcompany(PageData pd)throws Exception{
		dao.update("DepartmentMapper.addcompany", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("DepartmentMapper.datalistPage", page);
	}
	
	/**公司列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> companylist(Page page)throws Exception{
		return (List<PageData>)dao.findForList("DepartmentMapper.companylistPage", page);
	}
	
	/**列出公司下的所有部门
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listselectdepartment(String companyid)throws Exception{
		return (List<PageData>)dao.findForList("DepartmentMapper.listselectdepartment", companyid);
	}
	
	/**删除图片
	 * @param pd
	 * @throws Exception
	 */
	public void delTp(PageData pd)throws Exception{
		dao.update("DepartmentMapper.delTp", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("DepartmentMapper.findById", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData finddepartmentById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("DepartmentMapper.findById", pd);
	}
	
	/**通过id获取公司数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findcompanyById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("DepartmentMapper.findcompanyById", pd);
	}
	
	/**通过id获取公司名字
	 * @param pd
	 * @throws Exception
	 */
	public String findcompanyname(String pd)throws Exception{
		return (String)dao.findForObject("DepartmentMapper.findcompanyname", pd);
	}
	
	/**通过id获取上级部门名称
	 * @param pd
	 * @throws Exception
	 */
	public String searchparentname(Object parentid)throws Exception{
		return (String)dao.findForObject("DepartmentMapper.searchparentname", parentid);
	}
	
	/**通过编码获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findByBianma(PageData pd)throws Exception{
		return (PageData)dao.findForObject("DepartmentMapper.findByBianma", pd);
	}
	
	/**
	 * 通过ID获取其子级列表
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Department> listSubDepartmentByParentId(String parentId) throws Exception {
		return (List<Department>) dao.findForList("DepartmentMapper.listSubDepartmentByParentId", parentId);
	}
	
	/**
	 * 通过公司ID获取第一级子级列表
	 * @param companyid
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Department> listFirstDepartmentByParentId(String companyid) throws Exception {
		return (List<Department>) dao.findForList("DepartmentMapper.listFirstDepartmentByParentId", companyid);
	}
	
	/**
	 * 获取公司列表
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Department> listAllCompanyByParentId(String parentId) throws Exception {
		return (List<Department>) dao.findForList("DepartmentMapper.listAllCompanyByParentId", parentId);
	}
	
	/**
	 * 获取所有数据并填充每条数据的子级列表(递归处理)
	 * @param MENU_ID
	 * @return
	 * @throws Exception
	 */
	public List<Department> listAllDepartment(String parentId,String companyid) throws Exception {
		List<Department> departmentList = new ArrayList<Department>();
		if(companyid=="0"){
			departmentList = this.listAllCompanyByParentId(parentId);
			for(Department depar : departmentList){
				depar.setTreeurl("department/companylist.do?companyid="+depar.getDEPARTMENT_ID());
				depar.setSubDepartment(this.listAllDepartment("0",depar.getDEPARTMENT_ID()));
				depar.setTarget("treeFrame");
				depar.setCOMPANY(depar.getDEPARTMENT_ID());
				depar.setIcon("static/images/user.gif");
			}
		}
		else{
			if(parentId=="0"){
				departmentList = this.listFirstDepartmentByParentId(companyid);
				for(Department depar : departmentList){
					depar.setTreeurl("department/list.do?companyid="+companyid);
					depar.setSubDepartment(this.listAllDepartment(depar.getDEPARTMENT_ID(),companyid));
					depar.setTarget("treeFrame");
					depar.setCOMPANY(companyid);
					depar.setIcon("static/images/user.gif");
				}
			}
			else{
				departmentList = this.listSubDepartmentByParentId(parentId);
				for(Department depar : departmentList){
					depar.setTreeurl("department/list.do?companyid="+companyid);
					depar.setSubDepartment(this.listAllDepartment(depar.getDEPARTMENT_ID(),companyid));
					depar.setTarget("treeFrame");
					depar.setCOMPANY(companyid);
					depar.setIcon("static/images/user.gif");
				}
			}
			
		}
		
		return departmentList;
	}
	
	/**
	 * 获取所有数据并填充每条数据的子级列表(递归处理)下拉ztree用
	 * @param MENU_ID
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listAllDepartmentToSelect(String parentId,List<PageData> zdepartmentPdList) throws Exception {
		List<PageData>[] arrayDep = this.listAllbyPd(parentId,zdepartmentPdList);
		List<PageData> departmentPdList = arrayDep[1];
		for(PageData pd : departmentPdList){
			this.listAllDepartmentToSelect(pd.getString("id"),arrayDep[0]);
		}
		return arrayDep[0];
	}
	
	/**下拉ztree用
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData>[] listAllbyPd(String parentId,List<PageData> zdepartmentPdList) throws Exception {
		List<Department> departmentList = this.listSubDepartmentByParentId(parentId);
		List<PageData> departmentPdList = new ArrayList<PageData>();
		for(Department depar : departmentList){
			PageData pd = new PageData();
			pd.put("id", depar.getDEPARTMENT_ID());
			pd.put("parentId", depar.getPARENT_ID());
			pd.put("name", depar.getNAME());
			pd.put("icon", "static/images/user.gif");
			departmentPdList.add(pd);
			zdepartmentPdList.add(pd);
		}
		List<PageData>[] arrayDep = new List[2];
		arrayDep[0] = zdepartmentPdList;
		arrayDep[1] = departmentPdList;
		return arrayDep;
	}
	
	/**获取某个部门所有下级部门ID(返回拼接字符串 in的形式， ('a','b','c'))
	 * @param DEPARTMENT_ID
	 * @return
	 * @throws Exception
	 */
	public String getDEPARTMENT_IDS(String DEPARTMENT_ID) throws Exception {
		DEPARTMENT_ID = Tools.notEmpty(DEPARTMENT_ID)?DEPARTMENT_ID:"0";
		List<PageData> zdepartmentPdList = new ArrayList<PageData>();
		zdepartmentPdList = this.listAllDepartmentToSelect(DEPARTMENT_ID,zdepartmentPdList);
		StringBuffer sb = new StringBuffer();
		sb.append("(");
		for(PageData dpd : zdepartmentPdList){
			sb.append("'");
			sb.append(dpd.getString("id"));
			sb.append("'");
			sb.append(",");
		}
		sb.append("'fh')");
		return sb.toString();
	}
	
	

	@Override
	public int getMyDepartmentid(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		pd.put("userid", UserUtils.getUserid());
		List<PageData> list = (List<PageData>)dao.findForList("DepartmentMapper.getMyDepartmentid", pd);
		if(list==null||list.size()==0){
			return 0;
		}else{
			System.out.println("departmentid ="+(Integer)list.get(0).get("departmentid"));
			return (Integer)list.get(0).get("departmentid");
		}
		
	}

	/**
	 * 获取某个部门下所有的用户id(返回拼接字符串in的形式)
	 */
	@Override
	public String getUseridsInDepartment(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		pd.put("departmentid",getMyDepartmentid(pd));
		List<PageData> list = (List<PageData>)dao.findForList("DepartmentMapper.getUsersInDepartment", pd);
		StringBuffer sb = new StringBuffer();
		sb.append("(");
		for(int i=0;i<list.size();i++){
			sb.append("'");
			sb.append(list.get(i).get("userid"));
			sb.append("'");
			if(i!=list.size()-1)sb.append(",");
		}
		sb.append(")");
		return sb.toString();
	}
	
}

