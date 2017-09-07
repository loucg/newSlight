package com.fh.controller.group;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.data.domain.jaxb.PageAdapter;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.service.group.GroupService;
import com.fh.service.group.mem.GroupMemService;
import com.fh.service.smartgroup.SmartGroupService;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;


/**
 * 智能分组
 * @author xiaozhou
 * 创建时间：2017年3月9日
 */
@Controller
@RequestMapping(value="/smartgroup")
public class SmartGroupController extends BaseController{

	String menuUrl = "smartgroup/groupPower.do"; //菜单地址(权限用)
    @Resource(name="smartGroupService")
    private SmartGroupService smartGroupService;
    @Resource(name="groupService")
    private GroupService groupService;
    @Resource(name="groupMemService")
    private GroupMemService groupMemService;
    
    
    
    
    /**功率分组
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/groupPower")
	public void groupPower(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"groupPower");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		
		//查询灯是不是属于同一个电线杆，如果不是则无法进行功率分组
		/*long num = 0;
		PageData lamp = smartGroupService.getLampCount(pd);
		if(null !=lamp.get("num") && !"".equals(lamp.get("num"))){
			 num = (long)lamp.get("num");
			 System.out.println("num:"+num);
		}*/
		
		/*
		 * 1 先计算出这个组里面的所有终端功率的平均值，作为参考
		 * 2 比这个参考值大的就是大功率，比这个功率值小的就是小功率
		 * 3 按灯杆将这个组分成不同的小组，剔除一个灯杆上只有一个灯的终端
		 * 4 每个小组按参考功率分为大功率和小功率
		 * 5 c_term新增两个分组，名称分别改为原名+大功率，原名+小功率 其余字段原封拷贝
		 * 6 修改c_client_term 将原来分组对应的删除，增加大功率和小功率相对应的终端
		 */
		String group_id = pd.getString("id");							//小组编号
		int number = Integer.valueOf(pd.getString("number"));			//组成员数量	
		double sumPower = (double)(smartGroupService.getSumPower(pd));	//小组总功率
		PageData group = smartGroupService.getGroup(pd);				//小组详细信息
		
	    String name = group.getString("name");
	    
