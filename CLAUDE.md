# CLAUDE.md — leadership-journal-db-orm

Data-access JAR (`org.publicallies:leadership-journal-db-orm:3.0.0`; Spring Boot 3.4.3 parent; Spring Data JDBC, Hibernate 6.6 annotations, MySQL connector) for the Leadership Journal web app at `C:\Applications\src\publicallies-lj`. It contains no business logic: controllers, workflows, SQL helpers and domain documentation all live in the web app. Read that repo's CLAUDE.md for what the tables mean.

## Layout (`src/main/java/org/publicallies/lj/jdbc/`)

- `model/`: one class per MySQL table (~121). `@Table(name=...)`, `@Id`, `@Column("snake_case")`, and Jakarta validation where useful. This is the authoritative column list for the LJ schema; the web app has no schema file.
  - Every class has explicit getters/setters, `isNew()` and `toString()` via `ToStringBuilder.reflectionToString`. Tabs for indentation.
  - Entities with audit columns implement `CommonIdCU` (id/created_at/updated_at), `CommonIdCUH` (+`history`) or `CommonIdCUHLu` (+`last_updated_users_id`).
  - `@Transient` fields (e.g. `PartnerSupervisor.users`) are filled by the web app and not persisted.
- `repository/`: `XxxRepository extends LjJdbcRepository<Xxx, Integer>`, annotated `@Repository`. Almost always empty (no derived queries or `@Query`). `LjJdbcRepository` = `ListCrudRepository` + `findOne(id)` (null when missing, null-safe) + `findAllAndSort` / `findAllAndSortDesc`.
- `repository/db/`: `XxxDB implements EntityDB<Xxx>`, used by the web app's hand-written JdbcTemplate SQL. Each has:
  - table name/alias helpers (`getTableName()`, `getTableAlias()`, `selectAllColumns(...)`)
  - a `COLUMNS` enum (`DbColumn`: column name, a JSON flag, alias names)
  - `ROW_MAPPER`, an alias row mapper, and a `RowUnmapper` (entity → column map for inserts and updates). The unmapper passes strings through `CommonUtils.cleanStringForSqlInsertion` (converts smart quotes) and wraps dates in `Timestamp`.
- `common/`: the interfaces above, `DbColumn`, `EntityDB`, `RowUnmapper`, `CommonUtils`.

## Changing the schema

The classes were originally produced by a "Spring Data Jdbc code generator", but in practice columns are now added **by hand**. Follow the pattern of commit `86c6662` (`users.password_lockout_stage`).

1. Write the SQL and append it with a date banner to `src/test/resources/sqlchanges.sql` here, the one schema change log. Apply it to each environment manually. Don't also add a file to the web app's `docs/sql/`; the files there are older changes kept for history.
2. In `model/Xxx.java`: add the field with `@Column("...")` (plus `@Temporal(TemporalType.TIMESTAMP)` for datetimes, `@Lob`/`@Size` for text) and a getter/setter, in column order.
3. In `repository/db/XxxDB.java`, update **all four** places together: the `COLUMNS` enum entry; both row mappers (`rs.getX(...)` followed by `if (rs.wasNull()) obj.setX(null);`); and the `RowUnmapper` `mapping.put(...)`. Missing one means silently dropped reads or writes on the hand-written SQL path.
4. A new table needs an entity, a repository and a DB class following an existing trio.
5. Run `mvn install`, then rebuild the web app. Bump the version in both POMs only for a release.

Hand-written helpers go only between the `/* START Do not remove/edit this line... */` and `/* END ... */` markers at the bottom of a class, so they survive any regeneration.

## Conventions

- Flags are `Byte`/`Integer` 0/1. `active_flag` exists on many tables, but whether a query honors it depends on the web app's SQL. On `ally`, `partner_supervisor` and `staff`, `ally_status`/`active_flag`/`active_status` are logical deletion; `role_disabled_flag` (1 = disabled by a System Admin) is the separate access switch.
- Status codes are short strings (`AP`, `PD`, `RT`... see the web app's `ReportStatusEnum`). Multi-valued columns are JSON arrays stored as `String` (`partner_ids`, `site_ids`, `staff_type`, `servicing_sites`, `race_ids`).
- Datetimes are `java.util.Date`. The web app registers Byte↔Boolean and Date↔LocalDateTime converters in its `JdbcConfig`.
- Git: same conventions as the web app (`Issue NNN: ...` commits, PRs).
