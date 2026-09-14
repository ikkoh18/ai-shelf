-- Tabela de produtos, a partir do metadata bruto
-- price: try_cast vira número onde dá, NULL onde não dá (sem preço + ~0,02% sujo)
-- has_price: guarda o sinal de "tinha preço informado" antes do try_cast
CREATE TABLE products AS
SELECT
    parent_asin,
    title,
    store,
    main_category,
    categories,
    average_rating,
    rating_number,
    try_cast(price AS DOUBLE) AS price,
    CASE WHEN try_cast(price AS DOUBLE) IS NOT NULL THEN true ELSE false END AS has_price
FROM read_json_auto('../data/raw/amazon/meta_Beauty_and_Personal_Care.jsonl', sample_size=-1);

