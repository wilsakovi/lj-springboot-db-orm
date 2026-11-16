package org.publicallies.lj.jdbc.repository.db;

import java.util.LinkedHashMap;
import org.publicallies.lj.jdbc.common.DbColumn;
import org.publicallies.lj.jdbc.common.RowUnmapper;
import java.sql.SQLException;
import org.publicallies.lj.jdbc.common.EntityDB;
import java.sql.ResultSet;
import java.util.Map;
import java.sql.Timestamp;
import org.springframework.jdbc.core.RowMapper;
import org.publicallies.lj.jdbc.model.Feedback;

/**
 * Table helpers, row mappers and row unmapper for {@link Feedback}.
 */
public class FeedbackDB implements EntityDB<Feedback>{

	private static String TABLE_NAME = "FEEDBACK";

	private static String TABLE_ALIAS = "A_fee_122";

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
	public FeedbackRowMapper getRowMappers() {
		return new FeedbackRowMapper();
	}
	public enum COLUMNS implements DbColumn<Feedback> 
	{
		ID("id", false, ""),
		CREATED_AT("created_at", false, ""),
		UPDATED_AT("updated_at", false, ""),
		USERS_ID("users_id", false, ""),
		ROLE_TYPE("role_type", false, ""),
		TERM_ID("term_id", false, ""),
		AREA("area", false, ""),
		RATING("rating", false, ""),
		COMMENT("comment", false, ""),
		PAGE_URL("page_url", false, ""),
		SKIPPED_FLAG("skipped_flag", false, ""),
		STATUS("status", false, ""),
		FOLLOW_UP_PENDING("follow_up_pending", false, ""),
		FOLLOW_UP_OF_ID("follow_up_of_id", false, ""),
		HISTORY("history", false, ""),
		LAST_UPDATED_USERS_ID("last_updated_users_id", false, ""),
		;

		private String columnName;


		private boolean jsonFlag;


		private String sqlFunction;

		private COLUMNS (String columnName, boolean jsonFlag, String sqlFunction)
		{
			this.columnName = columnName;
			this.jsonFlag = jsonFlag;
			this.sqlFunction = sqlFunction;
		}

		public void setColumnName (String columnName)
		{
			this.columnName = columnName;
		}

		public String getColumnName ()
		{
			return this.columnName;
		}

		public boolean getJsonFlag ()
		{
			return this.jsonFlag;
		}

		public String getSqlFunction ()
		{
			return this.sqlFunction;
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
		public Class<FeedbackDB> getEntityDBClass() {
			return FeedbackDB.class;
		}
	}

	public FeedbackDB ()
	{

	}

