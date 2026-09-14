-- Fase 6: Product Intelligence
-- Cria a tabela product_features a partir da products (Fase 4).
-- Objetivo: transformar dado bruto em sinais COMPARÁVEIS entre produtos
-- de categorias diferentes e com volumes de review diferentes.

CREATE TABLE product_features AS
SELECT
    parent_asin,
    title,
    store,
    main_category,
    price,
    has_price,
    average_rating,
    rating_number,

    -- price_percentile: posição do preço DENTRO da própria categoria (0 a 100)
    -- só calcula pra quem tem preço confirmado (has_price = true);
    -- produto sem preço fica NULL aqui, não zero (zero seria "mais barato
    -- de todos", o que é mentira — é ausência de dado, não é preço baixo)
    CASE
        WHEN has_price THEN
            ROUND(
                PERCENT_RANK() OVER (PARTITION BY main_category ORDER BY price) * 100,
                1
            )
        ELSE NULL
    END AS price_percentile,

    -- rating_bayesian: nota ajustada pelo volume de reviews (ver explicação
    -- acima). m=50 é o "quanto de peso" a média geral tem — produto com
    -- poucas reviews fica puxado pra média geral; produto com muitas reviews
    -- fica com a nota real dele. C (média geral) vem da subquery abaixo.
    ROUND(
        (rating_number / (rating_number + 50.0)) * average_rating +
        (50.0 / (rating_number + 50.0)) * (SELECT AVG(average_rating) FROM products),
        2
    ) AS rating_bayesian

FROM products;
