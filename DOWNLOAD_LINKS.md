# AI Shelf — Download Links (Fase 0)

Escopo confirmado: **Amazon Reviews 2023** é o core. Olist e IBGE/POF foram removidos
do core por confounding temporal (dados pré-pandemia vs. Amazon pós-pandemia) — ver
decisão registrada abaixo.

---

## 1. Amazon Reviews 2023 — Beauty_and_Personal_Care (PRINCIPAL)

Fonte oficial: https://amazon-reviews-2023.github.io/

- Reviews (23.9M ratings, 11.3M usuários, 1.0M itens):
  https://mcauleylab.ucsd.edu/public_datasets/data/amazon_2023/raw/review_categories/Beauty_and_Personal_Care.jsonl.gz

- Metadata dos produtos:
  https://mcauleylab.ucsd.edu/public_datasets/data/amazon_2023/raw/meta_categories/meta_Beauty_and_Personal_Care.jsonl.gz

Salvar em: `AI-SHELF/data/raw/amazon/`

Licença: Amazon Customer Reviews Terms of Use + licença MIT do repositório
(hyp1231/AmazonReviews2023 no GitHub). Uso acadêmico/portfólio é coberto.

Alternativa via Python (não precisa baixar manualmente o .gz):
```python
from datasets import load_dataset
reviews = load_dataset("McAuley-Lab/Amazon-Reviews-2023",
                        "raw_review_Beauty_and_Personal_Care",
                        split="full", trust_remote_code=True)
meta = load_dataset("McAuley-Lab/Amazon-Reviews-2023",
                     "raw_meta_Beauty_and_Personal_Care",
                     split="full", trust_remote_code=True)
```

---

## 2. Amazon Reviews 2023 — Grocery_and_Gourmet_Food (SECUNDÁRIO)

Usar só se o core (Beauty) já estiver validado e fizer sentido expandir categoria.

- Reviews (14.3M ratings, 603.2K itens):
  https://mcauleylab.ucsd.edu/public_datasets/data/amazon_2023/raw/review_categories/Grocery_and_Gourmet_Food.jsonl.gz

- Metadata:
  https://mcauleylab.ucsd.edu/public_datasets/data/amazon_2023/raw/meta_categories/meta_Grocery_and_Gourmet_Food.jsonl.gz

Salvar em: `AI-SHELF/data/raw/amazon/`

---

## 3. Google Trends (DEMANDA)

Não é arquivo — consulta ao vivo via `pytrends` (já no requirements.txt).
Sem problema de staleness (sempre atual). Usar depois de ter a taxonomia de
consumer needs pronta (Fase 6), para cruzar com search interest.

Doc: https://github.com/GeneralMills/pytrends

---

## Removido do core (decisão registrada — Fase 0)

### Olist Brazilian E-Commerce — REMOVIDO do core
Motivo: dados de 2016-2018 (pré-pandemia) vs. Amazon Reviews majoritariamente
pós-pandemia (2020-2023). Comparar os dois misturaria país + tempo ao mesmo
tempo, invalidando qualquer claim de "padrão de necessidade se repete entre
mercados". Licença também é CC BY-NC-SA 4.0 (não comercial) — outro motivo para
não usar em nada além de exploração pessoal, se for usado.
Se quiser retomar como apêndice opcional (não integrado ao pipeline principal):
https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

### IBGE / POF — REMOVIDO do core
Motivo: mesmo problema de staleness — microdados disponíveis são da edição
2017-2018 (POF 2024-2025 ainda em campo, sem liberação de microdados).
Se quiser consultar depois: https://www.ibge.gov.br/pof2024/
