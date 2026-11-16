package org.publicallies.lj.jdbc.repository;

import org.publicallies.lj.jdbc.common.LjJdbcRepository;
import org.springframework.stereotype.Repository;
import org.publicallies.lj.jdbc.model.FeedbackUsage;

/**
 * Repository for {@link FeedbackUsage}.
 */
@Repository
public interface FeedbackUsageRepository extends LjJdbcRepository<FeedbackUsage, Integer>
{

}
