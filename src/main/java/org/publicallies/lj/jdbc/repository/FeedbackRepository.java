package org.publicallies.lj.jdbc.repository;

import org.publicallies.lj.jdbc.common.LjJdbcRepository;
import org.springframework.stereotype.Repository;
import org.publicallies.lj.jdbc.model.Feedback;

/**
 * Repository for {@link Feedback}.
 */
@Repository
public interface FeedbackRepository extends LjJdbcRepository<Feedback, Integer>
{

}
