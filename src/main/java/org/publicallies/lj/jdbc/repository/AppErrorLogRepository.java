package org.publicallies.lj.jdbc.repository;

import org.publicallies.lj.jdbc.common.LjJdbcRepository;
import org.springframework.stereotype.Repository;
import org.publicallies.lj.jdbc.model.AppErrorLog;

/**
 * Repository for {@link AppErrorLog}.
 */
@Repository
public interface AppErrorLogRepository extends LjJdbcRepository<AppErrorLog, Integer>
{

}