	public static final RowMapper<Feedback> ROW_MAPPER = new FeedbackRowMapper ();
	public static final class  FeedbackRowMapper implements RowMapper<Feedback>
	{
		public Feedback mapRow(ResultSet rs, int rowNum) throws SQLException 
		{
			Feedback obj = new Feedback();
			obj.setId(rs.getInt(COLUMNS.ID.getColumnName()));
			if (rs.wasNull()) obj.setId(null);
			obj.setCreatedAt(rs.getTimestamp(COLUMNS.CREATED_AT.getColumnName()));
			if (rs.wasNull()) obj.setCreatedAt(null);
			obj.setUpdatedAt(rs.getTimestamp(COLUMNS.UPDATED_AT.getColumnName()));
			if (rs.wasNull()) obj.setUpdatedAt(null);
			obj.setUsersId(rs.getInt(COLUMNS.USERS_ID.getColumnName()));
			if (rs.wasNull()) obj.setUsersId(null);
			obj.setRoleType(rs.getString(COLUMNS.ROLE_TYPE.getColumnName()));
			if (rs.wasNull()) obj.setRoleType(null);
			obj.setTermId(rs.getInt(COLUMNS.TERM_ID.getColumnName()));
			if (rs.wasNull()) obj.setTermId(null);
			obj.setArea(rs.getString(COLUMNS.AREA.getColumnName()));
			if (rs.wasNull()) obj.setArea(null);
			obj.setRating(rs.getByte(COLUMNS.RATING.getColumnName()));
			if (rs.wasNull()) obj.setRating(null);
			obj.setComment(rs.getString(COLUMNS.COMMENT.getColumnName()));
			if (rs.wasNull()) obj.setComment(null);
			obj.setPageUrl(rs.getString(COLUMNS.PAGE_URL.getColumnName()));
			if (rs.wasNull()) obj.setPageUrl(null);
			obj.setSkippedFlag(rs.getByte(COLUMNS.SKIPPED_FLAG.getColumnName()));
			if (rs.wasNull()) obj.setSkippedFlag(null);
			obj.setStatus(rs.getString(COLUMNS.STATUS.getColumnName()));
			if (rs.wasNull()) obj.setStatus(null);
			obj.setFollowUpPending(rs.getByte(COLUMNS.FOLLOW_UP_PENDING.getColumnName()));
			if (rs.wasNull()) obj.setFollowUpPending(null);
			obj.setFollowUpOfId(rs.getInt(COLUMNS.FOLLOW_UP_OF_ID.getColumnName()));
			if (rs.wasNull()) obj.setFollowUpOfId(null);
			obj.setHistory(rs.getString(COLUMNS.HISTORY.getColumnName()));
			if (rs.wasNull()) obj.setHistory(null);
			obj.setLastUpdatedUsersId(rs.getInt(COLUMNS.LAST_UPDATED_USERS_ID.getColumnName()));
			if (rs.wasNull()) obj.setLastUpdatedUsersId(null);
			return obj;
		}
	}

	public static final RowUnmapper<Feedback> ROW_UNMAPPER = new FeedbackRowUnmapper ();
	public static final class FeedbackRowUnmapper implements RowUnmapper<Feedback>
	{
		public Map<String, Object> mapColumns(Feedback feedback)
		{
			Map<String, Object> mapping = new LinkedHashMap<String, Object>();
			mapping.put(COLUMNS.ID.getColumnName(), feedback.getId());
			if (feedback.getCreatedAt() != null)
				mapping.put(COLUMNS.CREATED_AT.getColumnName(), new Timestamp (feedback.getCreatedAt().getTime()));
			if (feedback.getUpdatedAt() != null)
				mapping.put(COLUMNS.UPDATED_AT.getColumnName(), new Timestamp (feedback.getUpdatedAt().getTime()));
			mapping.put(COLUMNS.USERS_ID.getColumnName(), feedback.getUsersId());
			mapping.put(COLUMNS.ROLE_TYPE.getColumnName(), org.publicallies.lj.jdbc.common.CommonUtils.cleanStringForSqlInsertion(feedback.getRoleType()));
			mapping.put(COLUMNS.TERM_ID.getColumnName(), feedback.getTermId());
			mapping.put(COLUMNS.AREA.getColumnName(), org.publicallies.lj.jdbc.common.CommonUtils.cleanStringForSqlInsertion(feedback.getArea()));
			mapping.put(COLUMNS.RATING.getColumnName(), feedback.getRating());
			mapping.put(COLUMNS.COMMENT.getColumnName(), org.publicallies.lj.jdbc.common.CommonUtils.cleanStringForSqlInsertion(feedback.getComment()));
			mapping.put(COLUMNS.PAGE_URL.getColumnName(), org.publicallies.lj.jdbc.common.CommonUtils.cleanStringForSqlInsertion(feedback.getPageUrl()));
			mapping.put(COLUMNS.SKIPPED_FLAG.getColumnName(), feedback.getSkippedFlag());
			mapping.put(COLUMNS.STATUS.getColumnName(), org.publicallies.lj.jdbc.common.CommonUtils.cleanStringForSqlInsertion(feedback.getStatus()));
			mapping.put(COLUMNS.FOLLOW_UP_PENDING.getColumnName(), feedback.getFollowUpPending());
			mapping.put(COLUMNS.FOLLOW_UP_OF_ID.getColumnName(), feedback.getFollowUpOfId());
			mapping.put(COLUMNS.HISTORY.getColumnName(), org.publicallies.lj.jdbc.common.CommonUtils.cleanStringForSqlInsertion(feedback.getHistory()));
			mapping.put(COLUMNS.LAST_UPDATED_USERS_ID.getColumnName(), feedback.getLastUpdatedUsersId());
			return mapping;
		}
	}

