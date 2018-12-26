with parametros as (
    select CAST('chemistry.stackexchange.com' as text) as comm_name
    
),
answers as (
    select 
    p.id as id,
    p.ari_text, 
    p.score,
    p.characters_text as characters_count,
    p.coleman_liau_text,
    p.complexwords_text,
    p.flesch_kincaid_text,
    p.flesch_reading_text,
    p.gunning_fog_text,
    p.sentences_text,
    p.smog_index_text,
    p.smog_text,
    p.syllables_text,
    p.words_text,
    p.view_count,
    p.body,
    case
        when p.score > 0 then 'yes'
        else 'no'
    end as good,
    characters_text
    from post p 
    inner join community c on c.id = p.id_community and c."name" in (select * from parametros)
    and p.post_type = 2
    and p.ari_text is not null
)
select 
    A.id, 
    A.ari_text, 
    A.score,
    A.characters_count,
    A.coleman_liau_text,
    A.complexwords_text,
    A.flesch_kincaid_text,
    A.flesch_reading_text,
    A.gunning_fog_text,
    A.sentences_text,
    A.smog_index_text,
    A.smog_text,
    A.syllables_text,
    A.words_text,
    A.good,
    (A.httpCount + A.httpsCount) as total_links,
    A.doicount,
    A.selfreferencecount,
    A.wikipediacount,
    A.naturecount,
    A.comm_name
from (
    select a.*,
    pa.*,
    (length(a.body) - length(replace(a.body, 'http:', ''))) / length('http:') as httpCount,
    (length(a.body) - length(replace(a.body, 'https:', ''))) / length('https:') as httpsCount,
    (length(a.body) - length(replace(a.body, 'dx.doi.org', ''))) / length('dx.doi.org') as doiCount,
    (length(a.body) - length(replace(a.body, 'en.wikipedia.org', ''))) / length('en.wikipedia.org') as wikipediaCount,
    (length(a.body) - length(replace(a.body, 'www.nature.com', ''))) / length('www.nature.com') as natureCount, 
    (length(a.body) - length(replace(a.body, 'biology.stackexchange.com', ''))) / length('biology.stackexchange.com') as selfReferenceCount
    
    from answers a
    inner join parametros pa on 1=1
   


)A 


