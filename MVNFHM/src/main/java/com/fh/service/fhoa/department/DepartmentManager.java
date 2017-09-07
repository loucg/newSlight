package com.fh.service.fhoa.department;

import java.util.List;

import com.fh.entity.Page;
import com.fh.entity.system.Department;
import com.fh.entity.system.Role;
import com.fh.util.PageData;

/** 
 * 说明： 组织机构接口类
 * 创建人：FH Q313596790
 * 创建时间：2015-12-16
 * @version
 */
public interface DepartmentManager{
	
	/**列出所有公司列表
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<Department> listAllDepartmentsByPId(PageData pd) throws Exception;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;
	
	/**获取部门id
	 * @param pd
	 * @throws Exception
	 */
	public PageData getid(String companyid)throws Exception;
	
	/**获取公司id
	 * @param pd
	 * @throws Exception
	 */
	public PageData getcompanyid(String companyid)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception;
	
	/**修改部门
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception;
	
	/**修改公司
	 * @param pd
	 * @throws Exception
	 */
	public void editcompany(PageData pd)throws Exception;
	
	/**新增公司
	 * @param pd
	 * @throws Exception
	 */
	public void addcompany(PageData pd)throws Exception;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;
	
	/**公司列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> companylist(Page page)throws Exception;
	
	/**列出公司下的所有部门
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listselectdepartment(String companyid)throws Exception;
	
	/**删除图片
	 * @param pd
	 * @throws Exception
	 */
	public void delTp(PageData pd)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findcompanyById(PageData pd)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData finddepartmentById(PageData pd)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public String findcompanyname(String pd)throws Exception;

	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public String searchparentname(Object parentid)throws Exception;
	
	/**通过编码获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findByBianma(PageData pd)throws Exception;
	
	/**
	 * 通过ID获取其子级列表
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	public List<Department> listSubDepartmentByParentId(String parentId) throws Exception;
	
	/**
	 * 获取所有数据并填充每条数据的子级列表(递归处理)
	 * @param MENU_ID
	 * @return
	 * @throws Exception
	 */
	public List<Department> listAllDepartment(String parentId,String companyid) throws Exception;
	
	/**
	 * 获取所有数据并填充每条数据的子级列表(递归处理)下拉ztree用
	 * @param MENU_ID
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listAllDepartmentToSelect(String parentId, List<PageData> zdepartmentPdList) throws Exception;
	
	/**获取某个部门所有下级部门ID(返回拼接字符串 in的形式)
	 * @param DEPARTMENT_ID
	 * @return
	 * @throws Exception
	 */
	public String getDEPARTMENT_IDS(String DEPARTMENT_ID) throws Exception;
	
	
	/**
	 * 获取当前用户所在部门id
	 */
	public int getMyDepartmentid(PageData pd) throws Exception;
	
	
	/**
	 * 获取某个部门下所有的用户id(返回拼接字符串in的形式)
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public String getUseridsInDepartment(PageData pd) throws Exception;
	
}

