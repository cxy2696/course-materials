COPY bars(id, manufacturer, company_location, year_reviewed, bean_origin, bar_name, cocoa_percent, num_ingredients, ingredients, review, rating) FROM '/Users/xinyi/Downloads/chocolate_bars.csv' DELIMITER ',' CSV HEADER;

select avg(rating) as average_rating from bars;

select manufacturer, count(*) as review_count from bars group by manufacturer order by review_count desc limit 1;

select count(*) as earthy_count from bars where review like '%earthy%';

select manufacturer from bars where cocoa_percent > 71 group by manufacturer having count(*) > 25;

select count(distinct bar_name) as bar_count from bars where bar_name not in (select distinct bar_name from bars where year_reviewed=2018);

select count(*) as review_pairs_count from bars b1 join bars b2 on b1.bar_name=b2.bar_name and b2.year_reviewed > b1.year_reviewed and b2.rating>b1.rating;

select count(distinct manufacturer) as manufacturer_count from bars where bean_origin=company_location;

select count(*) as review_pairs_count from bars b1 join bars b2 on b1.review=b2.review and b1.bar_name<>b2.bar_name and b1.id<b2.id;

with avg_cocoa as (select avg(cocoa_percent) as avg_cocoa_percent from bars), above_avg as (select avg(rating) as avg_rating_above from bars, avg_cocoa where cocoa_percent > avg_cocoa.avg_cocoa_percent), below_avg as(select avg(rating) as avg_rating_below from bars, avg_cocoa where cocoa_percent<avg_cocoa.avg_cocoa_percent) select (select avg_rating_above from above_avg) as avg_rating_above, (select avg_rating_below from below_avg) as avg_rating_below;

with years as (select distinct year_reviewed from bars), bar_years as (select bar_name, count(distinct year_reviewed) as review_years_count from bars group by bar_name) select count(*) from bar_years, (select count(distinct year_reviewed) as total_years from years) as total where bar_years.review_years_count=total.total_years;
