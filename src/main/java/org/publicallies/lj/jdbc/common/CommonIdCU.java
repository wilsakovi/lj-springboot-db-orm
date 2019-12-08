package org.publicallies.lj.jdbc.common;

import java.util.Date;

public interface CommonIdCU<ID extends Number> {
	ID getId();
	Date getCreatedAt();
	Date getUpdatedAt();
	
	void setId(ID id);
	void setCreatedAt(Date date);
	void setUpdatedAt(Date  date);
}
