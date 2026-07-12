package org.publicallies.lj.jdbc.common;

import java.util.Map;

public interface RowUnmapper<T> {
    Map<String, Object> mapColumns(T t);

}
