-- SQLSserverMergeDemo.sql

declare @targetRelation as table (
  Id int primary key,
  Val varchar(20)
);

declare @sourceRelation as table (
  Id int primary key,
  Val varchar(20)
);

insert into @targetRelation
  (Id, Val)
  values
  (1, 'Value 01'),
  (2, 'Value 02'),
  (3, 'Value 03'),
  (4, 'Value 04');

insert into @sourceRelation
  (Id, Val)
  values
  (3, 'S Value 03'),
  (4, 'S Value 04'),
  (5, 'S Value 05'),
  (6, 'S Value 06');

merge into @targetRelation as target
  using @sourceRelation as source
	on target.Id = source.Id
-- matched rows between the target and the source
when matched then update
  set Val = target.Val + ' matched'
-- rows from the source that are not matched with any rows of the target
when not matched by target then insert
  (Id, Val)
  values
  (source.Id, source.Val)
when not matched by source then update
  set Val = target.Val + ' not matched';

select * from @targetRelation;