	    if(!name.contains("功率大") && !name.contains("功率小") && number > 1){
	    	
	    	group.put("name", name+"功率大");
			groupService.addGroup(group);
			String high_id = String.valueOf(group.get("id"));
			System.out.println(group.get("id"));
			group.put("name", name+"功率小");
			groupService.addGroup(group);
			String low_id = String.valueOf(group.get("id"));
			System.out.println(group.get("id"));
			
			List<PageData> clientPowerList = smartGroupService.getClientPower(pd);  
			
			if(clientPowerList.isEmpty() || clientPowerList == null) {				//如果没有适合分组的终端，删除新增的分组，跳出循环
				groupService.deleteGroup(high_id);
				groupService.deleteGroup(low_id);
				
			}else{
				double avePower = sumPower/number;
				
				//List<PageData> highpower =  new ArrayList<PageData>();
				//List<PageData> lowpower = new ArrayList<PageData>();
				//循环分组
				for (PageData powers : clientPowerList) {
					
					PageData highp = new PageData();
					PageData lowp = new PageData();
					
					String client_id = String.valueOf((long) powers.get("client_id"));
					String power = String.valueOf(powers.get("power"));
					
					if(null !=power && !"".equals(power)){
						
						if( Double.valueOf(power) > avePower){
							highp.put("c_client_id", client_id.trim());
							highp.put("power", power.trim());
							highp.put("c_term_id", high_id.trim());
							groupMemService.update(highp);
							//System.out.println("highp"+highp);
							//highpower.add(highp);
						}else if(Double.valueOf(power) < avePower){
							lowp.put("c_client_id", client_id.trim());
							lowp.put("power", power.trim());
							lowp.put("c_term_id", low_id.trim());
							groupMemService.update(lowp);
							//System.out.println("lowp"+lowp);
							//lowpower.add(lowp);
						}
					}
				}
				//System.out.println("highpower"+highpower);
				//System.out.println("lowpower"+lowpower);
				out.write("success"); 
			}
	    }
		out.close();
	}
    
    
	//根据两点间经纬度坐标（double值），计算两点间距离，单位为米
	private static final double EARTH_RADIUS = 6378137;
	    private static double rad(double d)
	    {
	       return d * Math.PI / 180.0;
	    }
	    public static double GetDistance(double lng1, double lat1, double lng2, double lat2)
	    {
	       double radLat1 = rad(lat1);
	       double radLat2 = rad(lat2);
	       double a = radLat1 - radLat2;
	       double b = rad(lng1) - rad(lng2);
	       double s = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(a/2),2) + 
	        Math.cos(radLat1)*Math.cos(radLat2)*Math.pow(Math.sin(b/2),2)));
	       s = s * EARTH_RADIUS;
	       s = Math.round(s * 10000) / 10000;
	       return s;
	    }
    //根据两点间经纬度坐标（double值），计算两点间距离，单位为米  
	
    /**奇偶分组
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/groupOddeven")
	public void groupOddeven(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"groupPower");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		/*
		 * ***默认组内的灯在一条直线上***
		 * 1 根据组id查询组内终端的所有灯杆的坐标
		 * 2 任选一个灯杆作为起始，算此灯杆到其他灯杆的距离，并找出距离最大的一个灯杆的坐标，编号1
		 * 3 以编号1灯杆坐标为起点，算出到其他灯杆的距离，并从小到大排序
		 * 4 排序后的坐标按奇偶分组，此时是灯杆的奇偶分组，然后update表c_client_term
		 */
		List<PageData> clientCoordinates = smartGroupService.getClientCoordinates(pd); //id ，坐标， 灯杆号
		if(!clientCoordinates.isEmpty() && clientCoordinates!=null){
			
			//定义一个点开始
			String randomStart[] = clientCoordinates.get(0).getString("coordinate").split(",");
			double tlong = Double.valueOf(randomStart[0]);
			double tlat = Double.valueOf(randomStart[1]);
			
			//真正的开始点
			double realStart_x = 0.0 ;
			double realStart_y = 0.0 ;
			String lamp = new String();
			String c_client_id = new String();
			double distance = 0.0;
			
			for(PageData cCoordinate : clientCoordinates){
				String point[] = cCoordinate.getString("coordinate").split(",");
				double slong = Double.valueOf(point[0]);
				double stal = Double.valueOf(point[1]);
				double dis = GetDistance(tlong, tlat, slong, stal);
				
				if(dis >= distance){
					distance = dis;
					realStart_x = slong;
					realStart_y = stal;
					lamp = cCoordinate.getString("lamp_pole_num");
					c_client_id = String.valueOf(cCoordinate.get("c_client_id"));
				}
				
				//System.out.println(tlong+","+tlat+"--"+slong+","+stal+"---"+"distance:"+distance);
			}
			//System.out.println(realStart_x+","+realStart_y+"--"+"---"+"distance:"+distance);
			
			
			List<PageData> sclientidLamp = new ArrayList<PageData>();
			
			for(PageData ccCoordinate : clientCoordinates){
				PageData cpd = new PageData();
				String point[] = ccCoordinate.getString("coordinate").split(",");
				double slong = Double.valueOf(point[0]);
				double stal = Double.valueOf(point[1]);
				double dis = GetDistance(realStart_x, realStart_y, slong, stal);
				cpd.put("dis", dis);
				cpd.put("c_client_id",String.valueOf(ccCoordinate.get("c_client_id")));
				cpd.put("lamp_pole_num", String.valueOf(ccCoordinate.get("lamp_pole_num")));
				
				sclientidLamp.add(cpd);
				
			}
			System.out.println("before"+sclientidLamp);
			//接下来进行排序
			Collections.sort(sclientidLamp, new Comparator<PageData>(){

				//按照dis排序
				public int compare(PageData o1, PageData o2) {
					double dis0 = (double) o1.get("dis");
					double dis1 = (double) o2.get("dis");
					if(dis1 > dis0){
						return -1;
					}else if(dis1 == dis0){
						return 0;
					}else{
						return 1;
					}
				}
			});
			for (int i = 0;i<sclientidLamp.size();i++){
				sclientidLamp.get(i).put("sort_num", i+1);
			}
			
			int number = Integer.valueOf(pd.getString("number"));			//组成员数量	
			PageData group = smartGroupService.getGroup(pd);				//小组详细信息
			String name = group.getString("name");
		    
		    if(!name.contains("智能奇") && !name.contains("智能偶") && number > 1){
		    	group.put("name", name+"智能奇");
				groupService.addGroup(group);
				String odd_id = String.valueOf(group.get("id"));
				System.out.println(group.get("id"));
				group.put("name", name+"智能偶");
				groupService.addGroup(group);
				String even_id = String.valueOf(group.get("id"));
				
				//循环分组
				for(PageData cccCoordinate:sclientidLamp){
					PageData odd = new PageData();
					PageData even = new PageData();
					
					String lamp_pole_num = String.valueOf(cccCoordinate.get("lamp_pole_num"));
					
					int sort_num = Integer.valueOf((int)cccCoordinate.get("sort_num"));
					if(sort_num % 2 ==0){
						even.put("c_term_id", even_id.trim());
						even.put("lamp_pole_num", lamp_pole_num.trim());
						//更新偶
						groupMemService.update(even);
					}else{
						odd.put("c_term_id", odd_id.trim());
						odd.put("lamp_pole_num", lamp_pole_num.trim());
						
						groupMemService.update(odd);
					}
				}
				out.write("success");
		    }
		}
	
		out.close();
	}


	

	
	
}
