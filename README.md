# terraform-azure
<!-- ![](modern-datawarehouse.png) -->
```mermaid
  flowchart LR;
      subgraph Ingestão
        A[Event Hub]
      end
      subgraph Armazenamento
        B[Azure Data lake Storage Gen 2]
        A-->B
      end
      subgraph Prep e Treino
        C[Azure Data Factory]
        D[Azure Databricks]
        B-->C
        B-->D
      end
```