-- Tabela de reviews, a partir do arquivo bruto
-- has_text: 0,2% vem vazio (confirmado no Audit) — mantém a linha, só marca
CREATE TABLE reviews AS
SELECT
    parent_asin,
    asin,
    user_id,
    rating,
    title,
    text,
    CASE WHEN text IS NULL OR trim(text) = '' THEN false ELSE true END AS has_text,
    timestamp,
    helpful_vote,
    verified_purchase
FROM read_json_auto('../data/raw/amazon/Beauty_and_Personal_Care.jsonl');
