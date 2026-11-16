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
import org.publicallies.lj.jdbc.model.FeedbackUsage;

/**
 * Table helpers, row mappers and row unmapper for {@link FeedbackUsage}.
 */
public class FeedbackUsageDB implements EntityDB<FeedbackUsage>{

	private static String TABLE_NAME = "FEEDBACK_USAGE";

	private static String TABLE_ALIAS = "A_feu_123";

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
	public FeedbackUsageRowMapper getRowMappers() {
		return new FeedbackUsageRowMapper();
	}
	public enum COLUMNS implements DbColumn<FeedbackUsage> 
	{
		ID("id", false, ""),
		USERS_ID("users_id", false, ""),
		AREA("area", false, ""),
		USE_COUNT("use_count", false, ""),
		UPDATED_AT("updated_at", false, ""),
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
		public Class<FeedbackUsageDB> getEntityDBClass() {
			return FeedbackUsageDB.class;
		}
	}

	public FeedbackUsageDB ()
	{

	}

	public static final RowMapper<FeedbackUsage> ROW_MAPPER = new FeedbackUsageRowMapper ();
	public static final class  FeedbackUsageRowMapper implements RowMapper<FeedbackUsage>
	{
		public FeedbackUsage mapRow(ResultSet rs, int rowNum) throws SQLException 
		{
			FeedbackUsage obj = new FeedbackUsage();
			obj.setId(rs.getInt(COLUMNS.ID.getColumnName()));
			if (rs.wasNull()) obj.setId(null);
			obj.setUsersId(rs.getInt(COLUMNS.USERS_ID.getColumnName()));
			if (rs.wasNull()) obj.setUsersId(null);
			obj.setArea(rs.getString(COLUMNS.AREA.getColumnName()));
			if (rs.wasNull()) obj.setArea(null);
			obj.setUseCount(rs.getInt(COLUMNS.USE_COUNT.getColumnName()));
			if (rs.wasNull()) obj.setUseCount(null);
			obj.setUpdatedAt(rs.getTimestamp(COLUMNS.UPDATED_AT.getColumnName()));
			if (rs.wasNull()) obj.setUpdatedAt(null);
			return obj;
		}
	}

	public static final RowUnmapper<FeedbackUsage> ROW_UNMAPPER = new FeedbackUsageRowUnmapper ();
	public static final class FeedbackUsageRowUnmapper implements RowUnmapper<FeedbackUsage>
	{
		public Map<String, Object> mapColumns(FeedbackUsage feedbackusage)
		{
			Map<String, Object> mapping = new LinkedHashMap<String, Object>();
			mapping.put(COLUMNS.ID.getColumnName(), feedbackusage.getId());
			mapping.put(COLUMNS.USERS_ID.getColumnName(), feedbackusage.getUsersId());
			mapping.put(COLUMNS.AREA.getColumnName(), org.publicallies.lj.jdbc.common.CommonUtils.cleanStringForSqlInsertion(feedbackusage.getArea()));
			mapping.put(COLUMNS.USE_COUNT.getColumnName(), feedbackusage.getUseCount());
			if (feedbackusage.getUpdatedAt() != null)
				mapping.put(COLUMNS.UPDATED_AT.getColumnName(), new Timestamp (feedbackusage.getUpdatedAt().getTime()));
			return mapping;
		}
	}

	public static final RowMapper<FeedbackUsage> ALIAS_ROW_MAPPER = new FeedbackUsageAliasRowMapper ();
	public static final class  FeedbackUsageAliasRowMapper implements RowMapper<FeedbackUsage>
	{
		public FeedbackUsage mapRow(ResultSet rs, int rowNum) throws SQLException 
		{
			FeedbackUsage obj = new FeedbackUsage();
			obj.setId(rs.getInt(COLUMNS.ID.getColumnAliasName()));
			if (rs.wasNull()) obj.setId(null);
			obj.setUsersId(rs.getInt(COLUMNS.USERS_ID.getColumnAliasName()));
			if (rs.wasNull()) obj.setUsersId(null);
			obj.setArea(rs.getString(COLUMNS.AREA.getColumnAliasName()));
			if (rs.wasNull()) obj.setArea(null);
			obj.setUseCount(rs.getInt(COLUMNS.USE_COUNT.getColumnAliasName()));
			if (rs.wasNull()) obj.setUseCount(null);
			obj.setUpdatedAt(rs.getTimestamp(COLUMNS.UPDATED_AT.getColumnAliasName()));
			if (rs.wasNull()) obj.setUpdatedAt(null);
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
	public Class<FeedbackUsage> getEntityClass() {
		return FeedbackUsage.class;
	}
	/* START Do not remove/edit this line. CodeGenerator will preserve any code between start and end tags.*/

	/* END Do not remove/edit this line. CodeGenerator will preserve any code between start and end tags.*/

}