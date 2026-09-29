package org.publicallies.lj.jdbc.repository;

import org.publicallies.lj.jdbc.common.LjJdbcRepository;
import org.publicallies.lj.jdbc.model.ReportSnapshotCache;
import org.springframework.stereotype.Repository;

@Repository
public interface ReportSnapshotCacheRepository extends LjJdbcRepository<ReportSnapshotCache, Integer> {

}
