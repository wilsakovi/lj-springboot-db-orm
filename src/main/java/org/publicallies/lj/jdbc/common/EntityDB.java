package org.publicallies.lj.jdbc.common;

import org.springframework.jdbc.core.RowMapper;

public interface EntityDB<T> {
    public String getTableRawName();

    public String getTableFullAlias();

    public String getTableRawAlias();

    public Class<T> getEntityClass();

    public RowMapper<T> getRowMappers();
}
