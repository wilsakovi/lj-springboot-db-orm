package org.publicallies.lj.jdbc.common;

import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.data.repository.ListCrudRepository;

public interface LjJdbcRepository<T, ID> extends ListCrudRepository<T, ID> {

    public default T findOne(ID id) {
        if (id == null) {
            return null;
        }
        return findById(id).orElse(null);
    }

    public default List<T> findAllAndSort(Comparator<T> comparator) {
        List<T> list = findAll();
        list = list.stream().sorted(comparator).collect(Collectors.toList());
        return list;
    }

    public default List<T> findAllAndSortDesc(Comparator<T> comparator) {
        return findAll().stream().sorted(comparator.reversed()).collect(Collectors.toList());
    }

}
