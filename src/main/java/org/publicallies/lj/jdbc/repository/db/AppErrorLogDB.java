package org.publicallies.lj.jdbc.repository.db;

import java.util.LinkedHashMap;

import lombok.Getter;
import lombok.Setter;
import org.publicallies.lj.jdbc.common.DbColumn;
import org.publicallies.lj.jdbc.common.RowUnmapper;
import java.sql.SQLException;
import org.publicallies.lj.jdbc.common.EntityDB;
import java.sql.ResultSet;
import java.util.Map;
import java.sql.Timestamp;
import org.springframework.jdbc.core.RowMapper;
import org.publicallies.lj.jdbc.model.AppErrorLog;

/**
 * Table helpers, row mappers and row unmapper for {@link AppErrorLog}.
 */
public class AppErrorLogDB implements EntityDB<AppErrorLog>{

	private static String TABLE_NAME = "APP_ERROR_LOG";

	private static String TABLE_ALIAS = "A_ael_121";

	public static String getTableName()
	{
		return TABLE_NAME;
	}

	public static String getTableAlias()
	{
		return TABLE_NAME + " as " + TABLE_ALIAS;
	}

	public static String getAlias()
	{
		return TABLE_ALIAS;
	}

	public static String selectAllColumns(boolean ... useAlias)
	{
		return (useAlias[0] ? TABLE_ALIAS : TABLE_NAME) + ".*";
	}

	@Override
	public AppErrorLogRowMapper getRowMappers() {
		return new AppErrorLogRowMapper();
	}
	public enum COLUMNS implements DbColumn<AppErrorLog> 
	{
		ID("id", false, ""),
		CREATED_AT("created_at", false, ""),
		USERS_ID("users_id", false, ""),
		ROLE_TYPE("role_type", false, ""),
		HTTP_METHOD("http_method", false, ""),
		REQUEST_PATH("request_path", false, ""),
		QUERY_STRING("query_string", false, ""),
		ROUTE("route", false, ""),
		HANDLER("handler", false, ""),
		PAGE_URL("page_url", false, ""),
		AJAX_FLAG("ajax_flag", false, ""),
		HTTP_STATUS("http_status", false, ""),
		EXCEPTION_CLASS("exception_class", false, ""),
		MESSAGE("message", false, ""),
		STACK_TRACE("stack_trace", false, ""),
		IP("ip", false, ""),
		USER_AGENT("user_agent", false, ""),
		HANDLED_FLAG("handled_flag", false, ""),
		HANDLED_AT("handled_at", false, ""),
		HANDLED_BY_USERS_ID("handled_by_users_id", false, ""),
		;

		@Getter
        @Setter
        private String columnName;


		private boolean jsonFlag;


		@Getter
        private String sqlFunction;

		private COLUMNS (String columnName, boolean jsonFlag, String sqlFunction)
		{
			this.columnName = columnName;
			this.jsonFlag = jsonFlag;
			this.sqlFunction = sqlFunction;
		}

        public boolean getJsonFlag ()
		{
			return this.jsonFlag;
		}

        public String getColumnAlias ()
		{
			return TABLE_ALIAS + "." + this.columnName;
		}

		public String getColumnAliasAsName ()
		{
			return TABLE_ALIAS  + "." + this.columnName + " as " + TABLE_ALIAS + "_" + this.columnName;
		}

		public String getColumnAliasName ()
		{
			return TABLE_ALIAS + "_" + this.columnName;
		}


		@Override
		public Class<AppErrorLogDB> getEntityDBClass() {
			return AppErrorLogDB.class;
		}
	}

	public AppErrorLogDB ()
	{

	}

