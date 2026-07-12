package org.publicallies.lj.jdbc.common;

public interface DbColumn<T> {

    public String getColumnName();

    public boolean getJsonFlag();

    public String getSqlFunction();

    public String getColumnAlias();

    public String getColumnAliasAsName();

    public String getColumnAliasName();

    public Class<? extends EntityDB<T>> getEntityDBClass();
}
