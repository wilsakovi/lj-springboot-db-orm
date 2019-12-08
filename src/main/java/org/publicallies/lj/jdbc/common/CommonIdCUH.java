package org.publicallies.lj.jdbc.common;

public interface CommonIdCUH<ID extends Number> extends CommonIdCU<ID> {
	String getHistory();
	void setHistory(String  history);
}