	public static final RowMapper<AppErrorLog> ROW_MAPPER = new AppErrorLogRowMapper ();
	public static final class  AppErrorLogRowMapper implements RowMapper<AppErrorLog>
	{
		public AppErrorLog mapRow(ResultSet rs, int rowNum) throws SQLException 
		{
			AppErrorLog obj = new AppErrorLog();
			obj.setId(rs.getInt(COLUMNS.ID.getColumnName()));
			if (rs.wasNull()) obj.setId(null);
			obj.setCreatedAt(rs.getTimestamp(COLUMNS.CREATED_AT.getColumnName()));
			if (rs.wasNull()) obj.setCreatedAt(null);
			obj.setUsersId(rs.getInt(COLUMNS.USERS_ID.getColumnName()));
			if (rs.wasNull()) obj.setUsersId(null);
			obj.setRoleType(rs.getString(COLUMNS.ROLE_TYPE.getColumnName()));
			if (rs.wasNull()) obj.setRoleType(null);
			obj.setHttpMethod(rs.getString(COLUMNS.HTTP_METHOD.getColumnName()));
			if (rs.wasNull()) obj.setHttpMethod(null);
			obj.setRequestPath(rs.getString(COLUMNS.REQUEST_PATH.getColumnName()));
			if (rs.wasNull()) obj.setRequestPath(null);
			obj.setQueryString(rs.getString(COLUMNS.QUERY_STRING.getColumnName()));
			if (rs.wasNull()) obj.setQueryString(null);
			obj.setRoute(rs.getString(COLUMNS.ROUTE.getColumnName()));
			if (rs.wasNull()) obj.setRoute(null);
			obj.setHandler(rs.getString(COLUMNS.HANDLER.getColumnName()));
			if (rs.wasNull()) obj.setHandler(null);
			obj.setPageUrl(rs.getString(COLUMNS.PAGE_URL.getColumnName()));
			if (rs.wasNull()) obj.setPageUrl(null);
			obj.setAjaxFlag(rs.getByte(COLUMNS.AJAX_FLAG.getColumnName()));
			if (rs.wasNull()) obj.setAjaxFlag(null);
			obj.setHttpStatus(rs.getInt(COLUMNS.HTTP_STATUS.getColumnName()));
			if (rs.wasNull()) obj.setHttpStatus(null);
			obj.setExceptionClass(rs.getString(COLUMNS.EXCEPTION_CLASS.getColumnName()));
			if (rs.wasNull()) obj.setExceptionClass(null);
			obj.setMessage(rs.getString(COLUMNS.MESSAGE.getColumnName()));
			if (rs.wasNull()) obj.setMessage(null);
			obj.setStackTrace(rs.getString(COLUMNS.STACK_TRACE.getColumnName()));
			if (rs.wasNull()) obj.setStackTrace(null);
			obj.setIp(rs.getString(COLUMNS.IP.getColumnName()));
			if (rs.wasNull()) obj.setIp(null);
			obj.setUserAgent(rs.getString(COLUMNS.USER_AGENT.getColumnName()));
			if (rs.wasNull()) obj.setUserAgent(null);
			obj.setHandledFlag(rs.getByte(COLUMNS.HANDLED_FLAG.getColumnName()));
			if (rs.wasNull()) obj.setHandledFlag(null);
			obj.setHandledAt(rs.getTimestamp(COLUMNS.HANDLED_AT.getColumnName()));
			if (rs.wasNull()) obj.setHandledAt(null);
			obj.setHandledByUsersId(rs.getInt(COLUMNS.HANDLED_BY_USERS_ID.getColumnName()));
			if (rs.wasNull()) obj.setHandledByUsersId(null);
			return obj;
		}
	}

