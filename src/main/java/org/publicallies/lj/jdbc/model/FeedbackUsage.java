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
 * How many times a user finished a feature since they were last asked for feedback about it. Each user is asked on
 * their 1st, 2nd or 3rd use (a stable random third per role), so the count is reset whenever they answer or skip.
 */

@Setter
@Getter
@Table(name="feedback_usage")
public class FeedbackUsage implements Serializable
{

	@Serial
    private static final long serialVersionUID = 1L;

	@Column("id")
	@Id
	private Integer id;

	@Column("users_id")
	private Integer usersId;

	@Column("area")
	@Size (max = 30)
	private String area;

	@Column("use_count")
	private Integer useCount = 0;

	@Column("updated_at")
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatedAt;


	public FeedbackUsage ()
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
