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
 * One request that ended in an unhandled exception or an HTTP 5xx response (the user saw "An error occurred while
 * processing the request" or the error page). Written by the web app's error capture filter; a System Admin
 * marks it handled from Dashboards > System > Application errors.
 */

@Setter
@Getter
@Table(name="app_error_log")
public class AppErrorLog implements Serializable
{

	@Serial
    private static final long serialVersionUID = 1L;

	@Column("id")
	@Id
	private Integer id;

	@Column("created_at")
	@Temporal(TemporalType.TIMESTAMP)
	private Date createdAt = new Date();

	@Column("users_id")
	private Integer usersId;

	@Column("role_type")
	@Size (max = 10)
	private String roleType;

	@Column("http_method")
	@Size (max = 10)
	private String httpMethod;

	@Column("request_path")
	@Size (max = 500)
	private String requestPath;

	@Column("query_string")
	@Size (max = 1000)
	private String queryString;

	@Column("route")
	@Size (max = 300)
	private String route;

	@Column("handler")
	@Size (max = 200)
	private String handler;

	@Column("page_url")
	@Size (max = 500)
	private String pageUrl;

	@Column("ajax_flag")
	private Byte ajaxFlag;

	@Column("http_status")
	private Integer httpStatus;

	@Column("exception_class")
	@Size (max = 255)
	private String exceptionClass;

	@Column("message")
	@Size (max = 1000)
	private String message;

	@Column("stack_trace")
	@Size (max = 65535)
	@Lob
	private String stackTrace;

	@Column("ip")
	@Size (max = 64)
	private String ip;

	@Column("user_agent")
	@Size (max = 500)
	private String userAgent;

	@Column("handled_flag")
	private Byte handledFlag = 0;

	@Column("handled_at")
	@Temporal(TemporalType.TIMESTAMP)
	private Date handledAt;

	@Column("handled_by_users_id")
	private Integer handledByUsersId;


	public AppErrorLog ()
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
