package org.publicallies.lj.jdbc.repository.db;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.LinkedHashMap;
import java.util.Map;
import org.publicallies.lj.jdbc.common.DbColumn;
import org.publicallies.lj.jdbc.common.EntityDB;
import org.publicallies.lj.jdbc.common.RowUnmapper;
import org.publicallies.lj.jdbc.model.ReportSnapshotCache;
import org.springframework.jdbc.core.RowMapper;

public class ReportSnapshotCacheDB implements EntityDB<ReportSnapshotCache> {

	private static String TABLE_NAME = "REPORT_SNAPSHOT_CACHE";

	private static String TABLE_ALIAS = "A_rsc_120";

	public static String getTableName() {
		return TABLE_NAME;
	}

	public static String getTableAlias() {
		return TABLE_NAME + " as " + TABLE_ALIAS;
	}

	public static String getAlias() {
		return TABLE_ALIAS;
	}

	public static String selectAllColumns(boolean... useAlias) {
		return (useAlias[0] ? TABLE_ALIAS : TABLE_NAME) + ".*";
	}

	@Override
	public ReportSnapshotCacheRowMapper getRowMappers() {
		return new ReportSnapshotCacheRowMapper();
	}

	public enum COLUMNS implements DbColumn<ReportSnapshotCache> {
		ID("id", false, ""),
		REPORT_TYPE("report_type", false, ""),
		TERM_ID("term_id", false, ""),
		SITE_PROFILE_ID("site_profile_id", false, ""),
		SITE_ID("site_id", false, ""),
		PAYLOAD_JSON("payload_json", false, ""),
		GENERATED_AT("generated_at", false, ""),
		GENERATED_BY("generated_by", false, ""),
		;

		private String columnName;
		private boolean jsonFlag;
		private String sqlFunction;

		private COLUMNS(String columnName, boolean jsonFlag, String sqlFunction) {
			this.columnName = columnName;
			this.jsonFlag = jsonFlag;
			this.sqlFunction = sqlFunction;
		}

		public void setColumnName(String columnName) {
			this.columnName = columnName;
		}

		public String getColumnName() {
			return this.columnName;
		}

		public boolean getJsonFlag() {
			return this.jsonFlag;
		}

		public String getSqlFunction() {
			return this.sqlFunction;
		}

		public String getColumnAlias() {
			return TABLE_ALIAS + "." + this.columnName;
		}

		public String getColumnAliasAsName() {
			return TABLE_ALIAS + "." + this.columnName + " as " + TABLE_ALIAS + "_" + this.columnName;
		}

		public String getColumnAliasName() {
			return TABLE_ALIAS + "_" + this.columnName;
		}

		@Override
		public Class<ReportSnapshotCacheDB> getEntityDBClass() {
			return ReportSnapshotCacheDB.class;
		}
	}

	public ReportSnapshotCacheDB() {
	}

	public static final RowMapper<ReportSnapshotCache> ROW_MAPPER = new ReportSnapshotCacheRowMapper();

	public static final class ReportSnapshotCacheRowMapper implements RowMapper<ReportSnapshotCache> {
		public ReportSnapshotCache mapRow(ResultSet rs, int rowNum) throws SQLException {
			ReportSnapshotCache obj = new ReportSnapshotCache();
			obj.setId(rs.getInt(COLUMNS.ID.getColumnName()));
			if (rs.wasNull())
				obj.setId(null);
			obj.setReportType(rs.getString(COLUMNS.REPORT_TYPE.getColumnName()));
			if (rs.wasNull())
				obj.setReportType(null);
			obj.setTermId(rs.getShort(COLUMNS.TERM_ID.getColumnName()));
			if (rs.wasNull())
				obj.setTermId(null);
			obj.setSiteProfileId(rs.getInt(COLUMNS.SITE_PROFILE_ID.getColumnName()));
			if (rs.wasNull())
				obj.setSiteProfileId(null);
			obj.setSiteId(rs.getShort(COLUMNS.SITE_ID.getColumnName()));
			if (rs.wasNull())
				obj.setSiteId(null);
			obj.setPayloadJson(rs.getString(COLUMNS.PAYLOAD_JSON.getColumnName()));
			if (rs.wasNull())
				obj.setPayloadJson(null);
			obj.setGeneratedAt(rs.getTimestamp(COLUMNS.GENERATED_AT.getColumnName()));
			if (rs.wasNull())
				obj.setGeneratedAt(null);
			obj.setGeneratedBy(rs.getString(COLUMNS.GENERATED_BY.getColumnName()));
			if (rs.wasNull())
				obj.setGeneratedBy(null);
			return obj;
		}
	}