	public static final RowUnmapper<AppErrorLog> ROW_UNMAPPER = new AppErrorLogRowUnmapper ();
	public static final class AppErrorLogRowUnmapper implements RowUnmapper<AppErrorLog>
	{
		public Map<String, Object> mapColumns(AppErrorLog apperrorlog)
		{
			Map<String, Object> mapping = new LinkedHashMap<String, Object>();
			mapping.put(COLUMNS.ID.getColumnName(), apperrorlog.getId());
			if (apperrorlog.getCreatedAt() != null)
				mapping.put(COLUMNS.CREATED_AT.getColumnName(), new Timestamp (apperrorlog.getCreatedAt().getTime()));
			mapping.put(COLUMNS.USERS_ID.getColumnName(), apperrorlog.getUsersId());
			mapping.put(COLUMNS.ROLE_TYPE.getColumnName(), org.publicallies.lj.jdbc.common.CommonUtils.cleanStringForSqlInsertion(apperrorlog.getRoleType()));
			mapping.put(COLUMNS.HTTP_METHOD.getColumnName(), org.publicallies.lj.jdbc.common.CommonUtils.cleanStringForSqlInsertion(apperrorlog.getHttpMethod()));
			mapping.put(COLUMNS.REQUEST_PATH.getColumnName(), org.publicallies.lj.jdbc.common.CommonUtils.cleanStringForSqlInsertion(apperrorlog.getRequestPath()));
			mapping.put(COLUMNS.QUERY_STRING.getColumnName(), org.publicallies.lj.jdbc.common.CommonUtils.cleanStringForSqlInsertion(apperrorlog.getQueryString()));
			mapping.put(COLUMNS.ROUTE.getColumnName(), org.publicallies.lj.jdbc.common.CommonUtils.cleanStringForSqlInsertion(apperrorlog.getRoute()));
			mapping.put(COLUMNS.HANDLER.getColumnName(), org.publicallies.lj.jdbc.common.CommonUtils.cleanStringForSqlInsertion(apperrorlog.getHandler()));
			mapping.put(COLUMNS.PAGE_URL.getColumnName(), org.publicallies.lj.jdbc.common.CommonUtils.cleanStringForSqlInsertion(apperrorlog.getPageUrl()));
			mapping.put(COLUMNS.AJAX_FLAG.getColumnName(), apperrorlog.getAjaxFlag());
			mapping.put(COLUMNS.HTTP_STATUS.getColumnName(), apperrorlog.getHttpStatus());
			mapping.put(COLUMNS.EXCEPTION_CLASS.getColumnName(), org.publicallies.lj.jdbc.common.CommonUtils.cleanStringForSqlInsertion(apperrorlog.getExceptionClass()));
			mapping.put(COLUMNS.MESSAGE.getColumnName(), org.publicallies.lj.jdbc.common.CommonUtils.cleanStringForSqlInsertion(apperrorlog.getMessage()));
			mapping.put(COLUMNS.STACK_TRACE.getColumnName(), org.publicallies.lj.jdbc.common.CommonUtils.cleanStringForSqlInsertion(apperrorlog.getStackTrace()));
			mapping.put(COLUMNS.IP.getColumnName(), org.publicallies.lj.jdbc.common.CommonUtils.cleanStringForSqlInsertion(apperrorlog.getIp()));
			mapping.put(COLUMNS.USER_AGENT.getColumnName(), org.publicallies.lj.jdbc.common.CommonUtils.cleanStringForSqlInsertion(apperrorlog.getUserAgent()));
			mapping.put(COLUMNS.HANDLED_FLAG.getColumnName(), apperrorlog.getHandledFlag());
			if (apperrorlog.getHandledAt() != null)
				mapping.put(COLUMNS.HANDLED_AT.getColumnName(), new Timestamp (apperrorlog.getHandledAt().getTime()));
			mapping.put(COLUMNS.HANDLED_BY_USERS_ID.getColumnName(), apperrorlog.getHandledByUsersId());
			return mapping;
		}
	}

