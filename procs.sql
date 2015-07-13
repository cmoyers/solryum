use drupal;

delimiter //
drop procedure if exists solr_taxonomies_update
//
create procedure solr_taxonomies_update()
begin
      set @authors_vid = 3;
      set @dates_vid = 4;


      /* authors.  */
      insert into term_data (vid, name)
      select distinct  @authors_vid, bcd.name
      from biblio_contributor_data bcd
            left join term_data td on bcd.name = td.name and td.vid = @authors_vid
      where td.name is null;

      insert into term_hierarchy (tid, parent)
      select tid, 0
      from term_data
      where vid = @authors_vid
            and tid not in (select tid from term_hierarchy);

      insert ignore into term_node (nid, vid, tid)
      select distinct bc.nid, n.vid, t.tid
      from term_data t
            inner join biblio_contributor_data bcd on t.name = bcd.name
            inner join biblio_contributor bc on bcd.cid = bc.cid
            inner join node n on bc.nid = n.nid
      where t.vid = @authors_vid;


      /* years */
      insert into term_data (vid, name)
      select distinct  @dates_vid, b.biblio_year
      from biblio b
            left join term_data td on b.biblio_year = td.name and td.vid = @dates_vid
      where td.name is null;

      insert into term_hierarchy (tid, parent)
      select tid, 0
      from term_data
      where vid = @dates_vid
            and tid not in (select tid from term_hierarchy);

      insert ignore into term_node (nid, vid, tid)
      select distinct b.nid, n.vid, t.tid
      from term_data t
            inner join biblio b on t.name = b.biblio_year
            inner join node n on b.nid = n.nid
      where t.vid = @dates_vid;

end
//
drop procedure if exists solr_taxonomies_reload
//
create procedure solr_taxonomies_reload()
begin
      set @authors_vid = 3;
      set @dates_vid = 4;

      /* clear out old data for authors, then rebuild */
      delete from term_hierarchy where tid in (select tid from term_data where vid = @authors_vid);
      delete from term_data where vid = @authors_vid;

      insert into term_data (vid, name)
      select distinct  @authors_vid, bcd.name
      from biblio_contributor_data bcd;

      insert into term_hierarchy (tid, parent)
      select tid, 0
      from term_data
      where vid = @authors_vid;

      insert ignore into term_node (nid, vid, tid)
      select distinct bc.nid, n.vid, t.tid
      from term_data t
            inner join biblio_contributor_data bcd on t.name = bcd.name
            inner join biblio_contributor bc on bcd.cid = bc.cid
            inner join node n on bc.nid = n.nid
      where t.vid = @authors_vid;

      /* clear out old data for years, then rebuild */
      delete from term_hierarchy where tid in (select tid from term_data where vid = @dates_vid);
      delete from term_data where vid = @dates_vid;
      
      insert into term_data (vid, name)
      select distinct  @dates_vid, b.biblio_year
      from biblio b;

      insert into term_hierarchy (tid, parent)
      select tid, 0
      from term_data
      where vid = @dates_vid;
      
      insert ignore into term_node (nid, vid, tid)
      select distinct b.nid, n.vid, t.tid
      from term_data t
            inner join biblio b on t.name = b.biblio_year
            inner join node n on b.nid = n.nid
      where t.vid = @dates_vid;

end
//
delimiter ;

