package org.publicallies.lj.jdbc.model;

import java.io.Serializable;
import java.util.Date;
import jakarta.persistence.Lob;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

/**
 * Cached dashboard / report payload keyed by report type, term, site profile, and site.
 */
@Table(name = "report_snapshot_cache")
public class ReportSnapshotCache implements Serializable {

	private static final long serialVersionUID = 1L;

	@Column("id")
	@Id
	private Integer id;

	@Column("report_type")
	@NotEmpty
	@Size(max = 64)
	private String reportType;

	@Column("term_id")
	@NotNull
	private Short termId;

	@Column("site_profile_id")
	@NotNull
	private Integer siteProfileId;

	@Column("site_id")
	@NotNull
	private Short siteId;

	@Column("payload_json")
	@NotEmpty
	@Lob
	private String payloadJson;

	@Column("generated_at")
	@Temporal(TemporalType.TIMESTAMP)
	@NotNull
	private Date generatedAt;

	@Column("generated_by")
	@NotEmpty
	@Size(max = 255)
	private String generatedBy;

	public ReportSnapshotCache() {
	}

	public Integer getId() {
		return this.id;
	}

	public boolean isNew() {
		return this.id == null;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public void setReportType(String reportType) {
		this.reportType = reportType;
	}

	public String getReportType() {
		return this.reportType;
	}

	public void setTermId(Short termId) {
		this.termId = termId;
	}

	public Short getTermId() {
		return this.termId;
	}

	public void setSiteProfileId(Integer siteProfileId) {
		this.siteProfileId = siteProfileId;
	}

	public Integer getSiteProfileId() {
		return this.siteProfileId;
	}

	public void setSiteId(Short siteId) {
		this.siteId = siteId;
	}

	public Short getSiteId() {
		return this.siteId;
	}

	public void setPayloadJson(String payloadJson) {
		this.payloadJson = payloadJson;
	}

	public String getPayloadJson() {
		return this.payloadJson;
	}

	public void setGeneratedAt(Date generatedAt) {
		this.generatedAt = generatedAt;
	}

	public Date getGeneratedAt() {
		return this.generatedAt;
	}

	public void setGeneratedBy(String generatedBy) {
		this.generatedBy = generatedBy;
	}

	public String getGeneratedBy() {
		return this.generatedBy;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}

	/* START Do not remove/edit this line. CodeGenerator will preserve any code between start and end tags.*/

	/* END Do not remove/edit this line. CodeGenerator will preserve any code between start and end tags.*/

}
