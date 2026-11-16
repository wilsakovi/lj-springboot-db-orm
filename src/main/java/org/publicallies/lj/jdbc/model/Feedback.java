package org.publicallies.lj.jdbc.model;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;
import jakarta.persistence.Lob;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

/**
 * Feedback a user gave right after finishing a feature (Time Logs, MSR, TSP, Query Builder, pre-formatted reports):
 * a 1-5 star rating and a comment, or a skip ({@code skipped_flag = 1}, no rating). A skip or an answer stops the
 * prompt for that feature for 3 months. System Admins review answers and move {@code status} through NEW,
 * ACKNOWLEDGED, WILL_IMPLEMENT, IN_PROGRESS and IMPLEMENTED; {@code history} records each change. Once an answer is
 * IMPLEMENTED, {@code follow_up_pending = 1} asks the user again at their next use, and that answer points back
 * with {@code follow_up_of_id}.
 */

@Setter
@Getter
@Table(name="feedback")
public class Feedback implements Serializable
{

	@Serial
    private static final long serialVersionUID = 1L;

	@Column("id")
	@Id
	private Integer id;

	@Column("created_at")
	@Temporal(TemporalType.TIMESTAMP)
	private Date createdAt = new Date();

	@Column("updated_at")
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatedAt;

	@Column("users_id")
	private Integer usersId;

	@Column("role_type")
	@Size (max = 10)
	private String roleType;

	@Column("term_id")
	private Integer termId;

	@Column("area")
	@Size (max = 30)
	private String area;

	@Column("rating")
	private Byte rating;

	@Column("comment")
	@Size (max = 65535)
	@Lob
	private String comment;

	@Column("page_url")
	@Size (max = 500)
	private String pageUrl;

	@Column("skipped_flag")
	private Byte skippedFlag = 0;

	@Column("status")
	@Size (max = 20)
	private String status;

	@Column("follow_up_pending")
	private Byte followUpPending = 0;

	@Column("follow_up_of_id")
	private Integer followUpOfId;

	@Column("history")
	@Size (max = 65535)
	@Lob
	private String history;

	@Column("last_updated_users_id")
	private Integer lastUpdatedUsersId;


	public Feedback ()
	{

	}

    public boolean isNew ()
	{
		return this.id == null;
	}

    @Override
	public String toString ()
	{
		return ToStringBuilder.reflectionToString (this);
	}

	/* START Do not remove/edit this line. CodeGenerator will preserve any code between start and end tags.*/

	/* END Do not remove/edit this line. CodeGenerator will preserve any code between start and end tags.*/

}
