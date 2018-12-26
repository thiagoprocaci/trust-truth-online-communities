with parametros as (
    select CAST('biology.stackexchange.com' as text) as comm_name
    
)
select A.id_answer, A.good, A.community, sum(A.cont) as reviews from (
select pt.id as id_answer,  
       p.id as id_history,
       COALESCE(p.id, 0) as cont,
     case
        when pt.score > 0 then 'yes'
        else 'no'
    end as good,
    (select * from parametros) as community
from  post pt 
inner join community c on c.id = pt.id_community and c."name" in (select * from parametros)
left join post_history p on p.id_post_comm = pt.id_post_comm and  p.post_history_type not in (1,2,3)
where 1=1
and pt.post_type = 2
group by pt.id, p.id

) A group by A.id_answer, A.good, A.community
order by 4
