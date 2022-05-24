create function explain_filter(text) returns setof textlanguage plpgsql asdeclare    ln text;
begin    for ln in execute  1    loop                ln := regexp_replace(ln, '\m\d+\M', 'N', 'g');
                ln := regexp_replace(ln, '\m\d+kB', 'NkB', 'g');
                        CONTINUE WHEN (ln ~ ' +Buffers: .*');
                        CONTINUE WHEN (ln = 'Planning:');
        return next ln;
    end loop;
end;
;
create function explain_filter_to_json(text) returns jsonblanguage plpgsql asdeclare    data text := '';
    ln text;
begin    for ln in execute  1    loop                ln := regexp_replace(ln, '\m\d+\M', '0', 'g');
        data := data || ln;
    end loop;
    return data::jsonb;
end;
;
select explain_filter('explain select * from int8_tbl i8');
select explain_filter('explain (analyze) select * from int8_tbl i8');
select explain_filter('explain (analyze, verbose) select * from int8_tbl i8');
select explain_filter('explain (analyze, buffers, format text) select * from int8_tbl i8');
select explain_filter('explain (analyze, buffers, format json) select * from int8_tbl i8');
select explain_filter('explain (analyze, buffers, format xml) select * from int8_tbl i8');
select explain_filter('explain (analyze, buffers, format yaml) select * from int8_tbl i8');
select explain_filter('explain (buffers, format text) select * from int8_tbl i8');
select explain_filter('explain (buffers, format json) select * from int8_tbl i8');
begin;
set local plan_cache_mode = force_generic_plan;
select true as "OK"  from explain_filter('explain (settings) select * from int8_tbl i8') ln  where ln ~ '^ *Settings: .*plan_cache_mode = ''force_generic_plan''';
select explain_filter_to_json('explain (settings, format json) select * from int8_tbl i8') #> '{0,Settings,plan_cache_mode}';
rollback;
begin isolation level repeatable read;
set parallel_setup_cost=0;
set parallel_tuple_cost=0;
set min_parallel_table_scan_size=0;
set max_parallel_workers_per_gather=4;
select jsonb_pretty(  explain_filter_to_json('explain (analyze, verbose, buffers, format json)                         select * from tenk1 order by tenthous')    #- '{0,Plan,Plans,0,Plans,0,Workers}'    #- '{0,Plan,Plans,0,Workers}'    #- '{0,Plan,Plans,0,Sort Method}'  #- '{0,Plan,Plans,0,Sort Space Type}');
rollback;
