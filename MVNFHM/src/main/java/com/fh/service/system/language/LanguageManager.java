package com.fh.service.system.language;

import java.util.List;

import com.fh.entity.system.Language;
import com.fh.util.PageData;

/**	语言接口类
 * @author zjc
 * 修改日期：2017.1.29
 */
public interface LanguageManager {
	
	/**列出所有语言
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<Language> listAllLanguagesByPId(PageData pd) throws Exception;
	
	/**通过id查找
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findObjectById(PageData pd) throws Exception;
	
	/**添加
	 * @param pd
	 * @throws Exception
	 */
	public void add(PageData pd) throws Exception;
	
	/**保存修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd) throws Exception;
	
	/**删除语言
	 * @param id
	 * @throws Exception
	 */
	public void deleteLanguageById(String id) throws Exception;
		
	/**通过id查找
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public Language getLanguageById(String id) throws Exception;
		
}
