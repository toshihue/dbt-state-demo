with source as (

    select * from {{ source('movie_reviews', 'raw_movie_reviews') }}

),

ranked as (

    select
        id,
        movie_id,
        response_time,
        review_text,
        sentiment_value,
        row_number() over (
            partition by id
            order by response_time desc, movie_id desc
        ) as row_num
    from source

),

renamed as (

    select
        id as movie_review_id,
        movie_id,
        response_time as review_time,
        review_text as review_txt,
        case
            when sentiment_value = 0 then -1
            else 1
        end as actual_sentiment
    from ranked
    where row_num = 1

)

select * from renamed
