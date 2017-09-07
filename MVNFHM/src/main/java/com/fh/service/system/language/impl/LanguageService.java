package com.fh.service.system.language.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.system.Language;
import com.fh.service.system.language.LanguageManager;
import com.fh.util.PageData;

/**	语言
 * @author zjc
 * 修改日期：2017.1.29
 */
@Service("languageService")
public class LanguageService implements LanguageManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**列出所有语言
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Language> listAllLanguagesByPId(PageData pd) throws Exception {
		return (List<Language>) dao.findForList("LanguageMapper.listAllLanguagesByPId", pd);
	}
	
	/**通过id查找
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findObjectById(PageData pd) throws Exception {
		return (PageData)dao.findForObject("LanguageMapper.findObjectById", pd);
	}
	
	/**添加
	 * @param pd
	 * @throws Exception
	 */
	public void add(PageData pd) throws Exception {
		dao.save("LanguageMapper.insert", pd);
	}
	
	/**保存修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd) throws Exception {
		dao.update("LanguageMapper.edit", pd);
	}
	
	/**删除语言
	 * @param id
	 * @throws Exception
	 */
	public void deleteLanguageById(String id) throws Exception {
		dao.delete("LanguageMapper.deleteLanguageById", id);
	}
	
	/**通过id查找
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public Language getLanguageById(String id) throws Exception {
		return (Language) dao.findForObject("LanguageMapper.getLanguageById", id);
	}

}
