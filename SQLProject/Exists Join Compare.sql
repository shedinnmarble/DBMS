CREATE TABLE #titles(
    title_id       varchar(20),
    title          varchar(80)       NOT NULL,
    type           char(12)          NOT NULL,
    pub_id         char(4)               NULL,
    price          money                 NULL,
    advance        money                 NULL,
    royalty        int                   NULL,
    ytd_sales      int                   NULL,
    notes          varchar(200)          NULL,
    pubdate        datetime          NOT NULL
 )
 GO

 insert #titles values ('1', 'Secrets',   'popular_comp', '1389', $20.00, $8000.00, 10, 4095,'Note 1','06/12/94')
 insert #titles values ('2', 'The',       'business',     '1389', $19.99, $5000.00, 10, 4095,'Note 2','06/12/91')
 insert #titles values ('3', 'Emotional', 'psychology',   '0736', $7.99,  $4000.00, 10, 3336,'Note 3','06/12/91')
 insert #titles values ('4', 'Prolonged', 'psychology',   '0736', $19.99, $2000.00, 10, 4072,'Note 4','06/12/91')
 insert #titles values ('5', 'With',      'business',     '1389', $11.95, $5000.00, 10, 3876,'Note 5','06/09/91')
 insert #titles values ('6', 'Valley',    'mod_cook',     '0877', $19.99, $0.00,    12, 2032,'Note 6','06/09/91')
 insert #titles values ('7', 'Any?',      'trad_cook',    '0877', $14.99, $8000.00, 10, 4095,'Note 7','06/12/91')
 insert #titles values ('8', 'Fifty',     'trad_cook',    '0877', $11.95, $4000.00, 14, 1509,'Note 8','06/12/91')
 GO


CREATE TABLE #sales(
    stor_id        char(4)           NOT NULL,
    ord_num        varchar(20)       NOT NULL,
    ord_date       datetime          NOT NULL,
    qty            smallint          NOT NULL,
    payterms       varchar(12)       NOT NULL,
    title_id       varchar(80)
)
 GO
insert #sales values('1', 'QA7442.3', '09/13/94', 75, 'ON Billing','1')
insert #sales values('2', 'D4482',    '09/14/94', 10, 'Net 60',    '1')
insert #sales values('3', 'N914008',  '09/14/94', 20, 'Net 30',    '2')
insert #sales values('4', 'N914014',  '09/14/94', 25, 'Net 30',    '3')
insert #sales values('5', '423LL922', '09/14/94', 15, 'ON Billing','3')
insert #sales values('6', '423LL930', '09/14/94', 10, 'ON Billing','2')


SELECT    title, price
FROM      #titles t
WHERE     EXISTS
(SELECT   *
FROM      #sales s
WHERE     s.title_id = t.title_id
AND       qty >30)


    SELECT    t.title, t.price
    FROM     #titles t
    inner join #sales s on t.title_id = s.title_id
    where s.qty >30 
    
    
    select null;