	public static final RowMapper<Feedback> ALIAS_ROW_MAPPER = new FeedbackAliasRowMapper ();
	public static final class  FeedbackAliasRowMapper implements RowMapper<Feedback>
	{
		public Feedback mapRow(ResultSet rs, int rowNum) throws SQLException 
		{
			Feedback obj = new Feedback();
			obj.setId(rs.getInt(COLUMNS.ID.getColumnAliasName()));
			if (rs.wasNull()) obj.setId(null);
			obj.setCreatedAt(rs.getTimestamp(COLUMNS.CREATED_AT.getColumnAliasName()));
			if (rs.wasNull()) obj.setCreatedAt(null);
			obj.setUpdatedAt(rs.getTimestamp(COLUMNS.UPDATED_AT.getColumnAliasName()));
			if (rs.wasNull()) obj.setUpdatedAt(null);
			obj.setUsersId(rs.getInt(COLUMNS.USERS_ID.getColumnAliasName()));
			if (rs.wasNull()) obj.setUsersId(null);
			obj.setRoleType(rs.getString(COLUMNS.ROLE_TYPE.getColumnAliasName()));
			if (rs.wasNull()) obj.setRoleType(null);
			obj.setTermId(rs.getInt(COLUMNS.TERM_ID.getColumnAliasName()));
			if (rs.wasNull()) obj.setTermId(null);
			obj.setArea(rs.getString(COLUMNS.AREA.getColumnAliasName()));
			if (rs.wasNull()) obj.setArea(null);
			obj.setRating(rs.getByte(COLUMNS.RATING.getColumnAliasName()));
			if (rs.wasNull()) obj.setRating(null);
			obj.setComment(rs.getString(COLUMNS.COMMENT.getColumnAliasName()));
			if (rs.wasNull()) obj.setComment(null);
			obj.setPageUrl(rs.getString(COLUMNS.PAGE_URL.getColumnAliasName()));
			if (rs.wasNull()) obj.setPageUrl(null);
			obj.setSkippedFlag(rs.getByte(COLUMNS.SKIPPED_FLAG.getColumnAliasName()));
			if (rs.wasNull()) obj.setSkippedFlag(null);
			obj.setStatus(rs.getString(COLUMNS.STATUS.getColumnAliasName()));
			if (rs.wasNull()) obj.setStatus(null);
			obj.setFollowUpPending(rs.getByte(COLUMNS.FOLLOW_UP_PENDING.getColumnAliasName()));
			if (rs.wasNull()) obj.setFollowUpPending(null);
			obj.setFollowUpOfId(rs.getInt(COLUMNS.FOLLOW_UP_OF_ID.getColumnAliasName()));
			if (rs.wasNull()) obj.setFollowUpOfId(null);
			obj.setHistory(rs.getString(COLUMNS.HISTORY.getColumnAliasName()));
			if (rs.wasNull()) obj.setHistory(null);
			obj.setLastUpdatedUsersId(rs.getInt(COLUMNS.LAST_UPDATED_USERS_ID.getColumnAliasName()));
			if (rs.wasNull()) obj.setLastUpdatedUsersId(null);
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
	public Class<Feedback> getEntityClass() {
		return Feedback.class;
	}
	/* START Do not remove/edit this line. CodeGenerator will preserve any code between start and end tags.*/

	/* END Do not remove/edit this line. CodeGenerator will preserve any code between start and end tags.*/

}