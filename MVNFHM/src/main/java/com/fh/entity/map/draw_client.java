package com.fh.entity.map;

import java.util.ArrayList;

public class draw_client {
	public int takeid;
	public ArrayList<Integer> drawid=new ArrayList<Integer>();
	public int bright;
	
	public int getBright() {
		return bright;
	}
	public void setBright(int bright) {
		this.bright = bright;
	}
	public int getTakeid() {
		return takeid;
	}
	public void setTakeid(int takeid) {
		this.takeid = takeid;
	}
	public ArrayList<Integer> getDrawid() {
		return drawid;
	}
	public void setDrawid(ArrayList<Integer> drawid) {
		this.drawid = drawid;
	}
	

}
