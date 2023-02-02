create user if not exists 'koins'@'%' identified with mysql_native_password by 'lkchpy91';
grant alter,create,delete,drop,index,insert,lock tables,references,select,update,trigger,create temporary tables,alter routine,create routine,execute on *.* to 'koins'@'%';

create user if not exists 'koins_read'@'%' identified with mysql_native_password by 'lkchpy91';
grant select on *.* to 'koins_read'@'%';

# Geo
create database if not exists a_geo;

# Trunk(Main)
create database if not exists wl_trunk_main;
create database if not exists wl_trunk_control;
create database if not exists wl_trunk_xa;
create database if not exists wl_trunk_shard_0;
create database if not exists wl_trunk_shard_1;

# Trunk(Test)
create database if not exists wl_trunk_test_main;
create database if not exists wl_trunk_test_geo;
create database if not exists wl_trunk_test_shard_0;
create database if not exists wl_trunk_test_shard_1;
create database if not exists wl_trunk_test_create;

# Stable(Main)
create database if not exists wl_stable_main;
create database if not exists wl_stable_control;
create database if not exists wl_stable_xa;
create database if not exists wl_stable_shard_0;
create database if not exists wl_stable_shard_1;

# Stable(Test)
create database if not exists wl_stable_test_main;
create database if not exists wl_stable_test_geo;
create database if not exists wl_stable_test_shard_0;
create database if not exists wl_stable_test_shard_1;
create database if not exists wl_stable_test_create;

flush privileges;
