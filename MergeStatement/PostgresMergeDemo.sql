-- PostgresMergeDemo.sql

drop table if exists TargetRelation;

create temp table TargetRelation (
  Id int primary key,
  Val varchar(20)
);

drop table if exists SourceRelation;

create temp table SourceRelation (
  Id int primary key,
  Val varchar(20)
);

insert into TargetRelation
  (Id, Val)
  values
  (1, 'Value 01'),
  (2, 'Value 02'),
  (3, 'Value 03'),
  (4, 'Value 04');
  
insert into SourceRelation 
  (Id, Val)
  values
  (3, 'S Value 03'),
  (4, 'S Value 04'),
  (5, 'S Value 05'),
  (6, 'S Value 06');

merge into TargetRelation as target
  using SourceRelation as source
    on target.Id = source.Id
-- matched rows between the target and the source
when matched then update 
    set Val = target.Val + ' matched'
-- rows from the source that are not matched with any rows of the target
when not matched then insert
    (Id, Val)
	values
	(source.Id, source.Val);

select * from TargetRelation;