	public static final RowUnmapper<ReportSnapshotCache> ROW_UNMAPPER = new ReportSnapshotCacheRowUnmapper();

	public static final class ReportSnapshotCacheRowUnmapper implements RowUnmapper<ReportSnapshotCache> {
		public Map<String, Object> mapColumns(ReportSnapshotCache row) {
			Map<String, Object> mapping = new LinkedHashMap<String, Object>();
			mapping.put(COLUMNS.ID.getColumnName(), row.getId());
			mapping.put(COLUMNS.REPORT_TYPE.getColumnName(),
					org.publicallies.lj.jdbc.common.CommonUtils.cleanStringForSqlInsertion(row.getReportType()));
			mapping.put(COLUMNS.TERM_ID.getColumnName(), row.getTermId());
			mapping.put(COLUMNS.SITE_PROFILE_ID.getColumnName(), row.getSiteProfileId());
			mapping.put(COLUMNS.SITE_ID.getColumnName(), row.getSiteId());
			mapping.put(COLUMNS.PAYLOAD_JSON.getColumnName(),
					org.publicallies.lj.jdbc.common.CommonUtils.cleanStringForSqlInsertion(row.getPayloadJson()));
			if (row.getGeneratedAt() != null)
				mapping.put(COLUMNS.GENERATED_AT.getColumnName(), new Timestamp(row.getGeneratedAt().getTime()));
			mapping.put(COLUMNS.GENERATED_BY.getColumnName(),
					org.publicallies.lj.jdbc.common.CommonUtils.cleanStringForSqlInsertion(row.getGeneratedBy()));
			return mapping;
		}
	}

	public static final RowMapper<ReportSnapshotCache> ALIAS_ROW_MAPPER = new ReportSnapshotCacheAliasRowMapper();

	public static final class ReportSnapshotCacheAliasRowMapper implements RowMapper<ReportSnapshotCache> {
		public ReportSnapshotCache mapRow(ResultSet rs, int rowNum) throws SQLException {
			ReportSnapshotCache obj = new ReportSnapshotCache();
			obj.setId(rs.getInt(COLUMNS.ID.getColumnAliasName()));
			if (rs.wasNull())
				obj.setId(null);
			obj.setReportType(rs.getString(COLUMNS.REPORT_TYPE.getColumnAliasName()));
			if (rs.wasNull())
				obj.setReportType(null);
			obj.setTermId(rs.getShort(COLUMNS.TERM_ID.getColumnAliasName()));
			if (rs.wasNull())
				obj.setTermId(null);
			obj.setSiteProfileId(rs.getInt(COLUMNS.SITE_PROFILE_ID.getColumnAliasName()));
			if (rs.wasNull())
				obj.setSiteProfileId(null);
			obj.setSiteId(rs.getShort(COLUMNS.SITE_ID.getColumnAliasName()));
			if (rs.wasNull())
				obj.setSiteId(null);
			obj.setPayloadJson(rs.getString(COLUMNS.PAYLOAD_JSON.getColumnAliasName()));
			if (rs.wasNull())
				obj.setPayloadJson(null);
			obj.setGeneratedAt(rs.getTimestamp(COLUMNS.GENERATED_AT.getColumnAliasName()));
			if (rs.wasNull())
				obj.setGeneratedAt(null);
			obj.setGeneratedBy(rs.getString(COLUMNS.GENERATED_BY.getColumnAliasName()));
			if (rs.wasNull())
				obj.setGeneratedBy(null);
			return obj;
		}
	}

	public static StringBuffer getAllColumnAliases() {
		StringBuffer strBuf = new StringBuffer();
		int i = COLUMNS.values().length;
		for (COLUMNS c : COLUMNS.values()) {
			strBuf.append(c.getColumnAliasAsName());
			if (--i > 0)
				strBuf.append(", ");
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
	public Class<ReportSnapshotCache> getEntityClass() {
		return ReportSnapshotCache.class;
	}

	/* START Do not remove/edit this line. CodeGenerator will preserve any code between start and end tags.*/

	/* END Do not remove/edit this line. CodeGenerator will preserve any code between start and end tags.*/

}
