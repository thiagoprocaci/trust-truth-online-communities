with parametros as (
    select CAST('chemistry.stackexchange.com' as text) as comm_name
    
),
answers as (
    select 
    p.id,
    levenshtein(SUBSTRING(p.body, 1, 255), SUBSTRING(q.body, 1 , 255)) as levenshtein_text_first_255,
    abs(p.ari_text -  q.ari_text) as diff_ari,
    abs(p.characters_text -  q.characters_text) as diff_characters_text,
    abs(p.coleman_liau_text -  q.coleman_liau_text) as diff_coleman_liau_text,
    abs(p.complexwords_text -  q.complexwords_text) as diff_complexwords_text,
    abs(p.flesch_kincaid_text -  q.flesch_kincaid_text) as diff_flesch_kincaid_text,
    abs(p.flesch_reading_text -  q.flesch_reading_text) as diff_flesch_reading_text,
    abs(p.gunning_fog_text -  q.gunning_fog_text) as diff_gunning_fog_text,
    abs(p.sentences_text -  q.sentences_text) as diff_sentences_text,
    abs(p.smog_index_text -  q.smog_index_text) as diff_smog_index_text,
    abs(p.smog_text -  q.smog_text) as diff_smog_text,
    abs(p.syllables_text -  q.syllables_text) as diff_syllables_text,
    abs(p.words_text -  q.words_text) as diff_words_text,    
    
    -- q.*,
    case
        when p.score > 0 then 'yes'
        else 'no'
    end as good
    from post p 
    inner join community c on c.id = p.id_community and c."name" in (select * from parametros)
    inner join post q on q.id_post_comm = p.parent_post_comm_id
    and p.post_type = 2
    and p.ari_text is not null
    and q.ari_text is not null
) 
select * from answers 
inner join parametros on 1=1


* 
