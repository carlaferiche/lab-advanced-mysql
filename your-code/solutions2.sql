use publications;
-- Challenge 1

select c.title_id, a.advance, a.royalty, a.price, b.au_id, b.royaltyper, c.qty, a.advance * b.royaltyper/100 as advance2, a.price * c.qty * a.royalty/100 * b.royaltyper/100 as sales_royalty
from titles as a
left join titleauthor as b
on a.title_id = b.title_id
left join sales as c
on a.title_id = c.title_id;

select au_id, title_id, ROUND(SUM(sales_royalty)) as total_roy,
ROUND(AVG(advance2)) as advance
FROM 
(select c.title_id, a.advance, a.royalty, a.price, b.au_id, b.royaltyper, c.qty, a.advance * b.royaltyper/100 as advance2, a.price * c.qty * a.royalty/100 * b.royaltyper/100 as sales_royalty
from titles as a
left join titleauthor as b
on a.title_id = b.title_id
left join sales as c
on a.title_id = c.title_id) sol_2
group by au_id, title_id;


SELECT au_id, ROUND(SUM(total_roy + advance)) as total_profit_author
FROM 
(select au_id, title_id, ROUND(SUM(sales_royalty)) as total_roy,
ROUND(AVG(advance2)) as advance
FROM 
(select c.title_id, a.advance, a.royalty, a.price, b.au_id, b.royaltyper, c.qty, a.advance * b.royaltyper/100 as advance2, a.price * c.qty * a.royalty/100 * b.royaltyper/100 as sales_royalty
from titles as a
left join titleauthor as b
on a.title_id = b.title_id
left join sales as c
on a.title_id = c.title_id) sol_2
group by au_id, title_id) sol_3
GROUP BY au_id
ORDER BY total_profit_author desc
limit 3;


-- Challenge 2

select * from authors;
select * from titles;
select * from titleauthor;
select * from sales;


CREATE TEMPORARY TABLE sol1
select c.title_id, a.advance, a.royalty, a.price, b.au_id, b.royaltyper, c.qty, a.advance * b.royaltyper/100 as advance2, a.price * c.qty * a.royalty/100 * b.royaltyper/100 as sales_royalty
from titles as a
left join titleauthor as b
on a.title_id = b.title_id
left join sales as c
on a.title_id = c.title_id;

select * from sol1;


CREATE TEMPORARY TABLE sol2
select au_id, title_id, ROUND(SUM(sales_royalty)) as total_roy,
ROUND(AVG(advance2)) as advance
FROM sol1
group by au_id, title_id;

select * from sol2;

CREATE TEMPORARY TABLE sol3
SELECT au_id, ROUND(SUM(total_roy + advance)) as total_profit_author
FROM sol2
GROUP BY au_id
ORDER BY total_profit_author desc
limit 3;

select * from sol3;

-- Challenge 3
	
DROP TABLE IF EXISTS most_profiting_authors;

CREATE TABLE most_profiting_authors(
	au_id varchar(255),
    profits int
);

INSERT INTO most_profiting_authors VALUES
("213-46-8915", 12162),
("722-51-5454", 11272),
("998-72-3567", 7226);

CREATE TABLE most_profiting_authors2 
SELECT * FROM sol3; 

SELECT * FROM most_profiting_authors2;

