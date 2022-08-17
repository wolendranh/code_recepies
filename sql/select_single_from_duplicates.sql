-- ця штука робить:
-- 1. PARTITION BY creates partitions by `partition_field` (in case if there are duplicates by that field there will be multiple dups in partition)
-- 2. ROW_NUMBER numerate rows in each partition. If there are dups in partition it will look somethiing like
--     |row_number|ups|
--      _______________
--     |1         |123|
--     ----------------
--     |2         |123|
       ----------------
-- 3. WHERE select only single record from dups in partition with `where rn=1`

with data as (
select
*,
ROW_NUMBER() OVER(PARTITION BY partition_field order by partition_field asc) as rn
from `table_name`
)
select * from data where rn = 1