	public static final RowMapper<AppErrorLog> ALIAS_ROW_MAPPER = new AppErrorLogAliasRowMapper ();
	public static final class  AppErrorLogAliasRowMapper implements RowMapper<AppErrorLog>
	{
		public AppErrorLog mapRow(ResultSet rs, int rowNum) throws SQLException 
		{
			AppErrorLog obj = new AppErrorLog();
			obj.setId(rs.getInt(COLUMNS.ID.getColumnAliasName()));
			if (rs.wasNull()) obj.setId(null);
			obj.setCreatedAt(rs.getTimestamp(COLUMNS.CREATED_AT.getColumnAliasName()));
			if (rs.wasNull()) obj.setCreatedAt(null);
			obj.setUsersId(rs.getInt(COLUMNS.USERS_ID.getColumnAliasName()));
			if (rs.wasNull()) obj.setUsersId(null);
			obj.setRoleType(rs.getString(COLUMNS.ROLE_TYPE.getColumnAliasName()));
			if (rs.wasNull()) obj.setRoleType(null);
			obj.setHttpMethod(rs.getString(COLUMNS.HTTP_METHOD.getColumnAliasName()));
			if (rs.wasNull()) obj.setHttpMethod(null);
			obj.setRequestPath(rs.getString(COLUMNS.REQUEST_PATH.getColumnAliasName()));
			if (rs.wasNull()) obj.setRequestPath(null);
			obj.setQueryString(rs.getString(COLUMNS.QUERY_STRING.getColumnAliasName()));
			if (rs.wasNull()) obj.setQueryString(null);
			obj.setRoute(rs.getString(COLUMNS.ROUTE.getColumnAliasName()));
			if (rs.wasNull()) obj.setRoute(null);
			obj.setHandler(rs.getString(COLUMNS.HANDLER.getColumnAliasName()));
			if (rs.wasNull()) obj.setHandler(null);
			obj.setPageUrl(rs.getString(COLUMNS.PAGE_URL.getColumnAliasName()));
			if (rs.wasNull()) obj.setPageUrl(null);
			obj.setAjaxFlag(rs.getByte(COLUMNS.AJAX_FLAG.getColumnAliasName()));
			if (rs.wasNull()) obj.setAjaxFlag(null);
			obj.setHttpStatus(rs.getInt(COLUMNS.HTTP_STATUS.getColumnAliasName()));
			if (rs.wasNull()) obj.setHttpStatus(null);
			obj.setExceptionClass(rs.getString(COLUMNS.EXCEPTION_CLASS.getColumnAliasName()));
			if (rs.wasNull()) obj.setExceptionClass(null);
			obj.setMessage(rs.getString(COLUMNS.MESSAGE.getColumnAliasName()));
			if (rs.wasNull()) obj.setMessage(null);
			obj.setStackTrace(rs.getString(COLUMNS.STACK_TRACE.getColumnAliasName()));
			if (rs.wasNull()) obj.setStackTrace(null);
			obj.setIp(rs.getString(COLUMNS.IP.getColumnAliasName()));
			if (rs.wasNull()) obj.setIp(null);
			obj.setUserAgent(rs.getString(COLUMNS.USER_AGENT.getColumnAliasName()));
			if (rs.wasNull()) obj.setUserAgent(null);
			obj.setHandledFlag(rs.getByte(COLUMNS.HANDLED_FLAG.getColumnAliasName()));
			if (rs.wasNull()) obj.setHandledFlag(null);
			obj.setHandledAt(rs.getTimestamp(COLUMNS.HANDLED_AT.getColumnAliasName()));
			if (rs.wasNull()) obj.setHandledAt(null);
			obj.setHandledByUsersId(rs.getInt(COLUMNS.HANDLED_BY_USERS_ID.getColumnAliasName()));
			if (rs.wasNull()) obj.setHandledByUsersId(null);
			return obj;
		}
	}

	public static StringBuffer getAllColumnAliases ()
	{
		StringBuffer strBuf = new StringBuffer ();
		int i = COLUMNS.values ().length;
		for (COLUMNS c : COLUMNS.values ())
		{
			strBuf.append (c.getColumnAliasAsName ());
			if (--i > 0)
				strBuf.append (", ");
		}
		return strBuf;
	}

	@Override
	public String getTableRawName() {
		return getTableName();
	}
	@Override
	public String getTableFullAlias() {
		return getTableAlias();
	}
	@Override
	public String getTableRawAlias() {
		return getAlias();
	}
	@Override
	public Class<AppErrorLog> getEntityClass() {
		return AppErrorLog.class;
	}
	/* START Do not remove/edit this line. CodeGenerator will preserve any code between start and end tags.*/

	/* END Do not remove/edit this line. CodeGenerator will preserve any code between start and end tags.*/

}