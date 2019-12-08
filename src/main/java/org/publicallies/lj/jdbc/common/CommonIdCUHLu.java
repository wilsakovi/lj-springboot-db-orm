package org.publicallies.lj.jdbc.common;

public interface CommonIdCUHLu<ID extends Number> extends CommonIdCUH<ID> {
	void setLastUpdatedUsersId (Integer lastUpdatedUsersId);
	Integer getLastUpdatedUsersId ();
}
